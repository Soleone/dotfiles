---
description: Premium targeted onboarding kit for a specific subsystem, flow, or feature area
argument-hint: "<area / flow / feature / concern>"
model: opus
---

# Premium Targeted Onboarding Kit

I already know this codebase broadly. I do **not** need whole-repo onboarding.
I need a **fast, high-signal, next-gen onboarding kit** for this specific area:

**Target**: $@

Your job is to help me understand this area quickly enough that I can discuss it confidently in a pairing session and start making safe changes.

## Core Goal

Optimize for **fast operational understanding**, not exhaustive coverage.
Use **progressive disclosure**: map first, then flow, then state, then code reading plan.
Prefer **small high-value visualizations** over long prose.

## Scoping Rules

- Scope yourself tightly to the target area above.
- If the request is ambiguous or too broad, first define a narrower working scope and state it clearly.
- Only pull in neighboring systems when they directly affect this area.
- Trust the code over stale docs if they conflict.
- Flag unknowns explicitly instead of guessing.
- Separate **facts**, **strong inferences**, and **open questions**.
- If there are multiple plausible entrypoints or interpretations, show the top ones ranked by likelihood.

## Mode Selection

Before producing the kit, infer the best primary mode for this target and state it in one line:

- `architecture-first`
- `flow-first`
- `state-first`
- `ui-interaction-first`
- `async-job-first`
- `debugging-first`
- `edit-safely-first`

Then bias the kit accordingly while still producing all sections.

## Deliverable

Produce the onboarding kit in this exact order.
Keep it sharp, visual, and easy to skim live.

### 0. TL;DR Dashboard

Start with a compact dashboard:

- chosen scope
- chosen mode
- 5 most important modules / files / components
- 3 biggest complexity drivers
- 3 biggest risks / easy-to-miss traps
- confidence level for the overall map

Keep this to one screen.

### 1. Scope Contract

In 5-10 bullets, state:

- what is in scope
- what is out of scope
- likely entrypoints
- main entities / concepts involved
- adjacent systems that matter
- the central question this area answers in the product / system

### 2. Executive Map

Give a concise high-level summary with:

- what this area is responsible for
- where the main logic seems to live
- the main layers involved:
  - UI / caller
  - transport / handlers / controllers
  - orchestration
  - business logic
  - persistence
  - async side effects
- key dependencies and boundaries
- the main source(s) of complexity

### 3. Architecture Views

Use **small Mermaid diagrams**. Do not create giant unreadable diagrams.

#### 3a. Mini C4 / Component View

Show:

- actors / callers
- main components or modules in this area
- data stores
- external systems
- labeled relationships

#### 3b. Data-Flow View

Show how the main entity or payload moves and transforms:

- entry trigger / input
- validation / normalization
- important transformations
- reads / writes
- emitted events / notifications / downstream actions
- final output / response / UI state update

Use Mermaid flowchart syntax if appropriate.

#### 3c. Dependency / Ownership Lens

Add a compact textual map showing which module owns:

- validation
- authorization
- orchestration
- business rules
- persistence
- side effects
- caching / memoization if relevant
- feature flags / configuration if relevant

### 4. Runtime Walkthrough

Trace **1-2 concrete scenarios** end-to-end.

For each scenario include:

- scenario name
- actual or likely entrypoint
- ordered flow steps
- modules / functions crossed
- where validation happens
- where authorization / guards happen
- where business decisions happen
- where DB reads / writes happen
- where side effects happen
- what output is produced

Then include a **Mermaid sequence diagram** for the primary scenario.

### 5. State Model

If state matters here, provide:

- important states
- allowed transitions
- triggers for transitions
- invariants / guards
- failure / retry / cancellation behavior

Include a **Mermaid state diagram** if the area has meaningful lifecycle complexity.
If state is not central here, explicitly say so and explain why.

### 6. Logic & Responsibility Matrix

Give me a compact table:

| Concern | Where it lives | Why it matters | Confidence |
|---|---|---|---|
| validation | ... | ... | ... |
| authorization | ... | ... | ... |
| orchestration | ... | ... | ... |
| business rules | ... | ... | ... |
| persistence | ... | ... | ... |
| side effects | ... | ... | ... |

Only include rows that truly apply.

### 7. Reading Itinerary

Give me the **7 most important code locations** to inspect next, in order.

For each location include:

- path
- what question it answers
- what to look for
- whether it is `foundational`, `risky`, or `optional`

Prefer a reading order that builds understanding with minimal context switching.

### 8. Hotspots, Traps, and Non-Obvious Behavior

List the important gotchas:

- hidden coupling
- naming that misleads
- surprising indirection
- stateful or temporal behavior
- retries / idempotency / races
- background jobs / events that are easy to miss
- stale docs or misleading tests if any

### 9. Verification Kit

Tell me how to verify my understanding quickly:

- most relevant tests
- logs / traces / metrics / network panels / devtools to inspect
- where to put breakpoints or temporary instrumentation
- one minimal safe experiment to confirm the flow

### 10. Unknowns and Next Questions

End with:

- what you are confident about
- what remains uncertain
- the 3 best follow-up questions if I want to go deeper

## Style Rules

- Prefer **clarity over completeness**.
- Prefer **small diagrams over giant diagrams**.
- Prefer **specific file paths / module names / entity names** over generic labels.
- Use short bullets and tight tables where possible.
- Do not dump low-value implementation trivia.
- Keep prose dense and useful enough for a live pairing session.
- When helpful, use confidence labels such as `high`, `medium`, `low`.
- If the scope is still too broad after narrowing, split it into **Phase 1: orientation** and **Phase 2: deeper dive**, but still complete Phase 1 fully.

## Final Quality Bar

The result should feel like a premium subsystem onboarding pack:

- a map of the area
- a runtime truth view
- a data movement view
- a state view when relevant
- a prioritized reading plan
- a verification strategy
- explicit unknowns

I should finish reading it and know:

1. what this area owns
2. how the main scenario actually works
3. where the risky logic and state live
4. what to read next
5. how to validate my mental model quickly
