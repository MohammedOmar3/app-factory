#!/usr/bin/env bash
set -euo pipefail
mkdir -p docs kit/design
cat > app-factory.config.json <<'JSON'
{ "owner": "Test Owner", "webBaseUrl": "https://example.com", "bundleIdPrefix": "com.example", "sentry": { "org": "example", "region": "eu" }, "figma": { "templateFileUrl": "" }, "penpot": { "baseUrl": "http://localhost:9001", "mcpServer": "penpot", "templateFileUrl": "http://localhost:9001/#/workspace?team-id=t&file-id=sprout", "kitCatalogPath": "kit/design/kit-catalog.md", "libraries": ["iOS 27 Kit", "Lucide", "Flows & Wireframes - Flows", "Flows & Wireframes - Wireframes", "Device Frames"] } }
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
| Phase | Phase 2 Design: screens next |
## Gates
| Gate | Decision | Date | Notes |
| --- | --- | --- | --- |
| G1 Build it? | build | 2026-10-20 | |
| S1 Name | Sprout | 2026-10-21 | |
| S2 Direction | "Today's shelf", direction B | 2026-10-22 | Penpot board |
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
## Research
- Planta: clear schedule, but setup asks 9 questions before the first plant.
- Greg: friendly tone, but the home screen hides today's tasks under a feed.
## Concept
- Chosen (2026-10-21): "Today's shelf". One shelf of plants that need water today; a swipe marks one watered.
## Review board
- Penpot link: http://localhost:9001/#/workspace?team-id=t&file-id=sprout
MD
cat > kit/design/kit-catalog.md <<'MD'
# Kit catalog
## Libraries
| Name | Purpose |
| --- | --- |
| iOS 27 Kit | Apple iOS 27 components |
| Lucide | Icons |
| Flows & Wireframes - Flows | Flow arrows and step boards |
| Flows & Wireframes - Wireframes | Low-fidelity screen blocks |
## Components (iOS 27 Kit)
| Path | Variants | Use when | Expo native control |
| --- | --- | --- | --- |
| Bars/Navigation Bar/Large Title | Appearance: Light, Dark | Top of a root screen | Stack header, headerLargeTitle |
| Bars/Tab Bar/3 items | Selected: 1-3 | App with 2-5 top sections | expo-router NativeTabs |
| Lists/Row/Inset Grouped | Accessory: none, chevron, toggle | Grouped list items | custom (StyleSheet + tokens) |
| Lists/Swipe Actions | Side: leading, trailing | Swipe to act on a row | custom (react-native-gesture-handler) |
| Buttons/Filled | Size: S, M, L | Primary action | custom (StyleSheet + tokens) |
## Tokens
- color.*: text, textSecondary, background, surface, tint, danger, border
- spacing.*: xs, sm, md, lg, xl
- typography.*: title, headline, body, caption
## Gaps
| Missing | Needed for | Workaround |
| --- | --- | --- |
| Horizontal shelf carousel | — | custom with tokens, ask the user |
MD
cat > kit/design/HOW-TO-COMPOSE.md <<'MD'
# How to compose
1. Read the References page in the app file, and cite it.
2. Read kit-catalog.md.
3. Wireframe the flow first with the Flows & Wireframes libraries.
4. Use only library instances and tokens. Never draw native controls from rectangles.
5. Missing pieces go into Gaps; don't invent them.
MD
