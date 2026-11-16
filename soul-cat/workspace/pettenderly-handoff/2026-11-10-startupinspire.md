# Outcome recorded: StartupInspire / startupinspire.com (deferred, uncounted, auth-registration-required)

**Exact source key:** `success-1104-daohang-613-final.csv::startupinspire.com::startupinspire.com`  
**Status:** deferred, counted=no  
**At:** 2026-11-10 **13:14 Asia/Shanghai (UTC+8)** `--goal 37`  
**Final URL / evidence:** https://www.startupinspire.com/login  
**Screenshots:** `/workspace/pettenderly-handoff/2026-11-10-startupinspire-google-error.png` (exact “Email not found in our database. Please register.”) and `/workspace/pettenderly-handoff/2026-11-10-startupinspire-free-pricing.png` (live Free **€0** / one startup / permanent listing / no instant approval / manual review usually 3 to 7 business days).

Live official Free path was confirmed. Native brand/domain searches each 0. Official Google basic profile/email completed; the site then rejected login and required registration. **No registration, listing, draft, payment, or newsletter.** This is **not** a Google-preference skip. Vault host-context binding remains unresolved; **do not retry, bypass, or start a new StartupInspire auth or email/password signup route.** The required country field was not verified live because sign-in was blocked; official pack has no country — do not invent. Counts unchanged after this deferral.

This file retains the earlier research notes below; the recorded outcome above is authoritative. Those notes must not be used to open a new auth path for this row.

---

# Official research: StartupInspire / startupinspire.com (current official gate after ScriptByAI skip)

**Exact source key:** `success-1104-daohang-613-final.csv::startupinspire.com::startupinspire.com`  
**CSV / platform URL:** https://startupinspire.com (canonical host redirects to **https://www.startupinspire.com/**)  
**Official submit (create):** https://www.startupinspire.com/startup/create  
**Official pricing:** https://www.startupinspire.com/pricing  
**Official signup / login / password recover / activate:** https://www.startupinspire.com/signup , https://www.startupinspire.com/login , https://www.startupinspire.com/password-recover , https://www.startupinspire.com/activate-account  
**Official catalog / search / FAQ / terms / contact / about:** https://www.startupinspire.com/startups , https://www.startupinspire.com/search , https://www.startupinspire.com/faq-frequently-asked-questions , https://www.startupinspire.com/terms , https://www.startupinspire.com/contact , https://www.startupinspire.com/about  
**Connector / plugin:** **none**. SearchPlugins unmatched for startupinspire.com / StartupInspire directory submit (unrelated catalog plugins only; Connect Apps fallback is not a directory connector).

The site is a client-rendered Angular app (same 17 KB shell on most routes). Official robots.txt allows `/` and advertises `https://startupinspire.com/api/sitemap.xml` (that URL currently redirects to the `/404` shell). Robots also `Disallow: /api/`, `/login`, `/register`, and `/user/` on the main host. Public listing reads used by the site itself go to **https://api.startupinspire.com/** (different host). This research used official public pages, the public main JS bundle, and those official public listing GETs. No browser, auth, outreach, or payment was started.

## Official counts after the ScriptByAI ineligible skip (do not recount)

Verified after the 2026-11-10 **13:07 Asia/Shanghai (UTC+8)** scriptbyai.com skipped terminal uncounted ineligible, with `resume_gate.rb --website Pettenderly --today 2026-11-10 --expect-next-source-key success-1104-daohang-613-final.csv::startupinspire.com::startupinspire.com`:

- `RESUME_GATE=PASS`
- `next_source_key=success-1104-daohang-613-final.csv::startupinspire.com::startupinspire.com`
- `next_platform=startupinspire.com`
- `next_url=https://startupinspire.com`
- Batch **24/50** remaining **26** (`--goal 37` is remaining-of-batch, not a new daily 50)
- Lifetime `historical_counted_rows=**95**`
- Nov9 calendar counted **13** (frozen)
- Nov10 calendar `已提交` **11**
- `active_handled_rows=119` / 596 remaining 477
- Nov10 counted platforms unchanged: highrankdirectory.com, bai.tools, firsto.co, lachief.io, theainavigator.com, ki-suche.io, startupbuffer.com, toolsforhumans.ai, submissionwebdirectory.com, waildworld.com, aitoolboard.com

Just recorded (uncounted): `success-1104-daohang-613-final.csv::scriptbyai.com::scriptbyai.com` skipped **13:07 Asia/Shanghai (UTC+8)** terminal **ineligible**. Official https://www.scriptbyai.com/submit-resources/ accepts only free or freemium tools; Pettenderly official pack is Paid / `free_plan` false. Paid tools are sent to a sister site with paid inclusion — do not pay. Handoff `/workspace/pettenderly-handoff/2026-11-10-scriptbyai.md`.

## Official free path (research; confirm live)

