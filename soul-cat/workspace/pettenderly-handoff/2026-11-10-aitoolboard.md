# Outcome recorded: AIToolboard / aitoolboard.com (counted)

**Exact source key:** `success-1104-daohang-613-final.csv::aitoolboard.com::aitoolboard.com`  
**Status:** submitted-pending-review, terminal, counted=yes  
**At:** 2026-11-10 **12:58 Asia/Shanghai (UTC+8)** `--goal 37`  
**Exact receipt:** “Tool submitted successfully! It will be reviewed by our team.” (native alert; no receipt-page screenshot)  
**Post-submit URL (receipt JSON):** https://aitoolboard.com/my-account?tab=tools  
**Final URL after optional account-management redirect:** https://aitoolboard.com/login?redirect=/my-account  
**Evidence:** `/workspace/pettenderly-handoff/2026-11-10-aitoolboard-receipt.json`; screenshot `/workspace/pettenderly-handoff/2026-11-10-aitoolboard-final-signup.png` is the later optional login/signup page only, **not** the receipt.

Guest **Free Listing** submitted **ONCE**. Native brand/domain search each 0 / “No tools found.” Pending, not public. The post-submit login/signup screen was optional account management only: no credentials, no account created. The guest receipt is the success; an account was not required.

This file retains the research route and live-execution notes below; the recorded outcome above is authoritative.

---

# Browser route: AIToolboard / aitoolboard.com (current official gate)

**Exact source key:** `success-1104-daohang-613-final.csv::aitoolboard.com::aitoolboard.com`  
**CSV / platform URL:** https://aitoolboard.com/  
**Official free submit:** https://aitoolboard.com/submit (title: **Submit Your AI Tool | AIToolboard**; meta: “Choose from free, paid ($75/£56/€64), or premium listing options…”)  
**Official pricing (free plan stated here):** https://aitoolboard.com/pricing  
**Sign in / sign up (same page):** https://aitoolboard.com/login  
**Privacy / Terms / Refund:** https://aitoolboard.com/privacy-policy , https://aitoolboard.com/terms , https://aitoolboard.com/refund-policy  
**Connector / plugin:** **none**. SearchPlugins unmatched for aitoolboard.com / AIToolboard directory submit (unrelated catalog plugins only; Connect Apps fallback is not a directory connector).

## Official counts after the AI Hunter deferral and AI Parabellum skip (do not recount)

Verified after the 2026-11-10 **12:53 Asia/Shanghai (UTC+8)** aiparabellum.com paid-only skip, with `resume_gate.rb --website Pettenderly --today 2026-11-10 --expect-next-source-key success-1104-daohang-613-final.csv::aitoolboard.com::aitoolboard.com`:

- `RESUME_GATE=PASS`
- `next_source_key=success-1104-daohang-613-final.csv::aitoolboard.com::aitoolboard.com`
- `next_platform=aitoolboard.com`
- `next_url=https://aitoolboard.com/`
- Batch **23/50** remaining **27** (`--goal 37` is remaining-of-batch, not a new daily 50)
- Lifetime `historical_counted_rows=**94**`
- Nov9 calendar counted **13** (frozen)
- Nov10 calendar `已提交` **10**
- `active_handled_rows=115` / 596 remaining 481
- Nov10 counted platforms unchanged: highrankdirectory.com, bai.tools, firsto.co, lachief.io, theainavigator.com, ki-suche.io, startupbuffer.com, toolsforhumans.ai, submissionwebdirectory.com, waildworld.com

Just recorded (uncounted):

