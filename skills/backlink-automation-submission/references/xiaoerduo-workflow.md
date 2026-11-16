# Xiaoerduo Catalog Queue Workflow

Use this workflow when the explicitly selected CSV has these headers: `名称/网址`, `流量`, `最低价`, `付费/免费`, and `类型`.

## Activation and row order

- Treat the file as `catalog-platform` mode and process every non-empty `名称/网址` row in source order.
- Use the gate-provided source key. For URLs, normalize platform identity by registrable domain; for a plain label, preserve the normalized label until the official platform is resolved.
- Do not let an uncounted backlink-sample failure on another page of the same domain suppress the catalog's official platform submission route. A counted backlink-sample placement on that domain still deduplicates the catalog platform.
- Do not roll this catalog into the standard platform queue automatically.
- When the user sets a target for this catalog run, count only placements produced from this active CSV. Do not import placements from another CSV into the catalog target.

## Field semantics

- `名称/网址`: exact platform URL when URL-shaped; otherwise an unresolved platform label.
- `流量`: discovery hint only; never make a traffic or authority claim from it.
- `最低价`: price hint only; verify the current visible price.
- `付费/免费`: access hint only. Use a current free route when available; do not pay without explicit approval.
- `类型`: routing hint such as forum or launch platform; classify the live platform before acting.

## Resolving targets

1. Open an URL-shaped value directly.
2. For a plain label, run one focused search for the platform's official site, then verify the brand and submission route on the official domain. Do not guess URL variants.
3. Persist the resolved URL in `platform_url` and keep the raw catalog value in notes.
4. If the platform cannot be resolved confidently, record terminal `unavailable` and advance.

## Submission rules

- For product and launch platforms, use the official new-product or directory submission flow and the main skill's product-truth gate.
- For forums, communities, and social platforms, do not post a promotional thread or reply solely to create a backlink. Submit only when an owned account can make a page-specific, materially useful contribution that naturally supports the official URL.
- Do not claim, edit, or reuse sample content or another user's account.
- Treat login, registration, email verification, OAuth, CAPTCHA, legal acceptance, uploads, and payment under the main skill's checkpoint rules.
- Verify a clear receipt or a public page containing the target URL before counting. Prefer a public clickable link; label pending review precisely when only a platform receipt exists.

## Persistence

- Store `csv=xiaoerduo_0820.csv` and the deterministic gate source key.
- Use `terminal` for counted outcomes and conclusive not-counted outcomes; use `deferred` only for a genuinely resumable checkpoint.
- Record raw catalog metadata, detected platform type, current free/paid state, visible outcome, evidence URL, and exact restart step.
- Rerun the gate after every upsert and use only its next source key.
- If this catalog is exhausted below an explicitly requested daily target and the user has authorized problem-solving/retry work, run the controlled `--retry-unresolved` pass. It reopens only older recoverable, never-counted outcomes and still follows source order; it never reopens paid-only, blacklisted, irrelevant, duplicate, submitted/received, public/live, or other conclusive outcomes.
