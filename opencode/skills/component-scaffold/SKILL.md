---
name: component-scaffold
description: Step-by-step guide for scaffolding a new TypeScript frontend component with the correct file structure, exports, types, Vitest test file, and Storybook story stub.
license: MIT
compatibility: opencode
metadata:
  audience: frontend-engineers
  workflow: scaffolding
---

## New Component Scaffold Guide

Follow these steps when creating a new reusable TypeScript component. Adapt the framework-specific parts to the project at hand (React, Vue, Svelte, or Angular).

---

### Step 1: Determine placement

- **Reusable UI primitive** (Button, Input, Modal): `src/components/ui/ComponentName/`
- **Feature-specific component**: `src/features/<feature-name>/components/ComponentName/`
- **Page-level component**: `src/pages/<page>/components/ComponentName/`

Use a **folder per component** so the component, tests, and styles live together:

```
ComponentName/
├── ComponentName.tsx       # Component implementation
├── ComponentName.test.tsx  # Vitest tests
├── ComponentName.module.css   # CSS Modules (if used in this project)
└── index.ts                # Re-export
```

If the project uses Storybook, also add `ComponentName.stories.tsx`. Load the `storybook` skill for story-writing conventions.

---

### Step 2: Write the TypeScript interface first

Before writing the component, define the props interface. This clarifies the component's contract and enables TSDoc.

```typescript
// ComponentName.tsx

/**
 * Props for the ComponentName component.
 */
export interface ComponentNameProps {
  /** Primary content rendered inside the component. */
  children: React.ReactNode;

  /** Visual variant. @default "default" */
  variant?: 'default' | 'outlined' | 'filled';

  /** Additional CSS class names to apply to the root element. */
  className?: string;
}
```

Rules:
- Export the props interface — consumers need it for extension and typing.
- All optional props must have a `@default` TSDoc tag.
- Avoid `any`. Use proper generics or union types.
- Prefer `React.ReactNode` over `string` for content props (more composable).

---

### Step 3: Implement the component

```typescript
import type { ComponentNameProps } from './ComponentName'

export function ComponentName({
  children,
  variant = 'default',
  className,
}: ComponentNameProps) {
  return (
    <div
      className={cn(styles.root, styles[variant], className)}
      data-variant={variant}
    >
      {children}
    </div>
  )
}

ComponentName.displayName = 'ComponentName'
```

Rules:
- Use named exports — not default exports (easier to refactor, better IDE support).
- Set `displayName` for React components (improves DevTools and error messages).
- Accept a `className` prop on any element that wraps content, so consumers can extend styles.
- Keep the component pure where possible — no side effects in render.

---

### Step 4: Write the index re-export

```typescript
// index.ts
export { ComponentName } from './ComponentName'
export type { ComponentNameProps } from './ComponentName'
```

Always re-export the type alongside the component so consumers can import both from the same path.

---

### Step 5: Write the Vitest test file

```typescript
// ComponentName.test.tsx
import { describe, it, expect, vi } from 'vitest'
import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { ComponentName } from './ComponentName'

describe('ComponentName', () => {
  it('renders children', () => {
    render(<ComponentName>Hello</ComponentName>)
    expect(screen.getByText('Hello')).toBeInTheDocument()
  })

  it('applies the correct variant', () => {
    render(<ComponentName variant="outlined">Hello</ComponentName>)
    expect(screen.getByText('Hello').closest('[data-variant]'))
      .toHaveAttribute('data-variant', 'outlined')
  })

  // Add interaction tests, async state tests, edge cases...
})
```

Minimum test cases for every component:
1. Renders without crashing with minimal props
2. Renders children/content correctly
3. Each meaningful prop variant changes output
4. User interactions (if any) work correctly
5. Async states: loading, error, success (if applicable)

---

### Step 6: Checklist before committing

- [ ] Props interface is exported and fully documented with TSDoc
- [ ] Component uses named export
- [ ] `index.ts` re-exports component and props type
- [ ] Vitest tests cover render, props, and interactions
- [ ] If the project uses Storybook, load the `storybook` skill and add a story file
- [ ] No `any`, no `console.log`, no hardcoded strings that should be props
- [ ] Responsive behavior handled if this is a layout component
- [ ] Accessibility: interactive elements use correct HTML semantics, labels present

---

### Framework-specific notes

**Vue 3 (Composition API)**
- Use `defineProps<ComponentNameProps>()` with TypeScript generic syntax
- Export types from a separate `types.ts` or inline in the component file
- Story template uses `<ComponentName v-bind="args" />`

**Svelte 5**
- Props via `let { children, variant = 'default' }: ComponentNameProps = $props()`
- Export the TypeScript interface from a `.ts` file co-located with the component
- Story: Svelte CSF or standard CSF with `@storybook/svelte`

**Angular**
- Use `@Input()` decorated class properties with TSDoc above each `@Input()`
- `selector` should follow the project's prefix convention (e.g., `app-component-name`)
- Story: `@storybook/angular` with `moduleMetadata` for dependencies