StartupInspire is a general startup gallery (“More than 30,000 startups submitted. Submit your Startup now for free.”; nav includes **Markets** with official link **AI** / `artificial-intelligence`, plus Technology, Business, Marketing, and others). Pettenderly, an AI pet-portrait product, is a topical fit for a general startup directory. Confirm the live market/category list before choosing; prefer official **AI** (and Technology if a second official option is allowed). Do not invent a Pets tag.

Official FAQ and the official pricing-plan array both state a **Free** plan:

- FAQ “Is there a fee to submit my startup?”: “We offer a **free tier** and four paid options, all one-time payments. The **Free plan lets you submit one startup subject to review.**”
- FAQ “How can I submit my startup…?”: “To submit your startup, simply **create a free account** and fill out the required information… Once submitted, your startup will be reviewed by our team.”
- FAQ “Will my startup be automatically published after submission?”: “**On the Free plan, submissions go through a manual review before publishing.** … On paid plans (Starter, Standard, Pro, API) your startup is published immediately without waiting for a review.”
- FAQ “How long does the review process take?”: “**Free plan submissions are typically reviewed within 3 to 7 business days.** If your submission is not selected, you will receive feedback… To skip the queue entirely and get your startup live immediately, upgrade to any paid plan.” — **Do not upgrade or pay.**
- Pricing-array **Free** (`id` "1", `price` **"0.00"**, “For 1 startup”): “No instant approval: every submission is reviewed manually before it is published (usually 3 to 7 business days).” Features: Submit 1 startup **yes**; Instant Approval **no**; Permanent listing **yes**; Displayed on other product pages **no**; Featured badge and highlight **no**; Home page visibility and traffic **no**; Permanent descriptive page **yes**.

Paid upsells exist on official `/pricing` (do **not** select or pay). The live plan array in the official bundle currently lists Starter **5.00**, Growth **19.00**, Standard **39.00**, legacy Premium **39.00**, Pro **79.00**, discontinued API **99.00**/year, with Stripe / PayPal / cards. Official FAQ copy still quotes different figures in places (Starter **9 EUR** in one answer and **8 EUR** in another; Standard **29 EUR**; API **199 EUR** per year). **Confirm every live price on `/pricing`. Use only the Free / 0.00 path.** Do not start checkout.

Count only a clear submitted / submitted-pending-review / in-queue receipt (Free plan is review-pending, not immediately public). If confirmation is missing or ambiguous, defer uncounted; do not guess a count. Do not treat a paid “instant publish” as required.

## Account (required for the official free path)

A free account is required. Official `/signup` (email/password) researched fields: **user_email** (required; disposable-email check exists); **password** and **confirmPassword** (required; official pattern at least 8 characters with uppercase, lowercase, and a number); **acceptTerms** required; **newsletter** defaults to **false** — leave it off, do not subscribe. Official `/login` uses email + password and “Forgot password?”.

Official **Google Identity** buttons are present on both login and signup (`accounts.google.com/gsi/client`). Google is generally authorized and trusted for this campaign, **basic profile/email scopes only** — no broad scopes. Login-with-Google researched copy if the email is new: “Email not found in our database. Please register.” Do not invent a non-Google social path.

Do not skip merely because a free account or Google appears. Email: sanctioned **OfferEmailAddress** if offered; otherwise official pack contact **support@soulpaw.art**. If a name is asked: **sadik** (authorized submitter firstName only, not a founder/CEO; `business_facts.founder_name` is null). Use **sadik Yenice** only if a last name is clearly required. The create form can add a founder; **leave founders blank** — do not invent a Founder/CEO.

If a password must be stored, use a sanctioned Vault save kind=login **once** on this official same-host sign-up. **Vault host-context binding remains unresolved** (persistent mismatch to www.lachief.io). **No bypass, no repeated diagnostics** (healthy 11/11 already known), no invent-and-keep a password outside Vault. If Vault save-login is refused, defer uncounted once and stop. Do not retry EveryAI / AI Hunter / AgentLocker faults, and do not change auth methods to work around a Vault fault.

## Researched create-form fields (confirm every visible label live)

Official `/startup/create` form group (Ninja/Angular). Use official pack material only. Leave optional fields blank when the pack has no value. **Do not invent a product fact, and do not invent the absence of one.**

