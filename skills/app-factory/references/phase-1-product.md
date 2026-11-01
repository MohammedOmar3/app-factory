# Phase 1: Product (idea → approved SPEC.md)

Goal: decide whether to build, and if so, exactly what v1 is. Target: half a day to day 1. Gate G1.

Phase 1 can run before Phase 0 (in any repo or a scratch folder) when the user is still choosing what to build.

## Flow

### 1. Capture (superpowers:brainstorming)

Use brainstorming's one-question-at-a-time style to get: who the user is, the painful moment, what they do today, why now. Stop brainstorming before it proposes a technical design; the stack is fixed. Its design-doc output goes into SPEC.md sections 1-3, not `docs/superpowers/specs/`.

No idea yet? Use `apple-skills` product idea discovery, filtered by: buildable in 14 days with the contract stack, no hardware or Apple-only APIs Expo can't reach, monetizable with one `pro` tier.

### 2. Validate (apple-skills product)

Run the product validation steps on the idea, adapted:

| Apple-skills step | What to keep | Output into SPEC.md |
| --- | --- | --- |
| Problem discovery | Severity, frequency, who pays | §2 Problem, with a 1-5 severity score |
| Competitive analysis (WebSearch) | 3-5 real competitors on App Store and Play: price, rating, ratings count, top-grossing rank in the category (US and UK), subscription or not, what reviewers complain about | §4 Competitors, with links; evidence for §10 |
| MVP scoping | Core loop + must-haves only | §5 Scope |
| Positioning | One sentence value prop, the differentiator | §3 Positioning |
| Monetization | Free vs `pro` split, prices | §6 Monetization |
| App naming | 3 candidates, checked for store collisions | §1 Name |
| Originality check (app-store) | Guideline 4.3 risk: is this a clone or template-ish? | §8 Risks |

Skip market sizing (TAM/SAM/SOM); it doesn't change a 14-day decision.

### 3. Cut (scope guard)

Apply hard limits, then show the user what was cut:

- One core loop a new user completes in under 60 seconds.
- At most 5 screens beyond onboarding, paywall and settings (those come from the template).
- One paid tier (`pro`). Free tier must be genuinely useful (review guideline and conversion).
- No social features, chat, feeds, maps, AI features or admin panel unless they *are* the core loop.
- Everything cut goes to `LATER.md` with one line each.

### 4. Revenue analysis

The goal of every app is revenue (£2k+/month within six months), so G1 needs evidence that money exists in this category. Fill SPEC §10:

- **The bar:** at least 3 competitors in the top 200 grossing for the category (US or UK), and at least one of them a subscription app with 1,000+ ratings.
- **Evidence table:** each competitor's grossing rank, ratings count, price model, and the source.
- **The gap:** what this app can win that they don't do well (from §4 complaints and §3 positioning).
- **Risks and confidence:** what could stop the revenue, and a confidence score 1-5.
- **Recommendation:** build, rework (what to change) or drop.

Sources: free ones first (App Store and Play top-grossing charts, competitor store pages, ratings counts). Use a paid market tool only if `app-factory.config.json` `marketData.tool` names one. **Never auto-kill:** the bar informs the user's decision; below the bar, say so plainly and explain what that means for the £2k goal.

### 5. Legal screen

Fill SPEC §11 before G1:

- Is the category regulated or reviewed more strictly? (health and medical, finance, gambling, VPN, kids, dating, AI companions)
- Likely audience age, and whether the app could attract children.
- Territories to exclude (mainland China by default; others the category requires).
- The store rules and laws that apply, each with the rule cited.

### 6. Risk check

Write §9 Risk check: the 1-2 facts that would make this hard to win (e.g. "a free app already does X well", "needs data we can't get"). Check each with a search. Report honestly; the result feeds the recommendation, it doesn't stop the idea on its own.

### 7. Data

Start `docs/DATA.md` from `templates/DATA.md`: every piece of user data v1 needs, which service holds it, and why.

## Gate G1

Present: the one-sentence pitch, the core loop, screen list, price, the §10 revenue analysis against the bar, the §11 legal screen, the top risk, and your recommendation (build / rework / drop). The user decides, including building below the bar. Record decision and date in STATUS.md.

Output: `docs/SPEC.md` (from `templates/SPEC.md`), `docs/DATA.md`, `LATER.md`.
