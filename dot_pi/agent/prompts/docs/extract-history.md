# extract-history [topic]

Extract the essence of the current session's journey into a history document for future reference or blog posts.

## Arguments

- `topic` (optional): What to extract. Examples:
  - "how we invented TSD notation"
  - "debugging the authentication flow"
  - "refactoring the campaign builder"
  - If omitted, extracts the main topic/achievement from current session

## Purpose

Captures the iterative process of problem-solving, design decisions, and learnings from a development session. Useful for:
- **Future reference** - remember why decisions were made
- **Blog posts** - share the journey, not just the result
- **Team knowledge** - document problem-solving patterns
- **Learning** - preserve failed attempts alongside successes

## Output Format

A markdown document in `~/.claude/history/YYYY-MM-DD-topic-name.md` containing:

1. **The Problem** - what we were trying to solve
2. **The Journey** - chronological attempts with what didn't work and why
3. **The Breakthrough** - the key insight that led to the solution
4. **Key Learnings** - principles discovered through iteration
5. **The Result** - final solution with examples
6. **Comparison** - how it relates to existing solutions/standards
7. **The Process** - what made this work (first principles, iteration, etc.)
8. **Meta Reflection** - broader insights about design, problem-solving, collaboration

## Key Principles

1. **Preserve failures** - failed attempts teach as much as successes
2. **Show iteration** - the path matters, not just the destination
3. **Capture insights** - specific learnings (avoid X because Y)
4. **Be honest** - what confused us, what we got wrong first
5. **Include context** - why this mattered, what constraints existed
6. **Think blog-worthy** - write for an audience who wasn't there
7. **Date and version** - make it a historical record

## Example Output

```markdown
# The Journey to [Solution]: [Problem Solved]

**Date:** YYYY-MM-DD
**Context:** Brief description of the situation

## The Problem
What we were trying to solve and why existing solutions didn't work...

## The Journey

### Attempt 1: [Approach Name]
What we tried...
**Problem:** Why it didn't work...

### Attempt 2: [Approach Name]
What we tried next...
**Problem:** Why it didn't work...

### Breakthrough: [Key Insight]
What finally clicked...
**Why this works:** ...

## Key Learnings
1. Principle 1 - explanation
2. Principle 2 - explanation

## The Result
Final solution with example...

## Comparison
How this relates to existing standards...

## The Iterative Process
What made this work...

## Meta Reflection
Broader insights...
```

## When to Use

- After solving a complex problem through iteration
- When inventing a new pattern, notation, or approach
- After debugging sessions with interesting insights
- When discovering best practices through trial and error
- After design discussions that led to clarity
- Anytime the journey was as valuable as the destination

## Storage

Files are stored in `~/.claude/history/` with naming convention:
- `YYYY-MM-DD-topic-name.md`
- Date prefix for chronological sorting
- Descriptive topic name (kebab-case)
- Markdown format for readability

## Tips

- Extract while memory is fresh (end of session)
- Include both technical and process insights
- Write for future you (or someone reading 6 months later)
- Don't sanitize the mess - the confusion and false starts are valuable
- Think: "Would this make an interesting blog post?"
