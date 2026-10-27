# Changelog

All notable changes. Versions follow semver: patch for wording and rule tweaks, minor for new phases, commands or vendored sources, major for a stack-contract change.

## Unreleased

## 0.1.0 - 2026-10-27

First release.

- `app-factory` skill: phases 0-7 (bootstrap, product, design, plan, build, review, release, learn) with gates G1-G6 recorded in `docs/STATUS.md`.
- Orchestrates superpowers, Expo skills + MCP, Apple product/App Store skills (no Swift generators), Supabase, RevenueCat and Sentry plugins.
- Vendored, pinned: Vercel React Native rules (frontend standard), Draftbit mobile-taste design review (scored, with baseline).
- Personal values moved to `app-factory.config.json`; template `CLAUDE.md` with stack and gate rules.
- Retro and improve loop (`/app-factory retro`, `/app-factory improve`).
- Eval suite: new idea routing, open gate respected, stack contract (paywall via RevenueCat), styling stays StyleSheet + tokens, honest status. 5/5 cases at 1.00 over 3 runs.
- Found by the first eval runs: the skill didn't fire for in-repo stack questions (description widened), and an explicit out-of-stack request was obeyed silently (template `CLAUDE.md` now says to flag it and ask).