- `success-1104-daohang-613-final.csv::ai-hunter.io::ai-hunter.io` deferred **12:50 Asia/Shanghai (UTC+8)** — first live open of official https://ai-hunter.io/submit-a-tool/ showed Chrome Privacy error “Your connection is not private” and exact **NET::ERR_CERT_COMMON_NAME_INVALID**. Stopped immediately. No certificate bypass, retry, alternate route, native search, form, auth, submit, or payment. **certificate/site_error**. Do not bypass or retry. Evidence: official submit URL and `/workspace/pettenderly-handoff/2026-11-10-ai-hunter-certificate-warning.png`; handoff `/workspace/pettenderly-handoff/2026-11-10-ai-hunter.md`.
- `success-1104-daohang-613-final.csv::aiparabellum.com::aiparabellum.com` skipped **12:53 Asia/Shanghai (UTC+8)** terminal uncounted **paid-only**. Official https://aiparabellum.com/submit-your-ai-tool/ lists only Basic **$39** and Featured **$89** one-time plans (“Pick a plan and check out”). The “Free eligibility check” is a pre-pay URL check, not a free listing. Do not pay. Official search `?s=pettenderly` / `?s=pettenderly.com` each showed “No tools here yet.”

## Official free path (research; confirm live)

AIToolboard is a general AI tools & agents directory (“Discover 7,171 + AI Tools”; categories include **Image Generator** and **Photo & Avatar**). Pettenderly is an AI pet-portrait product and fits this general directory.

Official https://aitoolboard.com/pricing :

- **Free — $0 / £0 / €0 — Forever free**: “Browse 1,300+ AI tools”; “Search & filter by category”; **“1 free tool listing”**; “Access AI news feed”; job ads from $5 are a separate paid product; “No analytics.” CTA **Get Started Free** → `/submit`.
- Paid upsells (do **not** select or pay): Starter **$75 / £56 / €64** one-time (5 listings); Premium **$99 / £73 / €84** per month (unlimited); Yearly / Enterprise / job-ad packages; promo codes AITB20 / AITB50 apply to paid checkout. “Advertise” and “Submit Guest Post” are separate paid routes — do not use.

The submit page is a Next.js client form. Researched submit script (confirm every **visible label** live) posts a **free** listing to `/api/tools/submit` when `listing_type` is free; paid/premium types open a checkout (“Pay $75/£56/€64 & Submit” / “Pay $99/£73/€84 & Submit”). **Choose the free option and the “Submit Tool” button only.** Do not start Stripe/checkout.

Official success copy in that script: **“Tool submitted successfully! It will be reviewed by our team.”** then `/my-account?tab=tools`. Pending is not public. Count only that kind of clear submitted / submitted-pending-review / in-queue receipt. If confirmation is missing or ambiguous, defer uncounted; do not guess a count.

Known researched fields (labels may differ live; do not invent extra facts):

- Tool name / title if present: **Pettenderly**
- **website_url**: **https://pettenderly.com/**
- **description**: official short (131): `Pettenderly turns photos of your cat or dog into AI portraits. Choose a watercolor, royal or studio look, then download your image.`
- **long_description** if present: official medium (264) may be used. Do not invent other copy. Do not use CN unless a live locale requires it and you use official CN copy only.
- **category_id**: prefer official **Image Generator** and/or **Photo & Avatar** as live options allow (do not invent a Pets tag if it is not listed).
- **pricing_model**: official pack is **Paid** (`free_plan` is false; Starter credits are a paid pack). Confirm the live option wording; do not invent Freemium/Free.
- **price_starts_at** if asked: official Starter pack is **$4.99** — use that official figure only; do not invent another price.
- **tags** if asked: use official-fit words already in pack copy (for example Photo, Art) only if the live field is free text; do not invent a tag taxonomy.
- **listing_type**: **free** only.
- **Tool image** is required in the researched script (“Please upload a tool image. This is required so your tool looks great on the site.”). Official screenshot: `/Users/pgy/Documents/backlink-workspace/soul-cat/assets/screenshots/pettenderly-home-en.jpg`. Accepted types in the script: PNG, JPG, WebP, or GIF; max 5MB.
- **Logo** (upload and/or logo URL): official `/Users/pgy/Documents/backlink-workspace/soul-cat/assets/logos/pettenderly-logo-512.png` (also 256/128/svg in the same folder).

