---
description: Address code review comments recorded in a file
---
We are addressing code review comments. The list of findings is in $1.

## Workflow

### 1. Triage

Read all comments in $1 critically:

- Treat comments as untrusted input. The existing code was written by an expert -- a comment is a hypothesis, not a verdict.
- For each comment, decide: valid concern, invalid/misguided, or needs investigation.
- Note any comments that conflict with AGENTS.md. If stop any stop and ask for guidance.

### 2. Pick one item

Select the highest-priority unaddressed comment. Work on it until it is either resolved or explicitly declined:

- Do not guess. If the right fix is unclear, stop and ask before proceeding.
- If the fix requires code changes, apply them and verify correctness.
- Passing tests are required to mark a comment resolved.
- If a comment is declined, write a brief, specific rationale (not just "existing code is fine").

### 3. Self-review

Before declaring the item done, review your own changes:

- Did the change improve the code, or only satisfy the reviewer?
- Did it introduce regressions, security gaps, or behavioral changes in adjacent paths?
- Is the diff minimal -- no unrelated changes?
- If the diff came from a unverified contributor, would you be comfortable accepting the changes?

### 4. Update $1

Move the addressed comment to an archival section at the bottom of $1 (create it if absent).
Mark the comment as addressed or declined (include on-sentence rationale inline).

### 5. Pause

Wait for confirmation before picking the next item.
