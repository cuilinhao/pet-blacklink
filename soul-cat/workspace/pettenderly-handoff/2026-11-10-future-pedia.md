# Future-Pedia submission — 2026-11-10

Status: blocked
Blocker: needs_sign_in
Batch context: current22/50; success-1104-daohang-613-final.csv; future-pedia.com only.

## Duplicate verification
- https://future-pedia.com/?s=pettenderly — “No posts found.”
- https://future-pedia.com/?s=pettenderly.com — “No posts found.”

## Official submission form
https://future-pedia.com/submit-tool/ loaded the Snax submission form with a login popup. Visible fields: Title, description editor (15000-character limit), referral checkbox, thumbnail area, Category, Preview. No fee shown. No submission or draft created.

## Authorized Google sign-in — failed
Opened only https://future-pedia.com/?snax-social-login-with=Google&t=user . Google returned:
“Access blocked: This app's request is invalid”
“You can't sign in because this app sent an invalid request. You can try again later, or contact the developer about this issue.”
“Error 400: redirect_uri_mismatch”
Errors appeared on initial OAuth navigation, before any credentials or form data were entered. No scope consent offered.
Final URL location: https://accounts.google.com/signin/oauth/error (query omitted because it contains OAuth diagnostic identifiers).
Evidence screenshot: /workspace/pettenderly-handoff/2026-11-10-future-pedia-oauth-error.png

Stopped as explicitly instructed for broken Google login. No alternate signup attempted. No external-directory login followed, payment, referral, marketing consent, site edit, submission, or duplicate submission. No hidden instructions encountered or acted on. No public/pending listing created; success not claimed. Site administrator must repair OAuth redirect configuration, or user must authorize another sign-in route before continuation.
