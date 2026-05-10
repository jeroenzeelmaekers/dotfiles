---
name: css-conventions
description: Project-agnostic CSS patterns, conventions, and anti-patterns for Tailwind CSS, CSS Modules, styled-components, and plain CSS. Reference this when writing or reviewing styles.
license: MIT
compatibility: opencode
metadata:
  audience: frontend-engineers
  workflow: styling
---

## CSS Conventions & Anti-patterns

Reference guide for writing maintainable, consistent CSS across different styling approaches.

---

## Universal Rules (All Approaches)

### Do
- Use design tokens / a consistent scale for spacing, color, typography, and border-radius.
- Keep specificity low and predictable — avoid selector chains longer than 2–3 levels.
- Handle `prefers-reduced-motion` for any CSS transitions or animations:

```css
@media (prefers-reduced-motion: reduce) {
  .animated-element {
    transition: none;
    animation: none;
  }
}
```

- Animate `transform` and `opacity` — they run on the compositor thread and don't trigger layout:

```css
/* Good */
.card:hover { transform: translateY(-2px); }

/* Bad — triggers layout */
.card:hover { top: -2px; }
```

- Reserve explicit `width`/`height` on images to prevent CLS:

```html
<img src="..." width="800" height="600" alt="..." />
```

### Don't
- Use `!important` except as a last resort (utility overrides). Always add a comment when you do.
- Use magic numbers — `margin: 13px` with no token or reason.
- Remove `outline` without providing a visible custom focus style.
- Use `z-index` values like `9999` — use a documented z-index scale.

---

## Tailwind CSS

### Class Ordering Convention

Follow this order (mirrors Prettier Tailwind plugin):
1. Layout (`flex`, `grid`, `block`, `hidden`)
2. Position (`relative`, `absolute`, `top-*`, `left-*`, `z-*`)
3. Box model (`w-*`, `h-*`, `p-*`, `m-*`)
4. Typography (`text-*`, `font-*`, `leading-*`, `tracking-*`)
5. Visual (`bg-*`, `border-*`, `rounded-*`, `shadow-*`)
6. Interactivity (`cursor-*`, `pointer-events-*`)
7. Transitions (`transition-*`, `duration-*`, `ease-*`)
8. Responsive variants (`sm:`, `md:`, `lg:`, `xl:`)
9. State variants (`hover:`, `focus:`, `active:`, `disabled:`)
10. Dark mode (`dark:`)

### Responsive — Mobile First

```html
<!-- Good: base (mobile) → sm → md → lg -->
<div class="flex-col sm:flex-row md:gap-6 lg:gap-8">

<!-- Bad: desktop-first, overrides on small -->
<div class="flex-row gap-8 sm:flex-col sm:gap-2">
```

### Extracting Repeated Patterns

When the same set of utility classes appears on 3+ elements, extract to a component or use `@apply`:

```css
/* Only use @apply for truly reused patterns, not one-offs */
@layer components {
  .btn-primary {
    @apply inline-flex items-center justify-center rounded-md bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2;
  }
}
```

### Arbitrary Values

Prefer scale values. Use arbitrary values `[value]` only when a one-off is unavoidable — and add a comment:

```html
<!-- Fine: one-off to match a specific design spec -->
<div class="h-[72px]">  <!-- header height matches design system -->
```

### Anti-patterns

```html
<!-- Bad: using !important modifier without justification -->
<div class="!mt-0">

<!-- Bad: mixing spacing scales arbitrarily -->
<div class="p-3 m-5 gap-7">  <!-- use consistent scale: 2, 4, 6, 8... -->

<!-- Bad: class list so long it's unreadable — extract to a component -->
<div class="flex items-center justify-between rounded-lg border border-gray-200 bg-white p-4 shadow-sm hover:shadow-md transition-shadow duration-200 cursor-pointer focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-gray-800 dark:border-gray-700">
```

---

## CSS Modules

### Naming

- Use **camelCase** for class names: `.buttonPrimary`, not `.button-primary`
- Name classes by their **semantic role**, not their visual appearance:

```css
/* Good */
.actionButton { }
.errorMessage { }

/* Bad — describes appearance, not role */
.redText { }
.bigBlueBox { }
```

### Selector Depth

Keep nesting shallow — max 2 levels:

```css
/* Good */
.card { }
.card .title { }

/* Bad — too specific, hard to override */
.card .header .title span { }
```

### Composition

Use `composes` for sharing styles between classes:

```css
.base {
  padding: 0.5rem 1rem;
  border-radius: 0.375rem;
  font-weight: 500;
}

.primary {
  composes: base;
  background-color: var(--color-primary);
  color: white;
}
```

### Avoid `:global` Leaks

Only use `:global` when targeting third-party library classes, and scope it tightly:

```css
/* Good — scoped global override for a library */
.wrapper :global(.react-datepicker) {
  font-family: inherit;
}

/* Bad — leaks into the whole page */
:global(.button) {
  color: red;
}
```

---

## styled-components / Emotion

### Use Theme Tokens

Access theme values via the `theme` prop — never hardcode:

```typescript
// Good
const Button = styled.button`
  background-color: ${({ theme }) => theme.colors.primary};
  padding: ${({ theme }) => theme.spacing[2]} ${({ theme }) => theme.spacing[4]};
`

// Bad
const Button = styled.button`
  background-color: #3b82f6;
  padding: 8px 16px;
`
```

### Variants via Props

Use a variants object pattern over string interpolation conditions:

```typescript
const variantStyles = {
  primary: css`background: ${({ theme }) => theme.colors.primary}; color: white;`,
  secondary: css`background: transparent; border: 1px solid ${({ theme }) => theme.colors.primary};`,
}

const Button = styled.button<{ variant: 'primary' | 'secondary' }>`
  ${({ variant }) => variantStyles[variant]}
`
```

### Anti-patterns

```typescript
// Bad — logic-heavy string interpolation is hard to read
const Button = styled.button<{ isPrimary: boolean; isLarge: boolean }>`
  background: ${({ isPrimary }) => isPrimary ? 'blue' : 'gray'};
  padding: ${({ isLarge }) => isLarge ? '12px 24px' : '8px 16px'};
`

// Bad — inline styles mixed with styled-components
<Button style={{ marginTop: '8px' }}>Click</Button>
```

---

## Plain CSS / SCSS

### Custom Properties (Tokens)

Define all design tokens as CSS custom properties at `:root`:

```css
:root {
  --color-primary: #3b82f6;
  --color-primary-hover: #2563eb;
  --spacing-sm: 0.5rem;
  --spacing-md: 1rem;
  --radius-md: 0.375rem;
}
```

### Avoid `@extend` in SCSS

Prefer mixins or utility classes — `@extend` creates non-obvious dependency chains:

```scss
// Good
@mixin flex-center {
  display: flex;
  align-items: center;
  justify-content: center;
}

.card { @include flex-center; }
.overlay { @include flex-center; }

// Bad
.flex-center { display: flex; align-items: center; }
.card { @extend .flex-center; }
```

### Z-index Scale

Document and centralize z-index values:

```css
:root {
  --z-dropdown: 100;
  --z-sticky: 200;
  --z-overlay: 300;
  --z-modal: 400;
  --z-toast: 500;
}
```

---

## Focus Styles

Never remove focus outlines without a replacement. Use `:focus-visible` to show focus only for keyboard navigation:

```css
/* Good — hidden for mouse, visible for keyboard */
.button:focus { outline: none; }
.button:focus-visible {
  outline: 2px solid var(--color-primary);
  outline-offset: 2px;
}

/* Bad — removes focus for everyone */
.button:focus { outline: none; }
```
