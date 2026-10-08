# Zig Code Style

Zig code style rules.

Always read `docs/ai/codestyle-main.md` first, then read `docs/ai/codestyle-project.md` after this file.

## Goals

- Prefer simple, direct, readable Zig with explicit ownership and low cognitive load.
- Keep memory, resource lifetimes, and runtime data ownership obvious.
- Preserve project-specific module patterns consistently.

## Naming

- Use `camelCase` for variables, functions, fields, and local constants.
- Use `PascalCase` for structs, modules, public types, enums, and regular enum values.
- Use an all-caps sentinel such as `NONE` for unset technical enum values when the project uses sentinel enums.
- Use full descriptive names. Avoid abbreviations except accepted technical initialisms.
- Keep source filenames in the project's existing style, usually `snake_case.zig`.

## Module Structure

Follow the project's established module pattern. If the project uses an import namespace and public `Out` export, keep this shape:

```zig
const In = struct {
    const std = @import("std");
};

pub const Out = ModuleName;

const ModuleName = struct {
    // Public surface first, private implementation after.
};
```

When a file uses this pattern, keep the outer scope limited to `In`, `Out`, and the main implementation struct unless the project has a documented exception.

## Control Flow

- Prefer guard clauses and early returns.
- Extract complex conditions into named constants.
- Use clear `@panic("DEV: ...")` messages for impossible states in development projects.
- Avoid clever labeled blocks for inline computation when a helper function is clearer.

## Memory And Resources

- Make allocator ownership explicit.
- Pair resource loads with matching unloads in the same ownership boundary.
- Keep per-frame or hot-path allocations out of update/render loops unless there is a measured reason.
- Prefer fixed-size buffers or object pools when the project has real-time, game, renderer, or no-heap constraints.
- Keep C API type conversions explicit at the boundary.

## Config And Data

- Keep config schema changes synchronized with loaders, validators, defaults, serializers, and resource files.
- Remove stale config fields when replacing a system in development-only projects.
- Validate external data close to the load boundary.

## Formatting

- Use `zig fmt` style.
- Use four-space indentation.
- Use trailing commas for multiline literals.
- Keep long call formatting consistent with nearby code.

## Comments

Keep comments rare. Use them for non-obvious ownership, lifetime, coordinate-space, renderer, shader, C API, or performance constraints.

## Verification

- Run the smallest relevant Zig check after code changes, usually `zig build check`.
- Run `zig build test` after behavior, parser, validation, or test changes.
- Run `zig build` after build graph, resource install, shader, config, or packaging changes.
