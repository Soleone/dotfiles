Description: Extract patterns and learnings from the current conversation to improve AGENTS.md or create new commands

Prompt:
Review the conversation history and identify:

1. Repeated corrections or feedback patterns (e.g., "use X instead of Y", "follow pattern Z")
2. Preferences about code structure, styling, or organization that came up multiple times
3. Project-specific conventions that were discovered during implementation
4. Any meta-patterns about how the user prefers to work or receive information

For each learning:
- Generalize it (remove specific examples, keep the principle)
- Determine if it belongs in AGENTS.md (general project guidance) or as a new command (repeatable workflow)
- Draft the addition in the appropriate format

Present:
1. Proposed AGENTS.md additions (as markdown sections)
2. Proposed new commands (with name, description, and prompt)
3. Reasoning for each suggestion

Keep suggestions concise and actionable. Focus on patterns that would genuinely improve future interactions, not one-off situations.

Usage: Run /extract-learnings at the end of a coding session to capture valuable patterns for future work. Always confirm with the user if they actually want to add these suggestions or not (default to no).