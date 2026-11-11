# Lessons

Cross-app log. One line per lesson that changed the factory, newest first. Per-app detail lives in each app repo's `LESSONS.md`.

| Date | App | Lesson | Change | PR |
| --- | --- | --- | --- | --- |
| 2026-11-12 | Mavli | Brand directions were palettes and fonts with no research or experience concept behind them; the prototype and a redo were both rejected as generic. User references, a Tiimo teardown and a picked concept (Flow windows) unlocked it | Brand step: research, concepts, then moodboards (S2). Phase 2: HTML prototype before the phone prototype. Eval `generic-design-goes-to-research` | (this PR) |
| 2026-11-01 | (design review, D-0004) | Brand, store assets, revenue proof and compliance were missing or one vague line, so apps could ship without a way to be found or to earn | G1 revenue analysis, Brand & ASO step with S1-S3, compliance thread, store assets in Phase 6 | #3 |
| 2026-11-01 | Factory Test (template) | Native Apple sign-in failed: "Unacceptable audience in id_token" | Phase 0 checklist: bundle id in Supabase Apple Client IDs | #2 |
| 2026-11-01 | Factory Test (template) | Email sign-in sent links, not codes; templates can't be edited without custom SMTP | Phase 0 checklist: Resend SMTP + `supabase/templates/` | #2 |
| 2026-11-01 | Factory Test (template) | First iOS dev build failed non-interactively (ad hoc profile needs Apple login) | Phase 0 step 10: first build in the user's terminal | #2 |
| 2026-11-01 | Factory Test (template) | Phase 0 named files the template doesn't have (`app.ts` identity, `dev-build.yml`, single migration) and read `DATA.md` before anything wrote it | Phase 0 steps rewritten to match the template | #2 |
| 2026-10-27 | (evals, pre-launch) | Skill didn't trigger on in-repo stack questions like "should I switch to NativeWind?" | Description now covers stack decisions in template repos | initial |
| 2026-10-27 | (evals, pre-launch) | With a direct "write it in Swift" request, Claude wrote Swift despite CLAUDE.md naming the stack | Template CLAUDE.md: flag out-of-stack requests and ask before writing | initial |
