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
If a request names a tool outside this stack (Swift/SwiftUI, StoreKit, Xcode, Firebase, NativeWind, GitHub Actions, a custom server), stop before writing anything: say it conflicts with the template, propose the in-stack equivalent via the app-factory skill, and ask.
MD
cat > docs/STATUS.md <<'MD'
# Status: Sprout
| Field | Value |
| --- | --- |
| Slug | sprout |
| Today | Day 1 of 14 |
| Phase | 1 Product |
## Gates
| Gate | Decision | Date | Notes |
| --- | --- | --- | --- |
| G1 Build it? | | | spec drafted, kill check not done |
MD
cat > docs/SPEC.md <<'MD'
# Sprout — v1 spec (draft)
## 5. Scope (v1)
- Core loop: add a plant, get a watering reminder, mark watered
## 9. Kill criteria
| Criterion | Checked how | Result |
| --- | --- | --- |
| A free app already does this well | not checked | |
MD