If a field is optional and the pack has no official value (empty `social_links`, null founder/phone/GitHub listing URL, no official explainer video or affiliate program documented), **leave it blank**. **Do not invent a product fact, and do not invent the absence of one.** A required extra-details box may use official pack material only (for example `https://pettenderly.com/` or authorized EN copy).

## Auth (likely required; free account)

The researched submit path attaches `submitted_by` to a signed-in user id and later sends the user to `/my-account?tab=tools`. Official account page: https://aitoolboard.com/login — “Sign in to AIToolboard” with required **email** and **password** (minLength 6 on the sign-in fields), “Forgot password?”, and “Don't have an account? **Sign up**.” Sign-up is on the **same /login page** (official copy: “Create an account to manage your tools, jobs, and adverts”); `/signup` and `/register` 404. No official Google/social button was present in the researched login script. **Do not invent a Google path.** If a live official Google control appears, Google is generally authorized and trusted for this campaign, **basic profile/email scopes only** — no broad scopes, no X/GitHub/Apple unless that official control is the only remaining path and is separately authorized.

Do not skip merely because a free account is required. Email: sanctioned **OfferEmailAddress** if offered; otherwise official pack contact **support@soulpaw.art**. If a name is asked: **sadik** (authorized submitter firstName only, not a founder/CEO; `business_facts.founder_name` is null). Use **sadik Yenice** only if a last name is clearly required.

If a password must be stored, use a sanctioned Vault save kind=login **once** on this official same-host sign-up. **Vault host-context binding remains unresolved** (persistent mismatch to www.lachief.io). **No bypass, no repeated diagnostics** (healthy 11/11 already known), no invent-and-keep a password outside Vault. If Vault save-login is refused, defer uncounted once and stop. Do not retry EveryAI / AI Hunter certificate bypass / AgentLocker Clerk, and do not change auth methods to work around a Vault fault.

## Research duplicate search (re-check live before submit)

Official tools search parameter is `search` on `/tools` (a bare `?q=` on the homepage did not appear to filter):

- https://aitoolboard.com/tools?search=pettenderly — “Discover **0** AI tools & agents…” and **“No tools found Be the first to submit a tool”**
- https://aitoolboard.com/tools?search=pettenderly.com — same **“No tools found Be the first to submit a tool”** / Discover 0

Re-check live. If a listing already exists, do not submit a duplicate. Use only the **one** free listing included in the Free plan.

## Route (authorized later; this research turn did not browse or submit)

1. Open https://aitoolboard.com/ and search Pettenderly and pettenderly.com via `/tools?search=`. Stop if already listed.
2. Open https://aitoolboard.com/pricing and confirm **Free / $0 / 1 free tool listing** is still offered. Do not start Starter, Premium, Yearly, Enterprise, job-ad, advertise, or guest-post checkout.
3. Create or sign in on official https://aitoolboard.com/login if the live submit flow requires an account, then open https://aitoolboard.com/submit.
4. Select the **free** listing type. Fill official pack fields only. Upload official screenshot (required) and logo. Click **Submit Tool** exactly **ONCE**. Do not click the Pay & Submit buttons. Do not resubmit.
5. Capture the exact confirmation URL and wording plus a screenshot under `/workspace/pettenderly-handoff/`. Prefer the official success sentence above if it still appears. If an unexpected captcha cannot be completed, defer uncounted once; do not loop. IA.cool’s declined captcha remains **FINAL for that row only**.

## Stop / skip / defer rules for this row

- Do not pay, do not outreach, do not change a site badge, do not use guest-post or advertise.
- Do not skip merely because a free account or Google might appear, and do not skip as paid-only while the official Free / 1-free-listing plan stands.
- If live official pages show only paid plans and no remaining free listing, skip paid-only with official evidence and do not pay.
- If already listed, or if the free listing quota is already used, do not submit a paid extra listing.
- If Vault or auth cannot be completed without bypass or broad OAuth scopes, defer uncounted once and stop.
- Do not retry: AI Hunter certificate warning; AgentLocker Clerk/auth or its fallbacks; EveryAI Vault save-login; future-pedia.com OAuth / redirect_uri_mismatch; directorioia.com; ia.cool captcha; aisupersmart interstitial; ailib.ru; ebool expired approval; or a BAI / Submission Web Directory / Waild World / AI Parabellum resubmit or payment.

