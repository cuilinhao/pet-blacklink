# Official outcome: The Startup INC / thestartupinc.com — skipped terminal uncounted paid-only

**Exact source key:** `success-1104-daohang-613-final.csv::thestartupinc.com::thestartupinc.com`  
**CSV platform URL:** https://thestartupinc.com  
**Official working host:** https://thestartupinc.com/ (www.thestartupinc.com HTTP 200 redirects once to the apex)  
**CSV 免费提交核验:** 清单标为免费，待官网核对. Official submit page overrides that tag.  
**Recorded:** 2026-11-10 **15:32 Asia/Shanghai (UTC+8)** via `records/record_outcome.py --goal 37 --date 2026-11-10 --at "2026-11-10 15:32" --status skipped --state terminal`. Uncounted.  
**Status:** skipped terminal uncounted **paid-only**.  
**Evidence URL:** https://thestartupinc.com/submit-startup/  
Do not pay $10 or $20, do not submit, and do not use the page's alternate Google form as a free bypass.

## Official public-page findings (research-only; no browser, auth, submit, or payment)

TLS verification OK; peer certificate CN=`thestartupinc.com`. Homepage title: “Start up Companies Directory & Startup Listing Website - The Startup INC”. robots.txt allows all and advertises https://thestartupinc.com/sitemap_index.xml. There is no official `/pricing/` or `/plans` page (both HTTP 404). `/price` is a startup listing for Pricekart, not a pricing page. SearchPlugins had no directory connector for this host.

https://thestartupinc.com/submit-startup/ (title “Submit Startup | List Your Startup Company | Promote Startup”) is a guest Contact Form 7 form. Immediately above the form, official copy says: **“Publishing your startup at The Startup INC will cost you $20, to be paid once the startup is reviewed and published.”** The same page also warns not to copy-paste content or the listing will be rejected. The on-page FAQ “Is it paid or free to submit startup?” answers: **“No, Publishing your startup at The Startup INC will cost you $10, to be paid once the startup is reviewed and published.”** The $20 form lede and $10 FAQ amount conflict; **both are paid, and neither is a free path.** CSV “清单标为免费” does not override this official submit page. A separate line offers submitting details via a Google form (`https://goo.gl/forms/KsIYWe8926ulTS303`); that link was not opened or filled and is not treated as a free listing route.

The form has no login, newsletter, badge, or reciprocal-link control, and no payment widget on the page itself (payment is described as due after review/publish). Required fields include Startup Name, one-line definition, **Startup's Founding Date**, Industry, Email, Website, About Your Startup (minimum 500 characters), problems solved, audience, differentiators, future plans, and **Tell Us About The Founders** (label “minimum 250 characters”; the textarea also has `minlength="500"`). Pack `launch_date` / `founding_date` and `business_facts.founder_name` are null; those missing facts are noted only as additional blockers and were **not** used as the skip reason, because official publishing is paid in any case. Number Of Employees is starred; optional fields include headquarters, social URLs, phone, apps, video, and milestones. Button: “Submit Startup”. No field was filled and Submit was not clicked.

Official GET search (homepage “Search This Website”, `?s=`): https://thestartupinc.com/?s=pettenderly and https://thestartupinc.com/?s=pettenderly.com each returned exact **“Sorry. No search results found”**. https://thestartupinc.com/startup/pettenderly/ is HTTP 404 “Page not found”. Official post sitemap lists **277** `/startup/` URLs and **zero** Pettenderly or soulpaw.

About (https://thestartupinc.com/about/) describes a startup listing directory and says inquiries for listed startups are forwarded “for FREE”; that is not a free-submit offer. Link Building Service is a separate page and was not used.

## Official counts immediately before this record (this row stays uncounted)

Batch **25/50** remaining **25**, lifetime `historical_counted_rows=**96**`, Nov9 calendar counted **13** (frozen), Nov10 calendar `已提交` **12**. Nov10 counted platforms: highrankdirectory.com, bai.tools, firsto.co, lachief.io, theainavigator.com, ki-suche.io, startupbuffer.com, toolsforhumans.ai, submissionwebdirectory.com, waildworld.com, aitoolboard.com, morefunz.com.

