# Phase 4: Build (plans → merged features)

Goal: execute one milestone plan at a time, each ending in a verified PR. Gate G4 per feature.

## Execution

- **Default:** `superpowers:executing-plans` with a checkpoint after each task group.
- **Big milestone, PC session:** `superpowers:subagent-driven-development` (fresh subagent per task, review between tasks). Not in cloud sessions with tight limits.
- Work on a branch per milestone (`feat/<nn>-<name>`); `superpowers:using-git-worktrees` only if two milestones run in parallel.
- Logic tasks: `superpowers:test-driven-development`. UI tasks: build, then verify on device (see Phase 3 table).
- Bug or unexpected behavior: stop and use `superpowers:systematic-debugging` before changing code.

## Which skill for which code

| Writing | Skill / tool |
| --- | --- |
| Routes, layouts, navigation | expo-router |
| Folder placement | expo-project-structure (match the template: `app/` routes only, logic in `src/`) |
| Screens and controls | expo-native-ui, expo-ui, tokens from `src/theme/` |
| Data loading, caching, offline | expo-data-fetching (React Query over the Supabase client) |
| Animation, gestures, haptics | expo-animation |
| Adding any package | `npx expo install`; check Expo MCP docs; if it has native code, flag "dev build needed" |
| Any component, list, animation or screen | `vendor/react-native-skills/`: read `INDEX.md`, then the rule files for what you're touching (lists → `list-performance-*`, animation → `animation-*`, images → `ui-expo-image`, sheets → `ui-native-modals`, conditional JSX → `rendering-no-falsy-and`) |
| Schema, RLS, functions | Supabase skills + MCP (show SQL first; save migration file; regenerate types). Apply `supabase-postgres-best-practices`: index every column used in an RLS policy or a frequent filter, wrap `auth.uid()` as `(select auth.uid())` in policies, no N+1 queries from screens |
| Products, offerings, paywall | RevenueCat skills + MCP |
| Crash context | Sentry: `Sentry.setUser({ id })` only; no PII in breadcrumbs |
| Store build or OTA questions | eas-update, eas-workflows, eas-app-stores |

`apple-skills` has no role in this phase except design/ux-writing for any new string. Ignore its generators even when they match the feature name (e.g. `paywall-generator`, `auth-flow`, `account-deletion`): the template already implements these in TypeScript.

## Non-negotiables in code

- Every user table: `user_id default auth.uid()`, RLS owner-only policies; check `is_anonymous` where a real account is required.
- `pro` gating twice: UI via `useEntitlement('pro')`, server via the `entitlements` table.
- No secrets in `EXPO_PUBLIC_*`; service role key only in Edge Functions.
- New data collected → update `docs/DATA.md` in the same PR.
- Strings from the copy file, colors and spacing from tokens. No hard-coded hex.
- Each UX state from UX.md implemented (loading, empty, error, offline, anonymous, free/pro).
- Frontend (from the Vercel rules): virtualized lists (FlashList) for any list of data, `expo-image` for images, `Pressable` not Touchable*, animate only transform and opacity, native stack/tabs/form sheets, no `{count && <X/>}` with numbers, minimal state (derive, don't duplicate; server data lives in React Query).
- Backend: Edge Functions validate input and the caller's JWT, return consistent JSON errors, and the RevenueCat webhook is idempotent (it can receive the same event twice). Anonymous users get write limits where abuse is possible.

## Finishing a feature (Gate G4)

1. `npm run check` (tsc, eslint, jest) and Supabase advisors: paste the result.
2. `superpowers:requesting-code-review` on the diff, focused on: RLS gaps, entitlement bypass, unhandled states, secrets, and the CRITICAL/HIGH rules in `vendor/react-native-skills/INDEX.md`.
3. Push; preview update builds; ask the user to verify on the phone (give the branch name).
4. `superpowers:finishing-a-development-branch` → open PR with `gh` (summary, screenshots the user sent, DATA.md changes, "needs dev build: yes/no").
5. Update STATUS.md: milestone progress, day count, anything for the user.

Merging to `main` triggers the production workflow (store build or OTA). Before the first store submission that's fine: builds go to TestFlight and Play internal only.
