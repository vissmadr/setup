# Code Style Main

General code style fundamentals.

This file defines the baseline coding style.
Language-specific rules live in separate files such as `docs/ai/codestyle-zig.md` or `docs/ai/codestyle-typescript.md`, depending on language.
Project-specific rules live in `docs/ai/codestyle-project.md`.

## Goals

1. Reduce cognitive load.
2. Keep code simple, direct, and readable.
3. Make ownership and data flow obvious.
4. Keep modules small enough to understand in one sitting.
5. Prefer fast, efficient code by default.
6. Performance matters.

## Development Policy

Treat everything as development-only unless the user explicitly says otherwise.

- Do not preserve backward compatibility unless the user explicitly asks.
- Do not add migration scaffolding unless real persisted data or external users require it.
- Do not keep deprecated config layouts, dead systems, compatibility loaders, or temporary bridges.
- When replacing a system, make the new system canonical and remove the old one in the same change.
- Prefer aggressive, clean refactors over patching around a bad design.
- Do not spend time on production ceremony unless it directly serves the current project.
- Do not add new test infrastructure, broad test suites, migration systems, or release ceremony unless the user explicitly asks or the project already depends on them.

Do not keep old deprecated unnecessary legacy slop.
If the current code/design feels wrong, improve it properly instead of patching around it.

The goal is to always have the best code possible.

## Simplicity

Simple code is code with few concepts, direct control flow, and clear names.

- Prefer simple and obvious code over clever code.
- Prefer explicit steps over dense one-liners.
- Prefer guard clauses over nested conditionals.
- Extract complex conditions into named booleans.
- Keep functions focused on one job.
- Keep files focused on one responsibility.
- Avoid abstractions until there are multiple real call sites or a clear boundary.

## Naming

Use full descriptive names. Do not abbreviate.

Long names are fine when they remove ambiguity:

```text
isNextUpdateAvailable
selectedEmployeeID
enemyAttackCooldownSeconds
```

Avoid names like:

```text
ctx
idx
cfg
tmp
mgr
svc
ePos
atkDmg
```

Accepted technical initialisms may stay abbreviated when they are the normal term, such as API, URL, HTTP, HTML, CSS, DOM, UI, ID, JSON, SQL, GL, GPU, CPU, FPS, TOML, and XML.

Name booleans as questions:

```text
isRunning
hasPermission
shouldRetry
canSubmit
```

Name functions as verbs:

```text
getPosition
calculateDamage
applyKnockback
createLeaveRequest
```

## Namespaces And Ownership

Use namespaces, modules, structs, or package boundaries to make ownership obvious.

Prefer:

```text
Time.Get.deltaTime()
Sectors.Enemies.query(...)
Calendar.Date.getMonthGrid(...)
```

over flat names with repeated prefixes:

```text
getTimeDeltaTime()
queryEnemySectors(...)
getCalendarDateMonthGrid(...)
```

Each unit should answer three questions quickly:

- What does it own?
- How do other units use it?
- What does it depend on?

If those answers are unclear, improve the boundary.

## Modularity

Keep code modular where it reduces cognitive load.

- Split large files when responsibilities are clearly separate.
- Keep code that changes together close together.
- Extract common utilities when the same logic appears in multiple places.
- Do not create generic utility layers for one caller.
- Do not hide simple behavior behind factories, registries, or framework-like abstractions unless the project already needs that shape.

## Performance

Think about performance while writing code, not only after problems appear.

- Avoid unnecessary work in hot paths.
- Avoid avoidable allocations in update, render, request, or loop-heavy paths.
- Prefer data layouts that match access patterns.
- Cache or precompute only when it simplifies code or removes repeated expensive work.
- Keep performance-sensitive invariants explicit.

Performance should not justify unreadable cleverness. The best code is usually both clear and efficient.

## Error Handling

- Fail loudly for programmer errors and impossible states.
- Do not silently fall back when a violated invariant means the code is wrong.
- For expected runtime failures, return a clear error shape, null-like sentinel, or propagated error according to the project language and style.
- Use error messages that identify the failing subsystem and the invalid value when practical.

## Comments

Default to no comments.

Use comments only for non-obvious why:

- invariants
- ownership or lifetime constraints
- coordinate-space assumptions
- performance-sensitive reasoning
- external API quirks
- browser, renderer, database, or platform constraints

Do not add comments that restate the next line of code.

## Verification

Run the smallest relevant verification after changes.

Examples:

- language typecheck or compile command
- targeted test command
- formatter or linter when the project uses one
- docs re-read for docs-only changes

If verification is skipped, say why.
