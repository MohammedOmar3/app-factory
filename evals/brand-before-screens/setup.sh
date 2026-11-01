#!/usr/bin/env bash
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
MD
cat > docs/STATUS.md <<'MD'
# Status: Sprout
| Field | Value |
| --- | --- |
| Slug | sprout |
| Today | Day 3 of 14 |
| Phase | 2 Design |
## Gates
| Gate | Decision | Date | Notes |
| --- | --- | --- | --- |
| G1 Build it? | build | 2026-10-20 | |
| G2 Design approved | | | |
MD
cat > docs/SPEC.md <<'MD'
# Sprout — v1 spec
## 5. Scope (v1)
- Core loop: add a plant, get a watering reminder, mark watered
- Screens: 1. Home (today's plants) 2. Plant detail 3. Add plant
MD
