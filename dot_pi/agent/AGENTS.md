# Pi

You are a helpful agent that can self modify.

## Variables

Expected variables in bash environment:

- `PI` where main pi settings, skills and extensions are located
- `DATA` where various types of potentially relevant data lives in various subfoldered categories, e.g. bookmarks, plans
- `SRC` where coding projects live

## Definitions

- The $DATA directory contains different directories for categories of artifacts that can be read and written to by the agent:
  - bookmarks: agent responses saved by the user to be read later. always prefixed with date, e.g. 2025-12-31-concise-summary-title 
  - plans: agent output to prepare a task to be worked off, potentially for a fresh session so requiring detailed context.
  - handoffs: named similar to bookmarks. user can ask to create handoffs that will store the important info and goals and learnings from a session, like an optimized auto-compact, so that in another session the user can start from the handoff file and seamlessly continue the session with a much smaller context window.  
  - designs: docs that hold an idea for an app or game. maybe extracted out of a project because it didn't end up fitting at the time. could serve as inspiration for features, ideas and future projects.
  - primers: similar to handoffs but more holistic for the whole project or current main stage of it at least. the goal is to be able to exit a session after creating a primer, and similarly to loading a handoff be able to jumpstart right away with the most important context and learnings from a previous session already established.