- **startup_name** (required): **Pettenderly**
- **startup_headline** (required): official tagline / one-liner / short description as the live label fits — official pack only, do not invent a new hook
- **page_url** (required slug): **pettenderly** (confirm live; do not invent a different slug if the official one is accepted)
- **startup_description** (required; official validator is a **max length of 1000** characters after HTML strip, not a 1000 minimum): official medium (264) and/or official long if needed and still under 1000. Do not use CN unless a live locale requires it and you use official CN copy only. Do not pad with invented text.
- **startup_technology** (required): confirm the live control. Use only official pack wording if a free-text or official option matches (do not invent a stack, framework, or model name). If the live field requires a value the pack does not officially provide, **do not invent** — stop and do not submit.
- **startup_email** (required): sanctioned OfferEmailAddress if offered; otherwise **support@soulpaw.art**
- **startup_url** (required, `https?://` URL): **https://pettenderly.com/**
- **country** (required): official pack has **no country**. **Do not invent one.** If the live field remains required with no official pack value, stop and do not submit (defer uncounted for missing official fact, or confirm with the parent before any guess).
- **markets** (required): prefer official **AI** if still listed live; add another official listed market only if the live form allows it and it is an official fit. Do not invent markets.
- **launch_status** (required; official options: “Launched soon” / “Launched” / “Not launched”). Official pack `launch_date` / `founding_date` are **null**. The product site is live; if the live options still include **Launched**, that is the factual current status — still **leave launch_date blank**. Do not invent a date.
- Optional: **linkedin**, **twitter**, **producthunt**, **backlink_url**, **startup_logo**, **skills**. Official `social_links` is empty — leave socials blank. Leave **backlink_url** blank (do not add a reciprocal link). Logo: official `/Users/pgy/Documents/backlink-workspace/soul-cat/assets/logos/pettenderly-logo-512.png` if an upload is offered. Do not invent skills or milestones.

An “Upgrade Account” modal and paid plan routes (`/pricing`, `/dashboard/plan`) must not be used. Submit **once** on the Free plan only.

## Duplicate search (research; re-check live before submit)

Official public API (same calls the `/startup/:slug` page makes):

- https://api.startupinspire.com/startups/slug/pettenderly → `{"error":"Entity not found"}`
- https://api.startupinspire.com/startups?page_url=pettenderly&_start=0&_limit=5 → `[]`
- https://api.startupinspire.com/startups?page_url=pettenderly.com&_start=0&_limit=5 → `[]`

`https://www.startupinspire.com/startup/pettenderly` prerenders that same “Entity not found” payload (not a public listing). A generic `?q=pettenderly` API list returned unrelated latest startups and does **not** appear to be a reliable name filter — do not treat it as a hit or a miss. Re-check the official slug and `page_url` queries live. If a listing already exists, do not submit a duplicate. The Free plan allows **one** startup.

## Route (authorized later; this research turn did not browse or submit)

1. Re-check official slug / `page_url` queries for Pettenderly and pettenderly.com. Stop if already listed.
2. Open https://www.startupinspire.com/pricing and confirm **Free / 0.00 / submit 1 startup / manual review**. Do not start Starter, Growth, Standard, Premium, Pro, API, ads-manager, or any Stripe/PayPal checkout.
3. Create or sign in on official `/signup` or `/login` (Google basic or email/password + Vault rules above), then open https://www.startupinspire.com/startup/create.
4. Stay on the **Free** plan. Fill official pack fields only. Do not invent country, technology, founder, or socials. Click **Submit Startup** exactly **ONCE**. Do not resubmit.
5. Capture the exact confirmation URL and wording plus a screenshot under `/workspace/pettenderly-handoff/`. Pending review (3–7 business days per FAQ) is not public. If an unexpected captcha cannot be completed, defer uncounted once; do not loop. IA.cool’s declined captcha remains **FINAL for that row only**.

## Stop / skip / defer rules for this row

- Do not pay, do not outreach, do not add a reciprocal backlink, do not subscribe to the newsletter, do not change a site badge.
- Do not skip merely because a free account or Google appears, and do not skip as paid-only while the official Free / 0.00 / one-startup review plan stands.
- If live official pages remove the Free plan and leave only paid plans, skip paid-only with official evidence and do not pay.
- If already listed, or if the one free startup quota is already used, do not submit a paid extra listing.
- If a required field has no official pack value (especially **country** or **startup_technology**) and cannot be left blank, defer uncounted; do not invent.
- If Vault or auth cannot be completed without bypass or broad OAuth scopes, defer uncounted once and stop.
- Do not retry: AI Hunter certificate warning; AgentLocker Clerk/auth or its fallbacks; EveryAI Vault save-login; future-pedia.com OAuth / redirect_uri_mismatch; directorioia.com; ia.cool captcha; aisupersmart interstitial; ailib.ru; ebool expired approval; or a BAI / Submission Web Directory / Waild World / AI Parabellum / AIToolboard / Wavel / ListMyAI / ScriptByAI resubmit or payment.

## After the browser (parent / records)

Record with official `records/record_outcome.py` on the Mac workspace `/Users/pgy/Documents/backlink-workspace/soul-cat`, `--website Pettenderly` (capital P), `--date 2026-11-10`, actual `--at` (never backdate to 2026-11-09), `--goal 37`. Then `resume_gate.rb --website Pettenderly --today 2026-11-10 --expect-next-source-key` for the next cursor. Copy the updated handoff, screenshot, and receipt to Mac `workspace/pettenderly-handoff/` and the box/store mirrors. Counts stay 24/50 remaining 26 lifetime 95 Nov10 11 Nov9 13 until a new counted receipt is recorded.

This file is a research handoff only. No browser, auth, outreach, payment, retry, or bypass was started in this research turn.
