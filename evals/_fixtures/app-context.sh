#!/usr/bin/env bash
# Shared scaffold: a minimal app repo made from the template, mid-build.
set -euo pipefail
mkdir -p docs
cat > app-factory.config.json <<'JSON'
{ "owner": "Test Owner", "webBaseUrl": "https://example.com", "bundleIdPrefix": "com.example", "sentry": { "org": "example", "region": "eu" } }
JSON
cat > package.json <<'JSON'
{ "name": "sprout", "dependencies": { "expo": "*", "expo-router": "*", "react-native-purchases": "*", "@supabase/supabase-js": "*" } }
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
| Today | Day 6 of 14 |
| Phase | 4 Build |
## Gates
| Gate | Decision | Date | Notes |
| --- | --- | --- | --- |
| G1 Build it? | build | 2026-10-20 | |
| G2 Design approved | approved | 2026-10-22 | |
| G3 Plan approved | approved | 2026-10-23 | |
MD
