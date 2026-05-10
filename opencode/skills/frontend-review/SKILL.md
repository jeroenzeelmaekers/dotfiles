---
name: frontend-review
description: Structured checklist for reviewing a frontend PR or feature across TypeScript types, accessibility, performance, test coverage, and CSS/styling quality.
license: MIT
compatibility: opencode
metadata:
  audience: frontend-engineers
  workflow: code-review
---

## Frontend PR Review Checklist

Use this checklist when reviewing a frontend pull request or completed feature. Work through each section systematically.

---

### 1. TypeScript & Type Safety

- [ ] No `any` types introduced without a comment justifying why
- [ ] Props/options interfaces are exported and documented with TSDoc
- [ ] Return types are explicit on all exported functions and hooks
- [ ] Generic types are used where appropriate instead of type casting
- [ ] No `@ts-ignore` or `@ts-expect-error` without explanation
- [ ] Zod/Valibot schemas (or equivalent) used for runtime validation of external data (API responses, form input)

---

### 2. Component Design

- [ ] Component has a single, clear responsibility
- [ ] Props interface is minimal — no unused or redundant props
- [ ] Component is composable (uses `children`/slots rather than deeply nested config props where appropriate)
- [ ] No business logic leaking into presentational components
- [ ] Stateful logic extracted to a hook/composable/store where reusable

---

### 3. Accessibility

- [ ] All interactive elements are reachable and operable via keyboard
- [ ] Buttons use `<button>`, links use `<a href>` — not `<div onClick>`
- [ ] All form inputs have associated `<label>` or `aria-label`
- [ ] Images have meaningful `alt` text (decorative images use `alt=""`)
- [ ] Dynamic content changes are announced via ARIA live regions where needed
- [ ] Focus is managed correctly after modal open/close and route changes
- [ ] No `outline: none` without a visible custom focus style replacement
- [ ] Color is not the only means of conveying information

Run `@accessibility-auditor` for a full audit if this is a complex interactive component.

---

### 4. Performance

- [ ] No unnecessary re-renders introduced (check for unstable prop references)
- [ ] Heavy dependencies imported with named/tree-shakeable imports
- [ ] Long lists (50+ items) use virtualization
- [ ] Images have explicit `width`/`height` to prevent CLS
- [ ] Below-the-fold images use `loading="lazy"`
- [ ] New `useEffect`/`watch`/reactive dependencies are minimal and correct
- [ ] No expensive computations in render/template without memoization

Run `@performance-reviewer` for a thorough analysis if this is a complex new page or data-heavy component.

---

### 5. Test Coverage

- [ ] Vitest component tests written for new/changed components
- [ ] Tests cover: default render, key interactions, async states, edge cases
- [ ] Playwright tests written for any new multi-page user flows
- [ ] Tests query by accessible role/label/text — not class names or test IDs
- [ ] Mocks are scoped and cleaned up (`vi.clearAllMocks()` in `afterEach` or `beforeEach`)
- [ ] No tests that only check implementation details (internal state, private methods)

Run `@test-writer` to generate missing tests.

---

### 6. Styling

- [ ] Values use design tokens / the project's spacing/color scale — no magic numbers
- [ ] Responsive breakpoints are handled (mobile-first)
- [ ] No `!important` without justification
- [ ] Animations respect `prefers-reduced-motion`
- [ ] No inline styles for values that should be in a stylesheet/class

Run `@css-reviewer` for a thorough styling review.

---

### 7. General Code Quality

- [ ] No `console.log` or debug statements left in
- [ ] Error states are handled and surfaced to the user (not silently swallowed)
- [ ] Loading states are accounted for in the UI
- [ ] Empty states are handled (empty list, no results, etc.)
- [ ] No commented-out code committed
- [ ] Environment-specific values use `env` variables — no hardcoded URLs or keys

---

### Review Verdict

After completing the checklist:

- **Approve**: All critical items pass, minor issues noted as follow-up
- **Request changes**: One or more critical items fail (type errors, missing a11y, broken tests)
- **Discuss**: Design or architecture questions that need team input before proceeding
