# House rules for this app

This repo was made from the expo-app-factory template. Work through the app-factory skill (`/app-factory`).

## Every session
- Start by reading `docs/STATUS.md` (phase, open gates, day N of 14). End by updating it.
- If a gate earlier than the work you're asked to do is still open, say which one and ask once whether to finish it or proceed anyway. Don't decide for the user.

## Stack (fixed by the template)
Expo (latest SDK) + Expo Router, TypeScript strict. Supabase (auth, Postgres, Edge Functions), RevenueCat (entitlement `pro`), Sentry (EU). iOS + Android. EAS Build / Submit / Update / Workflows. Styling: StyleSheet + tokens from `src/theme/`. No analytics SDKs.

If a request names a tool outside this stack (Swift/SwiftUI, StoreKit, Xcode, Firebase, NativeWind, GitHub Actions, a custom server), stop before writing anything: say it conflicts with the template, propose the in-stack equivalent, and ask.

## Always
- Read `docs/SPEC.md` before building a feature; don't add features that aren't in it (extras go to `LATER.md`).
- Install packages with `npx expo install`, never plain npm, so versions match the SDK.
- Use the Expo, Supabase and RevenueCat skills/MCP to check current APIs before writing integration code.
- Every new table: `user_id default auth.uid()`, RLS on, owner-only policies. Show SQL before applying. After a migration, save it in `supabase/migrations/` and regenerate `src/types/database.ts`.
- Paid features: gate in UI with `useEntitlement('pro')`; gate server-side with the `entitlements` table.
- Secrets never in code or `EXPO_PUBLIC_` vars. Service role key only inside Edge Functions.
- Update `docs/DATA.md` whenever a feature collects new data (it feeds the privacy labels).
- Add a line to `LESSONS.md` when something goes wrong, slow, or needs a workaround.
- Run `npm run check` (tsc, eslint, jest) before saying a task is done.

## Never
- Use Expo Go-only workarounds; we always run a development build.
- Change bundle id, package name, entitlement ids or product ids without asking.
- Apply migrations or deploy functions against a read-only or production project without asking.
- Push to main. Work on a branch and open a PR.
- Edit the app-factory plugin from here; use `/app-factory improve`.

## Release rules
Apple needs: account deletion in-app, Restore Purchases, Sign in with Apple when Google is offered, privacy + support + terms URLs at `<webBaseUrl>/<slug>/` (from `app-factory.config.json`), no placeholder content.
