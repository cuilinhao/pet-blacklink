# Outcome recorded: DealMirror / dealmirror.com (skipped, uncounted, ineligible)

**Exact source key:** `success-1104-daohang-613-final.csv::dealmirror.com::dealmirror.com`  
**Status:** skipped, terminal, counted=no  
**At:** 2026-11-10 **13:22 Asia/Shanghai (UTC+8)** `--goal 37`  
**Evidence:** https://dealmirror.com/product-deal-request/ (also official https://dealmirror.com/how-vendorship-works/ and https://dealmirror.com/vendors-frequently-asked-questions/)

Official site is a **lifetime software-deals marketplace**, not a free directory listing. The official “Submit a Deal” path is a **vendor sales application** with **per-sale commission** (official FAQ: vendor payout “50% off each sale”; how-vendorship: “upto 70% on Each Sale (T&C Applied)”; “Per sale commission charged by merchant or admin”). Buy Now must stay on DealMirror or the product is rejected. Deal prices are capped at $50. CSV “清单标为免费，待官网核对” is superseded by these official pages. No listing-fee checkout was started; this is **not** a directory paid-only skip. Counts unchanged after this skip.

This file retains the research notes below; the recorded outcome above is authoritative.

---

# Official research: DealMirror / dealmirror.com (current official gate after CSS Winner skip)

**Exact source key:** `success-1104-daohang-613-final.csv::dealmirror.com::dealmirror.com`  
**CSV / platform URL:** https://dealmirror.com (official apex host **https://dealmirror.com/** returned HTTP 200; title/og “DealMirror - Lifetime Software Deals at Unbeatable Prices”). Official HTTPS **www.dealmirror.com** failed TLS with `SSL: no alternative certificate subject name matches target hostname 'www.dealmirror.com'`. Research used only the working official apex host. **Do not bypass the www certificate error.**  
**Official submit / vendor pages:** https://dealmirror.com/product-deal-request/ (nav/footer “Submit a Deal”; title **Product Deal Request - DealMirror**), https://dealmirror.com/how-vendorship-works/ (https://dealmirror.com/vendor-marketing-works/ redirects here), https://dealmirror.com/vendors-frequently-asked-questions/  
**Other official public pages fetched:** https://dealmirror.com/about-us/ , https://dealmirror.com/faq/ , https://dealmirror.com/terms-and-conditions/ , https://dealmirror.com/contact-us/ , https://dealmirror.com/press/ , https://dealmirror.com/affiliate-program/ , official robots https://dealmirror.com/robots.txt and sitemap https://dealmirror.com/sitemap.xml  
**Sitemap-listed https://dealmirror.com/sell-your-product/** currently redirects to the homepage (HTTP 200). Vendor FAQ still cites `http://dealmirror.com/sell-your-product/` as an upload URL.  
**Connector / plugin:** **none**. SearchPlugins unmatched for dealmirror.com / DealMirror directory submit (unrelated catalog plugins only; Connect Apps fallback is not a directory connector).

This research used only official public apex HTML, robots, the advertised sitemap, and official GET search/slug pages. No `/cart/`, `/checkout/`, `/my-account/`, `/wp-admin/`, or other robots-disallowed paths, no internal API inspection, no browser, auth, signup, message, submission, outreach, or payment. Newsletter “Sign Up, Stay Updated & Get 10% Off on First Purchase” was not used.

## Official counts after the CSS Winner paid-only skip (do not recount)

Verified after the 2026-11-10 **13:18 Asia/Shanghai (UTC+8)** csswinner.com skipped terminal uncounted paid-only, with `resume_gate.rb --website Pettenderly --today 2026-11-10 --expect-next-source-key success-1104-daohang-613-final.csv::dealmirror.com::dealmirror.com`:

- `RESUME_GATE=PASS`
- `next_source_key=success-1104-daohang-613-final.csv::dealmirror.com::dealmirror.com`
- `next_platform=dealmirror.com`
- `next_url=https://dealmirror.com`
- Batch **24/50** remaining **26** (`--goal 37` is remaining-of-batch, not a new daily 50)
- Lifetime `historical_counted_rows=**95**`
- Nov9 calendar counted **13** (frozen)
- Nov10 calendar `已提交` **11**
- `active_handled_rows=121` / 596 remaining 475
- Nov10 counted platforms unchanged: highrankdirectory.com, bai.tools, firsto.co, lachief.io, theainavigator.com, ki-suche.io, startupbuffer.com, toolsforhumans.ai, submissionwebdirectory.com, waildworld.com, aitoolboard.com

Just recorded (uncounted): `success-1104-daohang-613-final.csv::csswinner.com::csswinner.com` skipped **13:18 Asia/Shanghai (UTC+8)** terminal **paid-only**. Official https://www.csswinner.com/submitsite, /about, and /privacy-policy require a **$15 USD** website submission (STEP 3 Payment; rejected submissions refunded within 7 business days). Handoff `/workspace/pettenderly-handoff/2026-11-10-csswinner.md`.

## Official eligibility: ineligible (lifetime-deal vendor marketplace, not a free directory listing)

Official homepage meta description: “Get Lifetime deals on top SaaS tools at DealMirror—save on AI, marketing, and productivity apps for startups and small businesses.” The official product catalog is a WooCommerce deals store (Add to Cart / priced lifetime deals), not an AI-tool directory with a free listing form.

