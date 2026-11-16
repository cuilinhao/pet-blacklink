# Browser route: StartupRanking (current official gate)

**Exact key:** `success-1104-daohang-613-final.csv::startupranking.com::startupranking.com`  
**Source:** https://startupranking.com · https://www.startupranking.com/  
**FAQ (free):** https://www.startupranking.com/faq — “StartupRanking service is free, you can register your startup…”  
**Create (redirects to login):** https://www.startupranking.com/startup/create/url-validation  
**Login:** https://www.startupranking.com/login (live fetch: “We will only require your name, email and picture.”)  
**Faster Approval (do NOT pay):** https://www.startupranking.com/faster-approval ($49 / $99)  
**Premium Profile (do NOT pay):** https://www.startupranking.com/premium-profile ($25/mo etc.)  
**Connector/plugin:** **none**

## Counts (Asia/Shanghai after eBool sync)
- Batch **13/50** rem **37** · lifetime **84**
- Nov9 daily actual **13** · Nov10 daily actual **0**
- eBool deferred synced; OpenHunts stays deferred — no auto-retry

## Free path
- Official FAQ: free registration + free data gathering; approval queue usually **~60 days** (How It Works / third-party also cite ~80 days).
- Free profile: nofollow website link (Premium sells dofollow — skip).
- **Do NOT** buy Faster Approval $49/$99 or Premium Profile / Booster packages.
- No badge / site-edit requirement stated for free.

## Auth (soft-stop risk)
- Create URL currently lands on **Log In**. Third-party guides: Google / Facebook / LinkedIn / X. Live page does not advertise email+password.
- Prefer non-Google if a permitted provider is available and user-authorized; if live is Google-only / social-OAuth-only with no authorized provider → **defer** (do not invent email path; do not force expired-style OAuth retries).
- No automatic OpenHunts/eBool-style retry of expired approvals.

## Route
1. Dup-search StartupRanking for Pettenderly / pettenderly.com (claim existing if found — do not create duplicate).
2. Confirm free FAQ + paid upsells screenshots.
3. Sign in only with an authorized provider; stop on unauthorized OAuth / expired approval.
4. Create/claim startup via URL validation; fill profile once with official materials only.
5. Decline Faster Approval / Premium; await free queue (~60–80 days). Capture pending evidence.

## Expected fields (confirm live; official materials only)
- Startup name: **Pettenderly**
- Website: **https://pettenderly.com/**
- Tagline / description: authorized EN short/medium from `copy/snippets.json` only
- Location / founding date: only if known from product-truth — **do not invent**
- Founder / team: **do not invent** (Sadik Yenice ≠ verified founder) — leave blank or soft-stop if required
- Logo: authorized assets only
- Social: only if official accounts exist in materials — do not invent FB/X

## Soft-stops
- Required founder name with none verified
- Forced paid Faster Approval
- OAuth-only with no authorized provider / approval expired
- Required newsletter beyond skill-authorized mandatory path — record actual consent; no optional marketing
- Required unauthorized site badge/edit

## Eligibility
- Tracks startups/companies broadly (AI products appear on leaderboard). Soft-stop only on explicit product exclusion.