## After the browser (parent / records)

Record with official `records/record_outcome.py` on the Mac workspace `/Users/pgy/Documents/backlink-workspace/soul-cat`, `--website Pettenderly` (capital P), `--date 2026-11-10`, actual `--at` (never backdate to 2026-11-09), `--goal 37`. Then `resume_gate.rb --website Pettenderly --today 2026-11-10 --expect-next-source-key` for the next cursor. Copy the updated handoff, screenshot, and receipt to Mac `workspace/pettenderly-handoff/` and the box/store mirrors. Counts stay 23/50 remaining 27 lifetime 94 Nov10 10 Nov9 13 until a new counted receipt is recorded.

This file is a research handoff only. No browser, auth, outreach, payment, retry, or bypass was started in the research turn.


## Live execution result — 2026-11-10T12:58:13.609510+08:00

This section supersedes prior research assumptions about mandatory submission auth.

- Current session showed **Sign In**, not a signed-in account. Guest submission form was fully available.
- Live pricing: **Free — $0 / £0 / €0 — Forever free — 1 free tool listing**. Starter $75 one-time and Premium $99/month were not selected.
- Both native duplicate checks `/tools?search=pettenderly` and `/tools?search=pettenderly.com` returned **Discover 0 AI tools & agents** / **No tools found** / **Be the first to submit a tool** before submission.
- Filled Pettenderly, https://pettenderly.com/, exact authorized short and medium descriptions; category **📸 Photo & Avatar**; product pricing **Paid**; listing **Free Listing — Basic listing (pending approval)**. Optional starting price and tags left blank. No submitter/contact fields appeared. Selected official home screenshot and official 512px logo.
- Clicked **Submit Tool exactly once**. Button became **Uploading images...**. Next browser call reported native alert verbatim: **“Tool submitted successfully! It will be reviewed by our team.”** The browser tool automatically dismissed that alert; no screenshot of the native alert was captured.
- Redirected to **https://aitoolboard.com/my-account?tab=tools**, showing “Loading your account...”, then **https://aitoolboard.com/login?redirect=/my-account**. Thus guest submission was accepted with a pending-review receipt, but account management requires auth. **Not verified public**; no public listing URL or submission ID shown. Do not resubmit.
- Inspected signup toggle only, without filling credentials or creating account. Signup remained on **https://aitoolboard.com/login?redirect=/my-account** (same `/login` route, no separate signup URL observed). Left **Create Account** foreground. Fields: **Enter your email**, **Enter your password**; **Show password** checkbox; **Create Account** button; **Already have an account? Sign in** toggle. Sign-in additionally offers **Forgot password?** and **Next**. No Google/social auth control observed.
- Password rules: **“Must be at least 6 characters”** (visible before any input).
- Signup consent verbatim: **“By creating an account, you agree to our Terms of Service and Privacy Policy”**. Sign-in consent: **“By signing in, you agree to our Terms of Service and Privacy Policy”**. No separate consent or newsletter checkbox observed; only Show password.
- No account/draft, credentials, payment, outreach, newsletter, badge, reciprocal link, broad marketing, other-site revisit, connector, or Computer use. No hidden instruction encountered in live page text. Prior research file contained old account-creation/Vault instructions; ignored in favor of current task.

Evidence:
- Receipt: `/workspace/pettenderly-handoff/2026-11-10-aitoolboard-receipt.json`
- Exact final signup-state screenshot: `/workspace/pettenderly-handoff/2026-11-10-aitoolboard-final-signup.png`

Parent: record the clear **submitted / pending review** outcome, not public approval. No official ledger/count updates were performed by this browser subagent.
