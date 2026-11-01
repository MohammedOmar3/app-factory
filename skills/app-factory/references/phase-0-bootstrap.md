# Phase 0: Bootstrap a new app from the template

Goal: a renamed copy of the template with every service wired, running on the user's iPhone as a development build. Target: day 1-2.

## Preconditions

- The repo was created from `expo-app-factory` ("Use this template" on GitHub) and cloned.
- `references/setup.md` verification passes.
- If `docs/SPEC.md` already exists (Phase 1 was run first in a scratch session), use its name and pitch.

## Ask (one batch)

Only these three questions. Missing config keys (`business`, `github.appSitesRepo`, `figma`) are asked in the step that uses them, not here.

1. App name and slug (slug = lowercase, used for bundle id `<bundleIdPrefix>.<slug>`, Sentry project, web folder).
2. One-line pitch.
3. Prices: monthly, annual, lifetime (recommend: annual ≈ 4-5× monthly, lifetime ≈ 2.5× annual). "Decide later" is allowed; products are then created in Phase 4.

## Steps

1. Write `docs/STATUS.md` from `templates/STATUS.md` (phase 0, day 1, today's date) and `docs/DATA.md` from `templates/DATA.md` (app name filled in). Delete `docs/TEMPLATE-SETUP.md` if it came with the template.
2. Update `src/config/identity.json` (name, slug, scheme, bundle id, Sentry project, EAS owner). `app.config.ts` and `src/config/app.ts` read it; don't edit them for identity. Rename "Factory Test" in `supabase/templates/*.html`.
3. `eas init`; write the projectId into `identity.json` (`easProjectId`).
4. **Sentry MCP:** create project `<slug>` (React Native) in the EU org; record the DSN.
5. **Supabase MCP:** ask which project to use (never create a paid project without approval; the free tier allows 2 active projects). Apply every file in `supabase/migrations/` in order. Deploy `delete-account`, and `revenuecat-webhook` with `--no-verify-jwt` (RevenueCat authenticates with a shared secret, not a JWT). Regenerate `src/types/database.ts`. Run the security advisor; fix findings.
6. **RevenueCat MCP:** create the project's app entries, entitlement `pro`, offering `default`. Products wait until store app records and both App Store keys exist (manual checklist). When creating them with store-state plans, set `common.availability.territories` on every product, subscriptions included, or planning returns a blocker.
7. `eas env:set` for development, preview and production (plaintext): `EXPO_PUBLIC_SUPABASE_URL`, `EXPO_PUBLIC_SUPABASE_PUBLISHABLE_KEY`, `EXPO_PUBLIC_GOOGLE_WEB_CLIENT_ID`, `EXPO_PUBLIC_GOOGLE_IOS_CLIENT_ID`, `EXPO_PUBLIC_SENTRY_DSN`, `EXPO_PUBLIC_REVENUECAT_IOS_API_KEY` (public `appl_` key from `list-app-public-api-keys`). The user sets `SENTRY_AUTH_TOKEN` (sensitive) and the two Supabase secrets in the checklist themselves; secrets never pass through chat. Run eas-cli commands one at a time: parallel `npx eas-cli@latest` runs corrupt the npx cache.
8. Legal pages: generate privacy, support, terms and a web account-deletion page for `<webBaseUrl>/<slug>/` into the app-sites repo (`github.appSitesRepo` in `app-factory.config.json`) from its templates, using `apple-skills` legal/privacy-policy *knowledge*. They cover GDPR, UK GDPR, UAE PDPL and CCPA: every processor, lawful basis and retention from `docs/DATA.md`, the seller from `business`, and subscription terms (auto-renew, how to cancel, refunds through Apple, Google Play or Paddle). These are drafts and not legal advice: tell the user to read them.
9. Print the manual checklist (below) into STATUS.md and to the user.
10. Development build: the **first** iOS build must run interactively on the user's PC (`npx eas-cli build --profile development --platform ios --no-wait`), because creating the ad hoc profile needs an Apple login; `--non-interactive` fails with "couldn't find any credentials suitable for internal distribution". Later builds, including the `development.yml` workflow, reuse the profile until a new device is added. When it finishes, give the install link (open the build page on the iPhone; Expo Orbit can't install on iPhones from Windows).

## Manual checklist (user)

- [ ] `references/business-setup.md` done once for the account (link it; skip if already done)
- [ ] App Store Connect app record (bundle id `<bundleIdPrefix>.<slug>`); put its Apple ID in `eas.json` `ascAppId`
- [ ] `eas credentials` (iOS): distribution certificate, provisioning profile, App Store Connect API key
- [ ] RevenueCat app: upload the In-App Purchase key (`SubscriptionKey_….p8`) and the App Store Connect API key (`AuthKey_….p8`, App Manager or higher), same Issuer ID; Paid Apps agreement active
- [ ] Play Console app record
- [ ] Google OAuth clients: iOS, Android (SHA-1 from `eas credentials`), web; add to Supabase Google provider
- [ ] Supabase Apple provider: enabled, bundle id in **Client IDs** (otherwise "Unacceptable audience in id_token"); no secret needed for native sign-in
- [ ] Supabase custom SMTP (Resend: `smtp.resend.com`, port 465, user `resend`, one API key per app, sender `noreply@<webBaseUrl domain>`), then paste `supabase/templates/*.html` into the dashboard templates. Without custom SMTP the templates can't be edited and the default ones send links, not codes.
- [ ] Supabase secrets: `REVENUECAT_WEBHOOK_AUTH` (random, generated in the user's terminal) and `REVENUECAT_SECRET_API_KEY` (RevenueCat v1 secret key, so account deletion also deletes the RevenueCat customer)
- [ ] RevenueCat webhook → `https://<ref>.supabase.co/functions/v1/revenuecat-webhook`, Authorization = the same `REVENUECAT_WEBHOOK_AUTH`, production + sandbox; send a test event and check `revenuecat_events`
- [ ] Web account-deletion page live at `<webBaseUrl>/<slug>/delete-account` (Play requires it)
- [ ] Connect the GitHub repo to the app's EAS project (expo.dev → Project settings → GitHub); push-triggered workflows don't run without it
- [ ] Register the iPhone (`npx eas-cli device:create` in the user's terminal), install the development build, turn on Developer Mode (the toggle only appears in Settings → Privacy & Security after first opening the app)

## Exit

Onboarding screen loads on the phone, an anonymous user appears in Supabase, a test error reaches Sentry. Record evidence in STATUS.md and move to Phase 1 (or Phase 2 if SPEC.md is already approved).
