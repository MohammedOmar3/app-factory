# Phase 6: Release (store assets → submitted)

Goal: iOS submitted for review; Android in closed testing (started day 5) and promoted to production once allowed. Target: day 12. Gate G6.

## Skills

| Need | Skill |
| --- | --- |
| Builds, submission, versions, TestFlight | eas-app-stores, eas-workflows |
| App Store listing as code | EAS Metadata (`store.config.json`, `eas metadata:push`) |
| Keywords (100 chars), subtitle, description | apple-skills app-store: keyword-optimizer, app-description-writer |
| Screenshot sequence and captions | apple-skills app-store: screenshot-planner (plan only; user captures on the 6.9" iPhone) |
| Screenshot frames, feature graphic, preview video captions | Figma MCP, using the brand kit (`docs/BRAND.md`) |
| Landing page, legal pages, web checkout | app-sites repo (`github.appSitesRepo`), Paddle via RevenueCat |
| Privacy policy accuracy | apple-skills legal/privacy-policy (check the Phase 0 pages against DATA.md) |
| IAP review info | RevenueCat MCP (store product state) + user in App Store Connect |
| If rejected | apple-skills app-store/rejection-handler |
| JS hotfixes after launch | eas-update via the production workflow |

Don't use apple-skills `screenshot-automation`, `iap-finalizer` or `privacy-publish`: they assume an Xcode project or call App Store Connect in ways that overlap EAS Metadata and RevenueCat.

## Steps

1. **Copy, every store language.** Write `docs/RELEASE.md` from `templates/RELEASE.md` in English first: name (30), subtitle (30), promo text (170), description, keywords (100, comma-separated, no spaces, no words already in name/subtitle, no competitor names or trademarks), What's New, review notes, support URL, privacy URL. Play: short description (80), full description (4000). Use the keywords from `docs/BRAND.md`. Then translate into every store language: **en, de, fr, es, ja, pt-BR, ar**, and fill Apple's extra keyword locales per storefront (WebFetch Apple's current list of localizations each storefront indexes; don't rely on memory). A second AI pass reviews each translation for meaning and tone. **Check every field against its limit in every locale** (name 30, subtitle 30, keywords 100, promo 170, Play short 80) before any metadata push; a field over its limit is rewritten, never truncated.
2. **Screenshots.** Shot list of 5-8 frames: core-loop value first, paywall never first. The user captures on the iPhone 17 Pro Max (6.9") from the preview build. Frame them with captions in the Figma screenshot template, one set per store language (captions translated). Export at Apple's 6.9" size.
3. **App preview video.** 15-30 seconds of the core loop from the user's screen recordings, cut to Apple's 6.9" preview size with captions in the brand style.
4. **Other assets.** Play feature graphic 1024×500 from the Figma template; IAP review screenshots of the real paywall; icon variants confirmed in the build.
5. **Privacy answers.** From DATA.md produce: App Store privacy label answers (data types, linked to user, tracking = no) and Play Data safety answers. The user enters them in the consoles.
6. **Web.** Deploy the landing page and legal pages to the app-sites repo for `<webBaseUrl>/<slug>/` with the Paddle checkout for `pro`; confirm privacy, support, terms and delete-account URLs load.
7. **S3: store set sign-off.** The user approves screenshots, preview video, listings in every language and the feature graphic in Figma. Record in STATUS.
8. **Metadata.** Generate `store.config.json` from RELEASE.md (all locales). After a build has been processed in App Store Connect: `eas metadata:push`. Fix any validation warnings.
9. **Availability.** All territories except those excluded in SPEC §11 (mainland China by default).
10. **Version.** Confirm version (1.0.0) in app config; build numbers auto-increment remotely.
11. **Pre-submission check.** S3 recorded in STATUS; IAP review screenshots of the real paywall uploaded and IAPs attached to the version; every RELEASE.md §Assets row approved.
12. **Final build.** Merge the release PR to `main`; the production workflow builds and submits (or confirm the latest TestFlight build has the final code: same fingerprint and no pending JS → no new build needed).
13. **User clicks (list them, then wait):**
   - App Store Connect: select build, age rating, pricing/availability, privacy labels, attach IAPs, App Review info → Submit for Review
   - Play Console: confirm closed test has run 14 days with 12+ testers → apply for production → when approved, promote with staged rollout
14. **Record** submission dates in STATUS.md.

## After submission

- Rejection: paste the message; use rejection-handler to decide fix vs reply; fix on a branch; resubmit. Most fixes are metadata or a missing flow, not code.
- Approval: release manually; watch Sentry and RevenueCat for 48 hours; reply to early reviews.
- Monthly, per live app: check Apple, Google Play, privacy-law and consumer-law changes that affect it; log the check and any change needed in STATUS.
- v1.0.1: P2 items from REVIEW.md. JS-only → OTA update; native → store build.
- Start the next app: `/app-factory new` in a new repo from the template. Anything learned that applies to every app goes back into the template (and this skill).

## Gate G6

iOS submitted (date), Android status (closed test day N / production). Then run `/app-factory retro` (Phase 7) while the details are fresh.
