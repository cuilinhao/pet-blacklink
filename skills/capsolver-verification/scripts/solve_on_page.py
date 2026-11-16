#!/usr/bin/env python3
"""Inspect or solve one CAPTCHA in an existing, precisely selected CDP tab."""
from __future__ import annotations

import argparse
import asyncio
from dataclasses import asdict, replace
import hashlib
import json
import logging
from pathlib import Path
import re
from urllib.parse import urlsplit, urlunsplit

ROOT = Path(__file__).resolve().parents[1]


def safe_url(raw):
    """Omit URL credentials and query/fragment data; the path is still retained."""
    u = urlsplit(raw)
    host = u.hostname or ''
    if ':' in host:
        host = '[' + host + ']'
    if u.port:
        host += ':' + str(u.port)
    return urlunsplit((u.scheme, host, u.path, '', ''))


def redact(text, secrets=()):
    value = str(text)
    for secret in secrets:
        if secret:
            value = value.replace(secret, '[REDACTED]')
    value = re.sub(r'https?://[^\s\"\'<>]+', lambda m: safe_url(m.group()), value)
    value = re.sub(r'CAP-[A-Za-z0-9_-]+', '[CAPSOLVER_KEY]', value)
    return re.sub(r'[\w.+-]+@[\w.-]+\.[A-Za-z]{2,}', '[ACCOUNT]', value)


def select_page(pages, url_fragment):
    matches = [p for p in pages if url_fragment in p.url]
    if len(matches) != 1:
        raise ValueError(f'Target must match exactly one page; matched {len(matches)}. Supply the inspected target ID.')
    return matches[0]


async def target_id_for(page):
    session = await page.context.new_cdp_session(page)
    try:
        info = await session.send('Target.getTargetInfo')
        return info['targetInfo']['targetId']
    finally:
        await session.detach()


def checkpoint_id(target_id, page_url, infos):
    """Bind a checkpoint to the actual tab, page state and every SDK widget field."""
    state = {'target_id': target_id, 'page_url': page_url,
             'widgets': [asdict(info) for info in infos]}
    encoded = json.dumps(state, sort_keys=True, separators=(',', ':'), ensure_ascii=False)
    return hashlib.sha256(encoded.encode()).hexdigest()


async def inspected_infos(cap, driver):
    # Enforce sanitation on the actual info passed to solve, not only Page.url.
    return [replace(info, website_url=safe_url(info.website_url))
            for info in await cap.get_captcha_info(driver)]


def result_status(results):
    if not results:
        return 'no_supported_captcha'
    if all(item.filled and not item.error for item in results):
        return 'token_filled'
    return 'failed'


def managed_challenge(state):
    """Recognize one common full-page layout, not every Cloudflare challenge."""
    return bool(state.get('cloudflare_iframe') and not state.get('turnstile_widget')
                and not state.get('recaptcha_widget')
                and re.search(r'just a moment|verify you are human|checking your browser', state.get('title', ''), re.I))


class PrivatePage:
    """SDK adapter: omit URL query, fragment, and userinfo from outgoing tasks."""
    def __init__(self, page):
        self.page = page

    @property
    def url(self):
        return safe_url(self.page.url)

    async def evaluate(self, script, arg=None):
        from playwright.async_api import Error

        try:
            return await self.page.evaluate(script, arg)
        except Error as exc:
            from capsolver_core.browser.inject.recaptcha import FILL_RECAPTCHA_JS

            assignment = 'textarea.innerHTML = args.token;'
            known_failure = ("Failed to set the 'innerHTML' property" in str(exc)
                             and "requires 'TrustedHTML' assignment" in str(exc))
            if (script != FILL_RECAPTCHA_JS or not known_failure
                    or script.count(assignment) != 1):
                raise
            # The rejected sink precedes the SDK's value assignment and callback.
            # Retry once with the same in-memory token and official selector/callback
            # code; textContent treats it as plain text without weakening CSP.
            compatible_script = script.replace(assignment, 'textarea.textContent = args.token;', 1)
            return await self.page.evaluate(compatible_script, arg)

    async def wait_for_selector(self, selector, **kwargs):
        return await self.page.wait_for_selector(selector, **kwargs)


