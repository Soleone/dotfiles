# render-flow

Display the component render hierarchy for files changed in a commit/branch to help reviewers understand the architecture.

## Output Format

- **File names** end with extensions (`.tsx`, `.ts`, `.graphql`)
- **Comments and metadata** in lowercase (props, options, conditional, etc.)
- **Indentation** shows parent-child relationships
- **Special markers** (⭐) highlight key positioning decisions
- **Group by user flow** (Create/Edit, Dashboard, View, etc.)

## Example Output

```
Feature Name - Render Flow Hierarchy

User Flow Name
└── ParentComponent.tsx
    └── ChildComponent.tsx
        ├── props: value, onChange, disabled
        ├── conditional: only renders if prop provided
        └── GrandchildComponent.tsx
            ├── options: 'option1' | 'option2'
            └── displays: formatted value

Another User Flow
└── DashboardComponent.tsx
    ├── FilterComponent.tsx (toolbar filter)
    │   └── options: 'all' | 'filtered'
    └── DataGridComponent.tsx
        ├── column definition in constants.ts
        └── cellRenderers.tsx: customRenderer()
            └── displays: capitalized value
```

## When to Use

- **PR documentation**: Help reviewers understand component structure
- **Architecture explanation**: Show how components relate to each other
- **Data/prop flow**: Visualize how data moves through the component tree
- **Feature overview**: Quick reference for where UI elements are rendered

## Tips

- Start with the user-facing flows (Create/Edit, Dashboard, View)
- Show only components that changed or are relevant to the feature
- Include context providers and their initialization logic
- Highlight unusual positioning decisions with markers (⭐)
- Keep it concise - focus on the render tree, not implementation details
