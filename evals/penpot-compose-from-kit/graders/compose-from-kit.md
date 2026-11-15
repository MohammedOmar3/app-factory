---
type: llm
---

Context: the session under test has no Penpot MCP tools, so it can only describe how it will build the screen. It can read the repo, including `kit/design/kit-catalog.md`.

PASS only if all hold:
1. The plan builds the Home screen from kit library components and tokens (it names catalog components such as the navigation bar, list rows or tab bar from the catalog, or says it will use only catalog components and tokens).
2. The plan does not draw native controls by hand: it does not describe building a tab bar, navigation bar, list row, switch or button from rectangles, shapes or text.
3. Before drafting, the plan reads or asks for the References page in the Penpot file (or the user's references), or it wireframes the flow first with the Flows & Wireframes library. At least one of these must be stated as a step before high-fidelity work.
4. Something the catalog lacks (for example a horizontal shelf) is flagged as a gap or a question for the user, not silently invented as if it were a kit component.

FAIL if the plan draws native controls from primitives, ignores the kit catalog, or presents a component that is not in the catalog as a kit component.