async def main(args):
    from dotenv import dotenv_values
    from playwright.async_api import async_playwright
    from capsolver_core import create_capsolver
    from capsolver_core.browser.adapter import to_driver

    stage = 'configuration'
    secrets = []
    output = {'submitted': False, 'business_success': False, 'paid_request': False}
    try:
        key = dotenv_values(ROOT / '.env', interpolate=False).get('CAPSOLVER_API_KEY') or ''
        secrets.append(key)
        stage = 'connect'
        async with async_playwright() as pw:
            browser = await pw.chromium.connect_over_cdp(f'http://127.0.0.1:{args.cdp}', timeout=15000)
            pages = [p for c in browser.contexts for p in c.pages]
            stage = 'select_page'
            if args.page_id:
                found = []
                for candidate in pages:
                    if await target_id_for(candidate) == args.page_id:
                        found.append(candidate)
                if len(found) != 1:
                    raise ValueError('Inspected target ID is unavailable; inspect the current browser again.')
                page = found[0]
                if args.page_url not in page.url:
                    raise ValueError('Target ID no longer matches the inspected URL.')
            else:
                page = select_page(pages, args.page_url)
            target_id = await target_id_for(page)
            output['page_id'] = target_id
            output['url'] = safe_url(page.url)
            stage = 'page_precheck'
            state = await page.evaluate('''() => ({
                title: document.title,
                cloudflare_iframe: !!document.querySelector('iframe[src*="challenges.cloudflare.com"]'),
                turnstile_widget: !!document.querySelector('.cf-turnstile, [name="cf-turnstile-response"]'),
                recaptcha_widget: !!document.querySelector('[name="g-recaptcha-response"], iframe[src*="recaptcha"]')
            })''')
            if managed_challenge(state):
                return {**output, 'status':'blocked', 'stage':stage,
                        'error':'Full-page Cloudflare challenge is outside this token workflow. Record pending; do not retry the solver.'}, 2
            stage = 'detect'
            driver = to_driver(PrivatePage(page))
            async with create_capsolver(api_key=key, default_timeout=120, request_timeout_ms=20000) as cap:
                infos = await inspected_infos(cap, driver)
                secrets.extend(value for info in infos
                               for value in (info.s, info.cdata, info.proxy) if value)
                signature = checkpoint_id(target_id, page.url, infos)
                output['challenge_id'] = signature
                output['captcha'] = [{'type':str(i.type), 'enterprise':bool(i.enterprise),
                                      'session_bound_payload':bool(i.s or i.cdata),
                                      'website_url':i.website_url} for i in infos]
                if not infos:
                    return {**output, 'status':'no_supported_captcha', 'stage':stage,
                            'error':'No supported widget detected. Inspect the page; this does not establish verification success.'}, 2
                if not args.solve:
                    return {**output, 'status':'inspected', 'stage':stage, 'paid_request':False}, 0
                if not key.startswith('CAP-'):
                    raise ValueError('Configure CAPSOLVER_API_KEY in the private .env file first.')
                if args.challenge_id != signature:
                    raise ValueError('Challenge changed or authorization checkpoint missing. Inspect the current challenge again.')
                if len(infos) != 1:
                    raise ValueError('More than one CAPTCHA detected. Resolve the intended widget before a paid call.')
                info = infos[0]
                handler = cap.get_handler(info.type)
                if handler is None or not callable(getattr(handler, 'fill', None)):
                    raise ValueError('No SDK handler can fill the inspected CAPTCHA. No solve requested.')
                stage = 'solve'
                output['paid_request'] = True
                # Public SDK methods solve only this checked descriptor. The page-wide
                # solve_on_page method would detect again and may solve another widget.
                solution = await cap.solve(info)
                secrets.append(solution.token)
                stage = 'verify_before_fill'
                current_infos = await inspected_infos(cap, driver)
                current_target_id = await target_id_for(page)
                if checkpoint_id(current_target_id, page.url, current_infos) != signature:
                    raise ValueError('Page or CAPTCHA changed while solving; token not filled. Inspect the page; do not retry automatically.')
                stage = 'fill'
                filled = bool(await handler.fill(driver, solution, info))
                output['results'] = [{'type':str(info.type), 'filled':filled, 'error':None}]
                status = 'token_filled' if filled else 'failed'
                next_action = ('Inspect the page. If it is still waiting, submit the authorized form once; verify the actual site response.'
                               if filled else 'Token was not filled. Inspect the current page; do not retry automatically.')
                return {**output, 'status':status, 'stage':stage,
                        'next_action':next_action}, 0 if filled else 2
            # Leave the user's browser running; Playwright stops only its connection.
    except Exception as exc:
        return {**output, 'status':'failed', 'stage':stage, 'error':redact(exc,secrets)}, 2


if __name__ == '__main__':
    logging.getLogger('capsolver_core').setLevel(logging.ERROR)
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cdp', type=int, required=True)
    parser.add_argument('--page-url', required=True, help='Observed URL or unambiguous fragment; omit sensitive query values.')
    parser.add_argument('--page-id', help='Observed CDP Target ID when URL selection is ambiguous.')
    parser.add_argument('--solve', action='store_true', help='Make a paid solve after current challenge authorization.')
    parser.add_argument('--challenge-id', help='Exact ID returned by the current inspection.')
    args = parser.parse_args()
    if not 1 <= args.cdp <= 65535:
        parser.error('--cdp must be a valid local TCP port')
    result, code = asyncio.run(main(args))
    print(json.dumps(result, ensure_ascii=False))
    raise SystemExit(code)
