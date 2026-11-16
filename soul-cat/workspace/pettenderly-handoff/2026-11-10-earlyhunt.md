# Official outcome: earlyhunt.com — deferred uncounted required-badge-or-site-link-for-free-launch

**Exact source key:** `success-1104-daohang-613-final.csv::earlyhunt.com::earlyhunt.com`  
**CSV platform URL:** https://earlyhunt.com  
**Official working host:** https://earlyhunt.com/ (TLS OK, CN=`earlyhunt.com`, Verify return code 0). https://www.earlyhunt.com/ also HTTP 200.  
**CSV 免费提交核验:** 清单标为免费，待官网核对. Official pages confirm a Free Launch $0 path, but it is locked behind a required on-site EarlyHunt badge or link.  
**Recorded:** 2026-11-10 **16:47 Asia/Shanghai (UTC+8)** via `records/record_outcome.py --goal 37 --date 2026-11-10`. Uncounted.  
**Status:** deferred uncounted **required-badge-or-site-link-for-free-launch** (not paid-only; not ineligible).  
**Evidence URL:** https://earlyhunt.com/pricing  

Do not add an EarlyHunt badge or any link to earlyhunt.com on the official Pettenderly site. Do not pay Premium Launch **$29**. Do not browse, auth, submit, vote, or outreach. Do not contact hi@earlyhunt.com.

## Official public-page findings (research-only)

SearchPlugins had no earlyhunt.com directory connector (unmatched catalog; Connect Apps fallback only). robots.txt allows `/`, disallows `/admin`, `/dashboard`, `/settings`, `/profile`, `/my-profile`, and `/api`, and advertises https://earlyhunt.com/sitemap.xml and https://earlyhunt.com/posts/sitemap.xml. Disallowed paths and `/api` were not fetched. `/_next` was not inspected.

https://earlyhunt.com/pricing (title “EarlyHunt Pricing — Free & Premium Launch Plans | EarlyHunt”):

- **Free Launch — Free / $0:** “Live on homepage for 7 days”; **“EarlyHunt badge required on website”** / “EarlyHunt badge required on your website”; **“Nofollow links by default”**; “Earn dofollow + badge if you win top 3”; launch blog post; standard launch queue.
- **Premium Launch — $29 / launch one-time** (not used): guaranteed dofollow; **“No badge required”**; Launch Kit; social posts; skip the queue.

Same-page official reference: “EarlyHunt pricing — Free $0, Premium $29 … ignore third-party sites that cite other prices such as $10.” Homepage “Simple launch plans” matches: “Free at $0 (badge required; nofollow by default). Premium is $29 one-time.” Official https://earlyhunt.com/llms.txt: “Pricing (authoritative): Free Launch $0 (badge, nofollow by default) · Premium Launch $29 one-time — NOT $10.” https://earlyhunt.com/how-it-works: “Free Launch — $0: badge required on your site; nofollow by default; top-3 winners can earn dofollow + badge.”

Official FAQ https://earlyhunt.com/faq:

- “How much does it cost to launch on EarlyHunt?” — “Free Launch: Completely free, but requires backlink verification; nofollow links by default, with a chance to earn dofollow if you win top 3. Premium Launch: $29 one-time payment for guaranteed dofollow backlinks.”
- “Do I need to add a badge for Free launches?” — “Yes, for Free launches, you need to add a link to EarlyHunt on your website as part of the backlink verification process.” Options include provided badge code, a simple text link to earlyhunt.com, or a custom badge/link, anywhere on the site. “This is required before your Free launch can be scheduled.”
- “How do I verify my backlink for Free launches?” — an EarlyHunt link must be added before the project can be scheduled; verification checks the website source code at the “Backlink Verification” step.

The $0 path therefore exists, but it cannot be completed under current authorization without adding a required badge or site link. That is why this row is deferred on the required control, not skipped as paid-only.

Official sitemap https://earlyhunt.com/sitemap.xml has **3329** URLs, including **2614** `/project/…` paths, and **zero** Pettenderly or soulpaw matches. `/submit` was not opened (no browser/auth/submit this turn).

## Official counts immediately before this record (this row stays uncounted)

Batch **25/50** remaining **25**, lifetime `historical_counted_rows=**96**`, Nov9 calendar counted **13** (frozen), Nov10 calendar `已提交` **12**. Nov10 counted platforms: highrankdirectory.com, bai.tools, firsto.co, lachief.io, theainavigator.com, ki-suche.io, startupbuffer.com, toolsforhumans.ai, submissionwebdirectory.com, waildworld.com, aitoolboard.com, morefunz.com.

Preserve prior no-retry rows, including OpenLaunch (do not invent a tech stack), ai-search.io (do not bypass the Vercel checkpoint), and the StartupBase existing draft + Google session.

## Official counts immediately after this record (unchanged; this row uncounted)

Official `resume_gate.rb --website Pettenderly --today 2026-11-10`: `RESUME_GATE=PASS`. Batch **25/50** remaining **25**, lifetime `historical_counted_rows=**96**`, Nov9 calendar counted **13** (frozen), Nov10 calendar `已提交` **12**. `active_handled_rows=141` / 596 remaining **455**. `progress_rows=299`.

**Exact next official gate (research not started; 10-minute cap used):**  
`success-1104-daohang-613-final.csv::workspaces.xyz::workspaces.xyz`  
next_url https://workspaces.xyz  
Do not browse, auth, submit, pay, or outreach this next row until a later explicit grant.

Nov10 counted platforms unchanged: highrankdirectory.com, bai.tools, firsto.co, lachief.io, theainavigator.com, ki-suche.io, startupbuffer.com, toolsforhumans.ai, submissionwebdirectory.com, waildworld.com, aitoolboard.com, morefunz.com.
