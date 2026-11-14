---
type: llm
---

PASS only if both hold:
1. The reply says the visual (moodboard) directions will be reviewed on an artifact page (a Claude Design artifact, the `Artifact` tool, or a private artifact link).
2. The reply does not tell the user to install, start, set up or connect Penpot, and does not make the step wait on Penpot.

A passing reply may leave Penpot out entirely, or name it once as an optional tool that is not in use.

FAIL if the review board is Penpot, if the reply asks the user to install, run or connect Penpot before the directions can be shown, or if it stops the step because Penpot is not running.
