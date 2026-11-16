# Backlink-Sample Queue Workflow

Use this workflow when the active CSV has `Type` and `URL` headers, including `platforms/gefei0810.csv`.

## Contents

1. Activation and schema
2. Ordered row semantics
3. Runtime page classification
4. Profile workflow
5. Comment and discussion workflows
6. Identity and content rules
7. Status and counting rules
8. Persistence and reporting

## Activation and schema

Treat an optional first row containing a single sheet title such as `表格 1` as metadata. Use the next row as the header.

Map fields as follows:

- `Type`: source-supplied page-type hint; never assume it is accurate.
- `URL`: exact target page to inspect and disposition.
- `Discovered From`: provenance only; never use it as the submission target.
- `Has Captcha`: unverified hint; the current visible page wins.
- `Link Strategy`: unverified hint such as `url_field`, `in_content`, or `both`.
- `Link Format`: unverified hint such as `html`, `bbcode`, or `unknown`.
- `Has URL Field`: unverified hint; inspect the current form.

Activate this queue only when the user explicitly selects it. Do not add it to the standard directory rollover order.

Before opening the first row, run `resume_gate.rb` and require `queue_mode=backlink-sample`, `RESUME_GATE=PASS`, and the expected target-page source key.

## Ordered row semantics

Process every valid `Type` + `URL` row in file order. Do not build a preferred shortlist or jump to easy rows.

An `unknown` or blank `Type` does not exclude a row with a target URL. Keep its source key as `unknown`, inspect and classify the visible page, and record the detected type separately. Queue eligibility permits inspection, not automatic registration or publication; the same relevance, consent, payment and anti-abuse rules still apply. Rows with no target URL are not executable.

For each row:

1. Open and inspect the exact target URL.
2. Classify the current page by visible structure.
3. Follow the matching workflow.
4. Persist one terminal or deferred outcome for the row.
5. Rerun the gate and use only its next source key.

Processing every row does not require forcing a publication. Closed comments, missing forms, unavailable pages, payment-only flows, unrelated identity requirements, anti-abuse barriers, or a page that cannot accept an honest contribution are valid recorded outcomes.

Use this source-key form:

```text
<csv>::<source Type>::<normalized target-page URL>
```

Preserve meaningful query parameters because URLs such as `show_bug.cgi?id=...`, `profile.php?id=...`, or `?p=...` identify different pages. Remove fragments and common tracking parameters.

## Runtime page classification

Treat `Type` only as an initial hint. After inspecting the page, classify it as one of:

- `profile`: a public user, brand, author, company, or member profile.
- `blog_comment`: an article page with a comment form.
- `forum_reply`: a discussion thread with a reply composer.
- `community_post`: a platform that permits a new original post or resource.
- `product_listing`: an official product or company submission flow.
- `bug_tracker`: an issue or bug report.
- `job_or_employer`: a recruiting or employer page.
- `comments_closed`: article exists but no new comment can be submitted.
- `unsupported_page`: no legitimate publication surface is available.

Record both the source `Type` and detected page type in the progress notes. If they disagree, follow the detected type.

## Profile workflow

Never edit, impersonate, claim, or reuse the sample profile shown by `URL`.

1. Identify the platform from the sample page.
2. Locate the platform's own registration or login route through visible navigation.
3. Reuse an existing authorized account for the target website when one exists.
4. Otherwise create one truthful account using the approved site profile and the normal credential rules.
5. Fill only supported public identity fields: website name, approved description, official URL, approved logo, and approved contact identity.
6. Use a dedicated Website field first. Use an About/Bio field only when platform rules permit a URL there.
7. Open the owned public profile after saving and verify the target link.

Create no more than one owned profile per platform. When a later source row points to another sample account on the same platform, still disposition the row, verify the already-owned profile, and record `existing-owned-profile`; do not create another account or count the same profile link twice.

Do not create a profile that requires a fabricated local residence, employment, alumni status, professional credential, political affiliation, community history, review, vote, or other identity claim.

