#!/usr/bin/env bash
set -euo pipefail
mkdir -p docs
cat > app-factory.config.json <<'JSON'
{ "owner": "Test Owner", "webBaseUrl": "https://example.com", "bundleIdPrefix": "com.example", "sentry": { "org": "example", "region": "eu" } }
JSON
cat > package.json <<'JSON'
{ "name": "new-app", "dependencies": { "expo": "*", "expo-router": "*", "react-native-purchases": "*", "@supabase/supabase-js": "*" } }
JSON
cat > CLAUDE.md <<'MD'
# House rules for this app
This repo was made from expo-app-factory. Work through the app-factory skill: read docs/STATUS.md at the start of a session.
Stack is fixed: Expo + Expo Router + TypeScript, Supabase, RevenueCat, Sentry, EAS. iOS + Android.
MD
cat > docs/STATUS.md <<'MD'
# Status: Streakly
| Field | Value |
| --- | --- |
| Slug | streakly |
| Today | Day 1 of 14 |
| Phase | 1 Product |
## Gates
| Gate | Decision | Date | Notes |
| --- | --- | --- | --- |
| G1 Build it? | | | spec drafted, revenue analysis recommends rework |
MD
cat > docs/SPEC.md <<'MD'
# Streakly — v1 spec
## 1. Working title
- Working title: Streakly
- One sentence: For people building daily habits who lose motivation, Streakly tracks streaks and nudges them each day.
## 2. Problem
- People drop habits within weeks; they use notes or spreadsheets today. Severity 3.
## 4. Competitors
| App | Store | Price | Rating | What reviewers complain about |
| --- | --- | --- | --- | --- |
| Habitica | App Store | Free + premium | 4.6 | cluttered game layer |
| Streaks | App Store | £4.99 once | 4.8 | no Android |
## 5. Scope (v1)
- Core loop: add a habit, check it off each day, see the streak
## 6. Monetization
- `pro`: unlimited habits, widgets. £2.99/month, £14.99/year.
## 9. Kill criteria
| Criterion | Checked how | Result |
| --- | --- | --- |
| A free app already does this well | search | Several free habit trackers exist |
## 10. Revenue analysis
- Evidence: top-grossing charts (US and UK, Health & Fitness and Productivity) checked on the App Store.
- Competitors in the top 200 grossing: 1 (Habitica).
- Subscription competitor with 1,000+ ratings: yes (Habitica).
- Bar: not met (only 1 competitor in the top 200 grossing).
- Recommendation: rework (find a niche with proven paying demand, or a stronger paid hook) before building.
## 11. Legal screen
- Category: habit tracking for general wellbeing; not a regulated category.
- No health claims, no medical advice, no children's audience, no gambling or finance features.
- Territories: all except mainland China (default).
- Result: no extra rules beyond the standard checklist.
MD
