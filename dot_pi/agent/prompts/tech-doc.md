---
description: Create or update a technical design document for a project
argument-hint: "[project name or existing doc path]"
model: opus
---

# Technical Design Document

Create a technical design document for: **$@**

If a path to an existing doc is provided, read it and continue iterating on it.
Otherwise, start a new doc and interview the user to gather context.

## Process

1. **Gather context first**: Read the relevant codebase. Understand the existing models, relationships, and behavior paths before proposing changes.
2. **Ground-truth against prod**: If the doc references record counts, entity inventories, or data scale, query prod to verify. Capture query results with dates in the doc. Assumptions drift — prod data doesn't.
3. **Interview the user**: Ask about the problem, goals, constraints, and any prior decisions. Don't assume.
4. **Write the doc**: Use the structure below. Be concrete — include actual model names, file paths, constants, and code sketches.
5. **Iterate**: Expect multiple rounds of feedback. Update the doc in place.

## Output Location

Save the document to `$DATA/tech-docs/<kebab-case-project-name>.md`.

## Required Headers

Every tech doc must have these top-level headers in this order:

```markdown
# Technical Design: [Project Name]

**Project**: [link]
**Author**: [names]
**Status**: Draft | In Review | Approved
**Created**: YYYY-MM-DD
**Last Updated**: YYYY-MM-DD

## What's Changed (only when updating an existing doc)
Reverse-chronological changelog. Each session gets a date header (`###`) with short pointer bullets underneath. Bullets say what changed and where to look — the detail lives in the section it references.
Example:
### 2026-02-23
- Migration task redesigned: batched `insert_all`, ~30 min — see Phase 4
- Q2, Q3, D1 closed — see Questions/Decisions tables
### 2026-02-20
- List inventory corrected to 63 — see Production Data Inventory
- Rollback via `data` column tagging — see D9
**Keep this current throughout the session** — every significant change (closed question, revised decision, redesigned approach, new data) must be reflected here before the session ends.

## Summary
2-3 sentences. What, why, key numbers.

