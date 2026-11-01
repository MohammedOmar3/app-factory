# Changelog

All notable changes. Versions follow semver: patch for wording and rule tweaks, minor for new phases, commands or vendored sources, major for a stack-contract change.

## Unreleased

## 0.2.0 - 2026-11-01

Money-ready process (design approved 2026-11-01, decision D-0004): every app is planned for revenue, branded with user sign-offs, compliant, and store-ready inside 14 days.

- G1 adds a revenue analysis against a bar (3+ competitors in the top 200 grossing, a subscription app with 1,000+ ratings) and a legal screen for regulated categories. It recommends build / rework / drop; the user decides. New eval `g1-revenue-analysis`.
- New Brand & ASO step (`/app-factory brand`, `references/brand.md`, `templates/BRAND.md`): keyword research, names with store and trademark checks (S1), 2-3 directions on a Figma board (S2), brand kit (tokens, iOS light/dark/tinted icons without a Mac, Android adaptive icon, splash, image style, in-app imagery). Open sign-offs behave like open gates. New eval `brand-before-screens`.
- Phase 2 designs inside the brand; paywall (onboarding and feature slots, trial terms, Customer Center win-back, no dark patterns), rating prompt and push permission moments in UX.md §Moments; i18n strings and RTL-safe layouts.
- Compliance thread: `references/business-setup.md` (once per account), Phase 0 legal pages for GDPR / UK GDPR / UAE PDPL / CCPA plus a web account-deletion page in the app-sites repo, Phase 5 Pass 6 Compliance (every finding P0), DATA.md with processors, retention and lawful basis.
- Phase 3: 14-day budget redrawn (brand days 2-3, store assets days 11-12, Play outside the 14 days), new verification rows (push, events, RTL), `dev-build.yml` reference fixed.
- Phase 6: listings in en, de, fr, es, ja, pt-BR, ar plus Apple's extra keyword locales with per-locale limit checks; Figma screenshot frames, app preview video, feature graphic, web deploy, S3 sign-off, global availability, monthly policy check.
- Config: `github.appSitesRepo`, `business`, `figma.templateFileUrl`, `marketData.tool`. Setup adds the Figma MCP.
- The 3-question rule now counts setup issues too (missing template files, empty config keys): they are handled in the step that needs them. Found by eval `idea-starts-product-phase`, which regressed when the new config keys made Phase 0 ask 5 questions.

## 0.1.1 - 2026-11-01

- Phase 0 matches the finished template (lessons from building expo-app-factory with Factory Test, 2026-10-27 to 11-01): identity lives in `src/config/identity.json`; all migrations, not only `0000`; webhook deployed with `--no-verify-jwt`; workflow is `development.yml` and the first iOS dev build runs interactively; env var names listed; `docs/DATA.md` is written in step 1 because step 8 reads it.
- Phase 0 manual checklist adds what the template needed in practice: both App Store keys for RevenueCat, Supabase Apple Client ID = bundle id, custom SMTP + code-only templates, `REVENUECAT_WEBHOOK_AUTH` and `REVENUECAT_SECRET_API_KEY`, GitHub connected to EAS, device registration and Developer Mode.
- `templates/DATA.md`: Apple display name row.

## 0.1.0 - 2026-10-27

First release.

- `app-factory` skill: phases 0-7 (bootstrap, product, design, plan, build, review, release, learn) with gates G1-G6 recorded in `docs/STATUS.md`.
- Orchestrates superpowers, Expo skills + MCP, Apple product/App Store skills (no Swift generators), Supabase, RevenueCat and Sentry plugins.
- Vendored, pinned: Vercel React Native rules (frontend standard), Draftbit mobile-taste design review (scored, with baseline).
- Personal values moved to `app-factory.config.json`; template `CLAUDE.md` with stack and gate rules.
- Retro and improve loop (`/app-factory retro`, `/app-factory improve`).
- Eval suite: new idea routing, open gate respected, stack contract (paywall via RevenueCat), styling stays StyleSheet + tokens, honest status. 5/5 cases at 1.00 over 3 runs.
- Found by the first eval runs: the skill didn't fire for in-repo stack questions (description widened), and an explicit out-of-stack request was obeyed silently (template `CLAUDE.md` now says to flag it and ask).
