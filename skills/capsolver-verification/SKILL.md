---
name: capsolver-verification
description: Use when a user requests the CapSolver SDK method for a visible reCAPTCHA or embedded Turnstile challenge in an existing browser, including Hubstudio environments, or asks to resume that verification workflow.
---

# CapSolver verification

Use the official `capsolver-core` token workflow from the user's [Feishu procedure](https://icnqpu3z244v.feishu.cn/wiki/M2L2wUWayiCve0k76spczHnNn5g). Its local executable is `scripts/solve_on_page.py`; the SDK reference is [Core SDK](https://docs.capsolver.com/en/guide/ai/core-sdk/).

## Before a solve

Identify the exact browser environment, target tab, current account, and challenge from fresh UI evidence. Hubstudio instances can share an app bundle ID; native app selection can repeatedly address a different instance. Use the existing instance's observed CDP port and target ID when the user has requested this CDP workflow. Rediscover ports after browser restarts; never use a remembered port as proof of environment identity.

Run commands from this skill's directory with its `.venv/bin/python`. The helper loads the CapSolver key only from this skill's `.env` (mode 600); inherited environment keys and variable interpolation are ignored. Never put keys in command-line arguments. Preserve the user's chosen login and 2FA method. For `account----password----recovery_email----base32_totp` rows, recovery email is third and the TOTP secret is fourth.

Check the visible challenge before execution. A full-page Cloudflare Managed Challenge is outside this workflow, even if the helper's narrow title/iframe heuristic does not recognize it. Inspect the URL's retained host/path for sensitive identifiers; only userinfo, queries, and fragments are removed automatically.

The skill grants no new authority. Follow the active tool's requirements for the currently visible CAPTCHA, third-party data transmission, and any final submission. A prior confirmation for another challenge does not authorize a changed challenge. Explain any required confirmation by naming the actual tool requirement.

## Execute

1. Run an inspection against the observed target:

   ```bash
   .venv/bin/python scripts/solve_on_page.py --cdp OBSERVED_PORT --page-url OBSERVED_SAFE_URL_FRAGMENT --page-id OBSERVED_TARGET_ID
   ```

   `--page-id` is required to disambiguate multiple URL matches and preferred for every run. Inspection reports the actual `page_id`, a `challenge_id` bound to that target, the current page URL and all inspected SDK widget fields, plus whether session-bound parameters are present. Inspection makes no paid solver request. SDK detection may prepare DOM IDs or page callbacks.

2. Once the current challenge is authorized, repeat the command with `--solve --challenge-id ID_FROM_INSPECTION` and the inspected `page_id`. The helper calls the official `solve(info)` for exactly one checked descriptor, then its official handler's `fill(driver, solution, info)`. It rechecks the page and widget before filling. The SDK may retry transport failures; a checkpoint is not an idempotency key. Do not repeat a call after an uncertain paid result.

   If the exact official reCAPTCHA fill script fails because `innerHTML` requires `TrustedHTML`, the helper retries that fill once using `textContent` plus the existing `value` assignment. SDK selectors and callback behavior are preserved; Trusted Types/CSP stay enforced and no policy is created. The retry reuses the solved token only in the same process's memory, makes no second solver call, and stops on any further error. A process that already exited cannot recover its previous token through this retry.

3. Read the resulting page. `token_filled` and `filled=true` indicate token insertion only. SDK fill can invoke the site's callback, so inspect for navigation before submitting the authorized form once if still needed. Confirm the actual site response. Password, OTP, recovery, terms, and key creation follow the original task's scope.
4. Record the real checkpoint and continue the original task. Log account sequence, environment, stage, and result; omit passwords, OTPs, API keys, CAPTCHA tokens, and URL query values.

## Interpret results

| Result | Action |
|---|---|
| `inspected` | Check target and authorization before the paid call. |
| `token_filled` | Inspect; submit once if still needed; verify the site's response. |
| `no_supported_captcha` | Inspect loading/frame/support state; never count this as passed. |
| `page_precheck` blocked | Recognized full-page Cloudflare layout: record pending. A negative precheck does not prove support. |
| Ambiguous/missing target | Re-identify the exact tab; never pick the first match. |
| Changed checkpoint or failed fill | Inspect the new state; do not follow a submission step or retry automatically. |
| Site rejection after fill | Record the actual rejection; a solver response does not establish account ownership. |

The wrapper normalizes each descriptor's `website_url` before output and solving. Host/path remain visible; required widget parameters such as `s` and `cdata` remain in the solver task. This is not full anonymization. It uses official SDK detection and filling with the narrow TrustedHTML compatibility retry above, clicks no submit button, and never reports business success. No full-page Cloudflare or implicit-widget fallback is claimed.

## Observed Google login result

On 2026-09-12, a Hubstudio Chromium 144 Google login reCAPTCHA Enterprise widget exposed the official SDK's `innerHTML` incompatibility. The narrow `textContent` compatibility fallback was verified under enforced Trusted Types and then successfully filled the live widget. Google nevertheless returned “Something went wrong”; its alternative verification entry then reported that account ownership could not be verified. Treat this as a rejected login requiring user recovery, not a completed CAPTCHA or a reason for repeated paid solves. The local tests prove helper behavior, not acceptance by Google.

## Local setup

Use a working Python 3.10+ virtual environment and install `capsolver-core[playwright]`, `python-dotenv`, and `PyYAML` from the official project/registry. Connecting over CDP reuses the existing browser and needs no separate Chromium download. For command downloads on macOS, inspect the current system proxy instead of copying a stale proxy port from an example. Keep `.env`, `.venv`, and runtime artifacts out of Git.
