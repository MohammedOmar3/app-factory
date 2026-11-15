#!/usr/bin/env bash
set -euo pipefail
mkdir -p docs
cat > app-factory.config.json <<'JSON'
{ "owner": "Test Owner", "webBaseUrl": "https://example.com", "bundleIdPrefix": "com.example", "sentry": { "org": "example", "region": "eu" }, "figma": { "templateFileUrl": "" }, "penpot": { "baseUrl": "", "mcpServer": "penpot", "templateFileUrl": "" } }
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
| Today | Day 2 of 14 |
| Phase | Brand & ASO: moodboard directions next |
## Gates
| Gate | Decision | Date | Notes |
| --- | --- | --- | --- |
| G1 Build it? | build | 2026-10-20 | |
| S1 Name | Sprout | 2026-10-21 | |
| S2 Direction | Open | | Concept picked, moodboards not shown yet |
| G2 Design approved | | | |
MD
cat > docs/SPEC.md <<'MD'
# Sprout — v1 spec
## 5. Scope (v1)
- Core loop: add a plant, get a watering reminder, mark watered
- Screens: 1. Home (today's plants) 2. Plant detail 3. Add plant
MD
cat > docs/BRAND.md <<'MD'
# Sprout — brand
## Keywords
- Primary: plant care, watering reminder
## Name
- Chosen (S1, 2026-10-21): Sprout
## Research
- Planta: clear schedule, but setup asks 9 questions before the first plant.
- Greg: friendly tone, but the home screen hides today's tasks under a feed.
- The user should never have to open a plant to see if it needs water.
## Concept
- Chosen (2026-10-21): "Today's shelf". One shelf of plants that need water today; a swipe marks one watered.
## Review board
- Artifact (or Figma / Penpot) link:
MD
