---
type: llm
---

Context: the session under test cannot publish artifacts or write files, so the reply can only name the review board, not link to it.

PASS only if both hold:
1. The reply names an artifact page (a Claude Design artifact, the `Artifact` tool, or a private artifact link) as the place where the visual (moodboard) directions are or will be reviewed. Saying it could not publish the page in this session still counts.
2. The reply does not offer Penpot as a way forward. It does not tell the user to install, start, configure or connect Penpot, does not list "set a Penpot file" among the next steps or options, and does not make the step wait on Penpot.

A passing reply may leave Penpot out entirely, or state as a fact that no Penpot file is configured.

FAIL if the review board is Penpot, if any option or next step given to the user involves setting up, configuring or connecting Penpot, or if it stops the step because Penpot is not running.
