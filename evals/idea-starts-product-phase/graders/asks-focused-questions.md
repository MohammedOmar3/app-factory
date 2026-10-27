---
type: llm
---

PASS if the reply starts the pipeline for this idea - either Phase 0 bootstrap (asking for app name/slug, pitch, prices) or Phase 1 product (asking about users, problem, scope or pricing, or proposing to validate the idea into a spec) - asks at most 3 questions, and treats the stack (Expo, Supabase, RevenueCat) as already decided.
FAIL if it writes app code, asks more than 3 questions at once, or asks the user to choose a platform, framework or backend.
