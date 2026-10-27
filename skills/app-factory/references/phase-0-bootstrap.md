# Phase 0: Bootstrap a new app from the template

Goal: a renamed copy of the template with every service wired, running on the user's iPhone as a development build. Target: day 1-2.

## Preconditions

- The repo was created from `expo-app-factory` ("Use this template" on GitHub) and cloned.
- `references/setup.md` verification passes.
- If `docs/SPEC.md` already exists (Phase 1 was run first in a scratch session), use its name and pitch.

## Ask (one batch)

1. App name and slug (slug = lowercase, used for bundle id `<bundleIdPrefix>.<slug>`, Sentry project, web folder).
2. One-line pitch.
3. Prices: monthly, annual, lifetime (recommend: annual ≈ 4-5× monthly, lifetime ≈ 2.5× annual). "Decide later" is allowed; products are then created in Phase 4.

## Steps

1. Write `docs/STATUS.md` from `templates/STATUS.md` (phase 0, day 1, today's date).
2. Update `src/config/app.ts` and `app.config.ts` (name, slug, scheme, bundle id, Sentry project). Set `ios.supportsTablet: false`.
3. `eas init`; write the projectId into `src/config/app.ts`.
4. **Sentry MCP:** create project `<slug>` (React Native) in the EU org; record the DSN.
5. **Supabase MCP:** ask which project to use (never create a paid project without approval). Apply `supabase/migrations/0000_baseline.sql` (profiles, entitlements, RLS). Deploy `revenuecat-webhook` and `delete-account`. Regenerate `src/types/database.ts`. Run the security advisor; fix findings.
6. **RevenueCat MCP:** create the project's app entries, entitlement `pro`, offering `default`. Products wait until store app records exist (step 9).
7. `eas env:create` for development, preview, production: Supabase URL and publishable key, RevenueCat public keys (once available), Sentry DSN, Google client ids; `SENTRY_AUTH_TOKEN` as a secret.
8. Legal pages: generate privacy, support and terms for `<webBaseUrl>/<slug>/` using `apple-skills` legal/privacy-policy *knowledge*, filled from `docs/DATA.md` and the contract's services. Write them into the website repo (ask for its path) or into `docs/legal/` if it isn't available. These are drafts: tell the user to read them.
9. Print the manual checklist (below) into STATUS.md and to the user.
10. Run the `dev-build.yml` workflow; when it finishes, give the install link.

## Manual checklist (user)

- [ ] App Store Connect app record (bundle id `<bundleIdPrefix>.<slug>`); put its Apple ID in `eas.json` `ascAppId`
- [ ] Play Console app record
- [ ] Google OAuth clients: iOS, Android (SHA-1 from `eas credentials`), web; add to Supabase Google provider
- [ ] Supabase: Apple provider client id = bundle id
- [ ] RevenueCat: webhook URL → `revenuecat-webhook` with the Authorization secret
- [ ] Install the development build on the iPhone

## Exit

Onboarding screen loads on the phone, an anonymous user appears in Supabase, a test error reaches Sentry. Record evidence in STATUS.md and move to Phase 1 (or Phase 2 if SPEC.md is already approved).