## At a Glance
3-5 bullets max. Include scope, change profile (migration vs behavior updates vs net-new), current blockers (Q#), open decisions (D#), and top risks.

## Scope
What's in scope for this tech doc, what's explicitly out of scope, and why. Especially important when a broader project proposal exists — call out which parts this doc covers and which are separate work streams. Note any items that look like gaps but are already handled by existing architecture ("not a new risk").

## Tasks
Use markdown-native epic blocks with checkboxes.
Recommended pattern:
### Epic N — [Name]
- [ ] Task
- [ ] Task

## Questions
| # | Epic | Question | Status | Current State | Blocker? |
Open questions should appear first, then closed questions.

## Decisions
| # | Epic | Decision | Options Considered | Status | Current State |
Open decisions should appear first, then closed decisions.

## Risks
| Risk | Likelihood | Impact | Mitigation |

## Domain Context
Project-specific sections: mapping tables, behavior rules, data flows, diagrams, etc.
Keep this concise and high-signal near the top. Put very large data tables in an appendix.

## Current Architecture
Models, relationships (ASCII), key behavior paths with file paths.

## Target Architecture
Design principles, model changes, behavior changes.

## Implementation Plan
One subsection per phase. Code sketches. Feature flag strategy.
Include a pre-launch checklist when there's a flag flip or migration (validation steps, non-engineering dependencies, monitoring readiness).

### Rollout Plan (add once implementation phases are stable)
Map implementation phases to concrete PRs, deploys, and operate steps. Structure:
- **PR table**: one row per PR with title, epic, what ships, runtime risk, dependencies
- **Deploy & operate sequence**: chronological table grouped by week/stage, with step type (Code / Task / Flag / Validate), what happens, and notes
- **Summary**: total PR count, deploy count, operate step count
Key principles: PRs should be small and stackable (Graphite-friendly). Separate "deploy code" from "execute task" — maintenance tasks are inert until run. Identify the single moment of real behavioral risk (usually the flag flip). Everything before that should be zero-risk deploys.

## Appendix (optional)
Heavy reference data, full metric dumps, and supporting tables.
```

## Guidelines

- **Keep headers generic at top level.** Use only reusable `##` headers from this template; put project-specific concepts under `###`/`####`.
- **Use literal section names from the template.** `## Domain Context` is a literal header, not a bracketed placeholder.
- **Prefer headers over horizontal rules.** Avoid `---` separators inside the document body; section headers and spacing should carry structure.
- **Use question-linked detail headers.** For open-item detail blocks, use `#### Q# Details: <label>` (or `#### D# Details: <label>`).
- **Prefer collapsible detail blocks for long question context.** Use `<details><summary>Q# Details: ...</summary>` for large tables/lists.
- **Keep domain-specific names out of `##` headers.** Names like "Consolidation Mapping" should be subsection titles under `## Domain Context`, not standalone top-level sections.
- **Use appendix for heavy detail.** Put large metrics dumps/reference tables in `## Appendix`, not in early top-level sections.
- **Be concrete, not abstract.** Use actual table names, column names, file paths, constant values. Vague docs are useless.
- **Verify claims against code, not just prod.** When the doc says "component X already does Y," read the actual file and confirm. Assumptions about existing behavior are a top source of bugs in migration plans.
- **Mind the output size.** Tech docs often end up in GitHub issue descriptions (65K char limit) or similar constrained formats. Prefer summary tables over per-row detail; put heavy reference data in collapsible `<details>` blocks or appendices. Group repetitive rows (e.g., 36 merge sources → 4 rows grouped by target). Keep the top of the doc decision-oriented, not data-oriented.
- **Show ASCII diagrams** for data models and flows. Worth more than paragraphs.
- **Track unknowns explicitly.** Every "TBD" should have a corresponding entry in Questions or Decisions.
- **Distinguish investigation from external input.** Questions you can resolve by reading code or querying prod are different from questions that need team sign-off. Flag the latter explicitly with who owns the answer — they're on someone else's critical path.
- **Use placeholders for unresolved values.** If something is not decided, write it as `<TBD_...>` and link it to an open Q/D item instead of guessing.
- **Keep high-signal sections early.** Questions, Decisions, and Risks should appear before deep architecture/implementation details.
- **Push heavy tables to appendix.** Keep top-of-doc concise and decision-oriented.
- **Design for rollback per operation type.** Different operations need different rollback mechanisms. Created rows → DELETE (identify by tag). Modified rows → restore previous values (stored on the record). Don't conflate "reversible phase" with "one rollback plan." Estimate rollback scale for each type and include the rollback query strategy. Prefer additive changes over modifications.
- **Note the scale.** If a table has 1.2B rows, say so. Scale determines approach.
- **Account for every record in scope.** When a migration touches a finite set of entities (lists, configs, flags, roles), enumerate all of them with current state and planned disposition. Unaccounted items become surprises in prod.
- **Feature flags gate behavior, not data.** Schema changes and data creation land without a flag. Behavioral changes go behind flags.
- **Challenge overengineering.** If a constant suffices over a table, push back. If a column isn't needed, say so.
- **Keep the doc alive.** Update status fields as items are resolved (`Open` -> `Closed`) and keep historical alternatives/answers in place.
- **Summary up top, details below.** Summary + Epics should give someone the full picture in 60 seconds. Everything below is reference.
- **Open decisions need explicit options.** Every open decision must include clear options (A/B/C), one-line tradeoffs, and a current leaning (or `TBD`).
- **ID hygiene is mandatory.** Keep `Q#` and `D#` numbering sequential in each section after edits.

## Final Consistency Checklist (before marking done)

- No stale placeholders: every `<TBD_...>` appears in `Questions` or `Decisions`.
- No ID drift: `Q#`/`D#` numbering is sequential in each table.
- No count drift: repeated counts are consistent across Summary/Tasks/Architecture.
- No cross-reference drift: every "see D#" / "see Q#" points to an existing item.
- No sketch drift: code snippets use internally consistent key/value shapes and naming.