Official https://dealmirror.com/product-deal-request/ states:

- “Do you have a great product or service for creative professionals?”
- “**Run an amazing deal on our site** and get massive exposure and an incredible instant sales boost. Please send your product or service details and we’ll get back to you as soon as possible.”
- Link: “Want to know more about Vendor Marketing” → https://dealmirror.com/how-vendorship-works/
- Guest Elementor form fields (for completeness only; **do not fill or submit**): Name, Email, Website Link, Product Description, control **Submit Detail**.

Official https://dealmirror.com/how-vendorship-works/ states (verbatim highlights):

- “**No extra costs.** You receive your percentage (excluding standard PayPal fees & taxes) on every single sale.”
- “What can you sell? Lifetime Deals, SaaS Apps, WordPress Themes, Plugins, Graphics, Web Elements.”
- “**Per sale commission charged by merchant or admin.**”
- “**Provide upto 70% on Each Sale (T&C Applied)**”
- “DealMirror gives the best platform to sell your product easily without paying an extra cost. You will get your % (Exclude PayPal Fees) of each sale of your product.”
- “The seller can fulfill the product details and submit for the approval of the product displayed on the website.”
- Process: footer **Submit a deal** → registration form → “**Once admin will approve your listing** you will receive a confirmation mail from the admin panel, **then only you are allowed to submit your deals.**” Then “Sign up and start earning.”

Official https://dealmirror.com/vendors-frequently-asked-questions/ :

- Q4 payment method: “Our payout method is PayPal. **You will get 50% off each sale of your product.**” (verbatim official wording).
- Q5 mandatory details include PayPal Id, featured image, deal terms, **product download link**, license policies, support/update duration, enquiry/support email, and price.
- Q7 acceptance: digital products (plugins, themes, eBooks, web elements, fonts, software, toolkits, etc.) must be unique and original. “If we found that on clicking the “**Buy Now**” button if it goes into **another website**. In that case, your product will be **rejected immediately.**”
- Q8 deal price: “Here you can submit a deal from $0 (or free) to **$50**. The minimum cost of the paid product will be $1 and maximum cost of the product will be $50.”
- Q11 payout timing: “**After 60 days**, Once the deal will be successfully run on the DealMirror.com and we don’t get any complaint from the customer, then we will give your **commission**.”
- Q14: “Vendors product will be on DealMirror.com at least for **30 days**.”
- Q2: after registration, DealMirror emails a User Id and Password for the vendor dashboard. **Do not start this registration.**

A $0 “free” deal on Q8 is still a vendor product sold/distributed through DealMirror, not a free backlink directory listing, and Q7 forbids a Buy Now that leaves the site for https://pettenderly.com/.

Official Pettenderly pack facts (do not invent otherwise): `pricing_model` “Paid. One-time credit packs or a subscription.”; `free_plan` false; Starter **$4.99** / 12 credits; Pro **$9.90/month** or **$79/year**. Pettenderly is sold on its own site, not as a DealMirror lifetime deal. Do not invent an LTD, a $0–$50 DealMirror price, or a downloadable package to qualify.

The CSV row was marked “清单标为免费，待官网核对.” Official vendor pages govern: there is no official free directory-listing path. “No extra costs” refers to no separate listing fee on top of **per-sale commission**, not a free listing. This skip is **ineligible (wrong-type marketplace / vendor-commission sales path)**, not a $15-style directory paid-only skip. Do not pay commission, do not create a vendor account, do not submit the deal-request form, and do not outreach to the vendor contact on those pages.

## Duplicate search (research; no live browser this turn)

- Official sitemap https://dealmirror.com/sitemap.xml : **431** URLs. **Zero** matches for pettenderly, pettenderly.com, soulpaw, or soul-paw.
- Official GET search https://dealmirror.com/?s=pettenderly : title “You searched for pettenderly - DealMirror”; heading “Search Results for: pettenderly”; empty-state **“It seems we can't find what you're looking for.”**; page class includes `search-no-results`; **zero** `/product/` result hrefs.
- Official GET search https://dealmirror.com/?s=soulpaw and https://dealmirror.com/?s=pettenderly.com : same empty-state, zero product hrefs.
- Official slugs https://dealmirror.com/product/pettenderly/ and https://dealmirror.com/product/pettenderly.com/ : HTTP **404**, title “Page not found - DealMirror”.

No existing published listing was found in those official public pages. This does not create a free directory path.

## Auth

Vendor registration and later “Login” / “My vendor Dashboard” exist only for sellers after admin approval (FAQ Q2). `/my-account/` is robots-disallowed and was not fetched. Google/account signup is not a free-listing path and was not started. Vault host-context binding remains unresolved; no bypass. **Do not open a new StartupInspire auth route** from this research.

## Route (do not execute)

No authorized free, in-scope directory path for Pettenderly on this official site. Do not fill the Product Deal Request form, do not register as a vendor, do not send product details or email the site, do not subscribe to the 10% off newsletter, do not open `/cart/` or `/checkout/`, do not bypass the www TLS warning, and do not invent a lifetime deal or DealMirror sale price.

## Stop / skip / defer rules for this row

Skipped terminal uncounted (**ineligible** — lifetime-deal vendor marketplace, not a free directory listing). Do not retry this row. Continue CSV source order at the next official gate.
