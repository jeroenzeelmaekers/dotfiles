---
name: storybook
description: Conventions for writing Storybook stories in CSF3 format with TypeScript, covering React, Vue, Svelte, and Angular. Load this skill before writing or reviewing story files.
license: MIT
compatibility: opencode
metadata:
  audience: frontend-engineers
  workflow: documentation
---

## Storybook Story Conventions (CSF3)

Use these conventions whenever writing or reviewing Storybook story files.

---

## Setup: Detect the Project's Storybook Version

Before writing stories, check:
1. `package.json` for `@storybook/react`, `@storybook/vue3`, `@storybook/svelte`, or `@storybook/angular` and their versions.
2. `.storybook/main.ts` (or `.js`) for the renderer and any addons.
3. An existing story file in the project to match conventions already in use.

---

## File Naming & Placement

- Co-locate the story file with the component: `ComponentName.stories.tsx` (or `.ts`, `.svelte`, etc.)
- For global/design-system components: `src/components/ui/ComponentName/ComponentName.stories.tsx`
- For feature components: `src/features/<feature>/components/ComponentName/ComponentName.stories.tsx`

---

## CSF3 Structure (React)

```typescript
import type { Meta, StoryObj } from '@storybook/react'
import { ComponentName } from './ComponentName'

const meta = {
  title: 'Components/ComponentName',   // Category/ComponentName
  component: ComponentName,
  parameters: {
    layout: 'centered',                 // 'centered' | 'fullscreen' | 'padded'
  },
  argTypes: {
    // Override controls for specific props
    variant: { control: 'select' },
    size: { control: 'select' },
    onClick: { action: 'clicked' },
  },
  tags: ['autodocs'],                   // Enable auto-generated docs page
} satisfies Meta<typeof ComponentName>

export default meta
type Story = StoryObj<typeof meta>

// 1. Default / Primary — minimal required props, canonical render
export const Default: Story = {
  args: {
    children: 'Example content',
  },
}

// 2. One story per meaningful variant
export const Secondary: Story = {
  args: {
    children: 'Example content',
    variant: 'secondary',
  },
}

// 3. States
export const Disabled: Story = {
  args: {
    children: 'Unavailable',
    disabled: true,
  },
}

// 4. Edge cases where useful
export const LongLabel: Story = {
  args: {
    children: 'This is a very long label that might wrap or overflow',
  },
}
```

---

## Story Coverage Targets

Write one story per:
- **Default render** — minimal props, canonical appearance
- **Each named variant** (e.g., `primary`, `secondary`, `ghost`, `destructive`)
- **Each size** if size affects layout significantly
- **Key states**: `disabled`, `loading`, `error`, `empty`
- **Edge cases**: long content, no content, max items

Do **not** write a story for every possible prop combination — focus on what a designer or developer needs to see.

---

## CSF3 Structure (Vue 3)

```typescript
import type { Meta, StoryObj } from '@storybook/vue3'
import ComponentName from './ComponentName.vue'

const meta = {
  title: 'Components/ComponentName',
  component: ComponentName,
  parameters: { layout: 'centered' },
  tags: ['autodocs'],
} satisfies Meta<typeof ComponentName>

export default meta
type Story = StoryObj<typeof meta>

export const Default: Story = {
  args: {
    label: 'Click me',
    variant: 'primary',
  },
}
```

For slot content in Vue stories, use the `render` function:

```typescript
export const WithSlot: Story = {
  render: (args) => ({
    components: { ComponentName },
    setup() { return { args } },
    template: '<ComponentName v-bind="args"><strong>Slotted content</strong></ComponentName>',
  }),
}
```

---

## CSF3 Structure (Svelte)

```typescript
import type { Meta, StoryObj } from '@storybook/svelte'
import ComponentName from './ComponentName.svelte'

const meta = {
  title: 'Components/ComponentName',
  component: ComponentName,
  tags: ['autodocs'],
} satisfies Meta<typeof ComponentName>

export default meta
type Story = StoryObj<typeof meta>

export const Default: Story = {
  args: {
    label: 'Click me',
  },
}
```

---

## CSF3 Structure (Angular)

```typescript
import type { Meta, StoryObj } from '@storybook/angular'
import { ComponentNameComponent } from './component-name.component'

const meta: Meta<ComponentNameComponent> = {
  title: 'Components/ComponentName',
  component: ComponentNameComponent,
  tags: ['autodocs'],
}

export default meta
type Story = StoryObj<ComponentNameComponent>

export const Default: Story = {
  args: {
    label: 'Click me',
    variant: 'primary',
  },
}
```

---

## argTypes: When to Customize Controls

Only override `argTypes` when the default control is wrong:

```typescript
argTypes: {
  // String union → use select, not text
  variant: { control: 'select', options: ['primary', 'secondary', 'ghost'] },

  // Boolean → toggle is fine by default, no override needed

  // Event handler → register as an action so clicks show in the Actions panel
  onClick: { action: 'clicked' },

  // Hide internal/irrelevant props from controls
  internalRef: { table: { disable: true } },
}
```

---

## Decorators

Use decorators for stories that need providers (theme, router, store):

```typescript
import { withThemeProvider } from '../.storybook/decorators'

const meta = {
  title: 'Components/ComponentName',
  component: ComponentName,
  decorators: [withThemeProvider],  // project-specific decorator
} satisfies Meta<typeof ComponentName>
```

Or inline:

```typescript
export const WithDarkTheme: Story = {
  decorators: [
    (Story) => (
      <div className="dark" style={{ padding: '2rem', background: '#111' }}>
        <Story />
      </div>
    ),
  ],
  args: { children: 'Dark theme preview' },
}
```

---

## Anti-patterns

- **Don't write logic in stories** — stories should be pure data (`args`) + optionally a `render` function. No business logic.
- **Don't import from test files** — stories and tests are separate concerns.
- **Don't use `story.parameters.controls.disable: true` globally** — it removes the Controls panel entirely. Disable per-arg with `table: { disable: true }` instead.
- **Don't hardcode i18n strings** — use realistic but generic content; don't tie stories to a specific locale.
- **Don't skip `tags: ['autodocs']`** on reusable components — it generates the documentation page automatically.
