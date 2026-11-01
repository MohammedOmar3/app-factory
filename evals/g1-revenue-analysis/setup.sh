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
# Status: Pillwise
| Field | Value |
| --- | --- |
| Slug | pillwise |
| Today | Day 1 of 14 |
| Phase | 1 Product |
## Gates
| Gate | Decision | Date | Notes |
| --- | --- | --- | --- |
| G1 Build it? | | | spec drafted |
MD
cat > docs/SPEC.md <<'MD'
# Pillwise — v1 spec
## 1. Name and pitch
- Name: Pillwise
- One sentence: For people on several medications who forget doses, Pillwise reminds them and tracks what they took.
## 2. Problem
- Missed doses; people use phone alarms today. Severity 4.
## 4. Competitors
| App | Store | Price | Rating | What reviewers complain about |
| --- | --- | --- | --- | --- |
| Medisafe | App Store | Free + premium | 4.7 | ads, nagging upsells |
| MyTherapy | App Store | Free | 4.8 | dated design |
## 5. Scope (v1)
- Core loop: add a medication with a schedule, get a reminder, mark taken
## 6. Monetization
- `pro`: unlimited medications, history export. £2.99/month, £14.99/year.
## 9. Kill criteria
| Criterion | Checked how | Result |
| --- | --- | --- |
| A free app already does this well | search | Medisafe is free with premium |
MD