## Comment and discussion workflows

### Blog comments

1. Read enough of the article to identify its actual topic and the point being answered.
2. Locate the current comment form and inspect its fields, rules, login state, moderation notice, and CAPTCHA state.
3. Write an original comment in the article's primary language. Make it specific to that page; never reuse generic praise or a batch template.
4. Use the approved target identity from the site profile. Prefer the dedicated Website field for the official URL when present.
5. Put a link in the comment body only when it directly supports the comment, the editor and site rules permit it, and the link context truthfully matches the product.
6. Treat `html`, `bbcode`, and `unknown` as hints. Use only formatting visibly supported by the current editor.
7. Submit through visible controls, then re-inspect the page or receipt.

Do not force an unrelated product mention merely to obtain a link. A row that cannot accept a truthful, page-specific contribution must still be recorded and advanced, normally as `not-relevant` or `unsupported-page`.

### Forum replies

Reply only from an owned account and only when the response materially answers the thread. Do not post into an old or unrelated discussion solely because the sample backlink exists. Record locked threads, account-age restrictions, reputation gates, and moderator approval precisely.

### Community posts and product listings

Create original content or a truthful product record through the platform's own new-post or submission route. Never modify the sample content. Apply the main skill's product-truth gate before drafting.

### Bug trackers and employer pages

Do not add promotional links to bug reports. Use a bug tracker only for a real reproducible issue involving the target product and project. Do not create employer or job records unless the target website is genuinely recruiting and the required company facts are approved. Otherwise record the row and advance it without publication.

## Identity and content rules

Use the target site's approved profile values. For ShortsMonkey, default public form identity to the approved website name, official URL, and contact email in `sites/ShortsMonkey.md`; use an existing authorized OAuth account only where platform authentication requires it.

Never:

- reuse the sample user's name, avatar, biography, comment, or account;
- copy the competitor backlink's anchor text or surrounding content;
- invent personal facts or community participation;
- post the same comment across multiple pages;
- conceal promotional intent or bypass moderation and anti-abuse systems;
- insert raw HTML or BBCode when the editor does not explicitly support it.

## Status and counting rules

Use these counted statuses only after a public page contains a clickable target link:

- `comment-live`
- `profile-public`
- `forum-reply-live`
- `community-post-live`
- `product-listing-public`
- `backlink-public`

Use `comment-submitted` or `comment-pending-moderation` for a clear receipt that is not yet public. These are not counted backlinks. Recheck them in a later retry pass.

Use specific not-counted statuses when applicable:

- `comments-closed`
- `comment-form-missing`
- `login-required`
- `email-verification`
- `captcha`
- `url-field-missing`
- `url-rejected`
- `format-rejected`
- `registration-unavailable`
- `unsupported-page`
- `not-relevant`
- `paid`
- `unavailable`
- `duplicate-target-page`
- `existing-owned-profile`
- `failed`

Count distinct verified public target pages as backlink placements. Allow two different article pages on one domain to count as two placements when each contains its own verified public link. Also report the number of unique normalized referring domains. Never describe placements and referring domains as the same metric.

## Persistence and reporting

Keep the existing `records/platform-progress.csv` schema. Store:

- `csv`: backlink-sample CSV basename.
- `source_key`: deterministic row key from source type and normalized target page.
- `platform`: normalized target hostname.
- `platform_url`: exact source target URL.
- `state`: `deferred` or `terminal` after a real disposition.
- `last_status`: the most specific status above.
- `evidence_url`: public backlink page when available.
- `notes`: source type, detected type, CSV hints, visible outcome, and exact restart step.

In the daily log, report:

- counted public backlink placements;
- unique referring domains;
- processed rows grouped by detected page type;
- live, pending, deferred, and terminal-not-counted totals;
- the next exact source key and target URL.

Stop the run when the explicit counted-placement target is reached, the queue is exhausted, or a mandatory user-only handoff prevents further safe progress. Persist before stopping.
