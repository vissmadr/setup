# TypeScript Code Style

TypeScript code style rules.

Always read `docs/ai/codestyle-main.md` first, then read `docs/ai/codestyle-project.md` after this file.

## Goals

- Prefer simple, direct, readable TypeScript.
- Keep data shapes, module ownership, and runtime boundaries explicit.
- Use the project typechecker as the main safety net.

## Language Baseline

- Use strict TypeScript.
- Use ESM imports and exports.
- Avoid `any`; narrow with real types instead.
- Add explicit return types on exported functions.
- Prefer `type` aliases for data shapes unless `interface` has a concrete reason.
- Use explicit `null` for absent persisted or API data when absence is part of the data model.
- Use optional fields only when the property is genuinely optional at the boundary.

## Naming

- Use `camelCase` for variables, functions, and local constants.
- Use `PascalCase` for types, classes, namespaces, and JSX components.
- Use `SCREAMING_SNAKE_CASE` for true global constants and enum values when the project uses that enum style.
- Use full descriptive names. Avoid abbreviations except accepted technical initialisms.
- Name booleans as questions: `isRunning`, `hasPermission`, `shouldSubmit`.
- Name functions as verbs: `getEmployee`, `calculateBalance`, `createRequest`.

## Modules And Namespaces

- Keep each module focused on one responsibility.
- Prefer explicit named exports over default exports unless the project framework strongly prefers defaults.
- Keep package public APIs flowing through the package entry point.
- Do not deep-import another package's internal `src/*` files unless that path is explicitly public.
- Use namespace-style exports when the project intentionally groups APIs that way.

## Control Flow

- Prefer guard clauses and flat control flow.
- Extract complex conditions into named constants.
- Throw `Error` objects for programmer errors and impossible states.
- Do not hide invalid states behind silent fallback values.

## Async And Runtime Failures

- Keep network, database, filesystem, and browser API boundaries explicit.
- Handle expected runtime failures in the style of the project: result object, `null`, thrown HTTP error, or propagated exception.
- Do not scatter raw fetch or database calls when the project has a client/helper boundary.

## Frontend

- Preserve the framework conventions already used by the project.
- Keep component-specific styles close to the component when the project uses scoped styles.
- Preserve accessible labels, semantic structure, keyboard behavior, focus states, and mobile behavior.
- Do not add broad UI frameworks, state libraries, or form libraries unless explicitly requested.

## Formatting

Follow the project's formatter and linter settings. If none exist, use practical defaults:

- two-space indentation
- double quotes
- semicolons
- trailing commas for multiline lists
- readable lines around 120 characters

## Comments

Keep comments rare. Add comments only for non-obvious browser constraints, runtime invariants, external API quirks, algorithm choices, or performance-sensitive reasoning.

Use JSDoc for exported utility APIs only when behavior is not obvious from names and types.

## Verification

- Run the smallest relevant typecheck after TypeScript changes.
- Run targeted tests when behavior changes and tests exist.
- Run the relevant build when bundling, routes, assets, public exports, or package boundaries change.
