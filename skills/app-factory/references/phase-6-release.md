# Phase 6: Release (store assets → submitted)

Goal: iOS submitted for review; Android in closed testing (started day 5) and promoted to production once allowed. Target: day 12. Gate G6.

## Skills

| Need | Skill |
| --- | --- |
| Builds, submission, versions, TestFlight | eas-app-stores, eas-workflows |
| App Store listing as code | EAS Metadata (`store.config.json`, `eas metadata:push`) |
| Keywords (100 chars), subtitle, description | apple-skills app-store: keyword-optimizer, app-description-writer |
| Screenshot sequence and captions | apple-skills app-store: screenshot-planner (plan only; user captures on the 6.9" iPhone) |
| Privacy policy accuracy | apple-skills legal/privacy-policy (check the Phase 0 pages against DATA.md) |
| IAP review info | RevenueCat MCP (store product state) + user in App Store Connect |
| If rejected | apple-skills app-store/rejection-handler |
| JS hotfixes after launch | eas-update via the production workflow |

Don't use apple-skills `screenshot-automation`, `iap-finalizer` or `privacy-publish`: they assume an Xcode project or call App Store Connect in ways that overlap EAS Metadata and RevenueCat.

## Steps

1. **Copy.** Write `docs/RELEASE.md` from `templates/RELEASE.md`: name (30), subtitle (30), promo text (170), description, keywords (100, comma-separated, no spaces, no words already in name/subtitle), What's New, review notes, support URL, privacy URL. Play: short description (80), full description (4000).
2. **Screenshots.** Shot list of 5-8 frames: core-loop value first, paywall never first. Caption per frame. The user captures on the iPhone 17 Pro Max (6.9") and an Android phone; optional simple caption frames.
3. **Privacy answers.** From DATA.md produce: App Store privacy label answers (data types, linked to user, tracking = no) and Play Data safety answers. The user enters them in the consoles.
4. **Metadata.** Generate `store.config.json` from RELEASE.md. After a build has been processed in App Store Connect: `eas metadata:push`. Fix any validation warnings.
5. **Version.** Confirm version (1.0.0) in app config; build numbers auto-increment remotely.
6. **Final build.** Merge the release PR to `main`; the production workflow builds and submits (or confirm the latest TestFlight build has the final code: same fingerprint and no pending JS → no new build needed).
7. **User clicks (list them, then wait):**
   - App Store Connect: select build, age rating, pricing/availability, privacy labels, attach IAPs, App Review info → Submit for Review
   - Play Console: confirm closed test has run 14 days with 12+ testers → apply for production → when approved, promote with staged rollout
8. **Record** submission dates in STATUS.md.

## After submission

- Rejection: paste the message; use rejection-handler to decide fix vs reply; fix on a branch; resubmit. Most fixes are metadata or a missing flow, not code.
- Approval: release manually; watch Sentry and RevenueCat for 48 hours; reply to early reviews.
- v1.0.1: P2 items from REVIEW.md. JS-only → OTA update; native → store build.
- Start the next app: `/app-factory new` in a new repo from the template. Anything learned that applies to every app goes back into the template (and this skill).

## Gate G6

iOS submitted (date), Android status (closed test day N / production). Then run `/app-factory retro` (Phase 7) while the details are fresh.
