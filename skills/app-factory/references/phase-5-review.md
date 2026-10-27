# Phase 5: Review (is it ready to ship?)

Goal: find what would cause a rejection, a crash, a refund or a bad first review, and fix the serious ones. Target: day 11 (also run a light pass after M02). Gate G5.

Run the five passes in order. Use a **fresh subagent** for passes 1 and 3 where possible, so the reviewer hasn't seen the build being made. Write every finding into `docs/REVIEW.md` with a severity:

- **P0** blocks submission (rejection, data leak, crash on launch, purchase broken)
- **P1** must fix before release (core loop confusing, common crash, missing state)
- **P2** fix in v1.0.1
- **P3** goes to LATER.md

## Pass 1: Product review (against SPEC.md)

- Does a first-time user reach the core-loop value in under 60 seconds, without signing in?
- Is every SPEC §5 must-have present and nothing extra?
- Does the free tier stand on its own? Is `pro` clearly worth its price, shown at the right moment?
- Positioning check: would the App Store subtitle and first screenshot make sense to a stranger?
- Use apple-skills product knowledge for the critique; don't regenerate the PRD.

## Pass 2: UX review on the device

Re-run the vendored mobile-design-review (report-only) as a **regression run** against `docs/design-baseline.json` from Phase 2. Lead with the deltas; any new high-impact finding or Trunk Test FAIL is P1. Use the user's iPhone screenshots or the Android emulator for the live pass.

Then ask the user to run these on the iPhone (and Android if available) on the latest preview or TestFlight build; collect results:

- Fresh install → onboarding → core loop → paywall → purchase (sandbox) → restore on reinstall
- Sign in with Apple, Google and email code from an anonymous user: data kept?
- Airplane mode on each main screen; largest text size; dark mode; VoiceOver on the core loop
- Delete account: data gone in Supabase, user signed out to a fresh anonymous session

## Pass 3: Code and security review

`superpowers:requesting-code-review` on the whole app diff from the template baseline, focused on:

- RLS: every table has policies; try cross-user reads via Supabase MCP as two test users
- `pro` features enforced server-side; no client-only paywall for server data
- No secrets in the bundle (`EXPO_PUBLIC_*` audit), no service key outside functions
- Supabase security + performance advisors clean
- Error handling: no unhandled promise rejections on the core loop; Sentry captures them
- Frontend rules: sweep the code against the CRITICAL and HIGH rules in `vendor/react-native-skills/INDEX.md` (lists, animation, navigation, UI patterns)
- Database: `supabase-postgres-best-practices` review of schema, indexes and policies; RevenueCat webhook handles a replayed event without double-writing

## Pass 4: Stability

- Sentry MCP: all issues from TestFlight/internal builds; anything with >1 user is P1+
- `eas-update-insights` if OTA updates have shipped: crash rate per update
- Cold start time acceptable on the phone (user's judgement)
- Optional, if the user reports jank or slow start and Callstack's `react-native-best-practices` is installed: follow its guidance for the specific symptom (FPS, startup time, bundle size, memory). Don't run a general optimization sweep on v1

## Pass 5: Store readiness

Use apple-skills `release-review` and `app-store/originality-check` (guideline 4.3), translated to this stack (no PrivacyInfo.xcprivacy by hand: Expo and the SDKs supply privacy manifests; confirm via expo docs that the SDK version handles it). Then tick the rejection checklist:

- [ ] Account deletion in-app; Sign in with Apple tokens revoked on deletion
- [ ] Sign in with Apple offered (Google is offered)
- [ ] Restore Purchases; price, period, auto-renew wording, Terms + Privacy links on the paywall
- [ ] <webBaseUrl>/<slug>/privacy, /support, /terms live and match DATA.md
- [ ] Privacy labels and Play Data safety answers derivable from DATA.md
- [ ] No placeholder content, "beta", test buttons, debug menus in production
- [ ] Works without login, or review notes explain access
- [ ] Not a thin wrapper; does something on its own
- [ ] No mention of Android in iOS metadata and vice versa
- [ ] IAPs have review screenshots and are attached to the version

## Gate G5

Summarise: P0/P1 counts (must be 0 open), what was fixed, what moved to v1.0.1. User approves. Record in STATUS.md.
