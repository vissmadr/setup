# Code Style

Personal TypeScript code style for new projects.

## Goals

1. **Simplicity** — straightforward code that does what it says
2. **Readability** — code that reads like documentation
3. **Reduced cognitive load** — consistent patterns everywhere

## Development-Only Rule

Treat every project as development-only.
Do not preserve backward compatibility, legacy code paths, migration scaffolding, deprecated config layouts, or dead systems unless the user explicitly asks for that.
When replacing a system, make the new system canonical and delete the old one in the same change. Prefer clean refactors and removal of unused code over compatibility layers or temporary bridges.
If the current design smells wrong, improve it properly instead of patching around it.

---

## One File, One Namespace

Every file exposes exactly one top-level namespace. The namespace name matches the conceptual name of the file (PascalCase). Nothing else is exported from the outer scope.

There are two acceptable ways to declare the namespace. Pick one style per project and stay consistent.

### Style A — `export namespace` block (preferred for modules with state)

Good for modules that have private state, helpers, or sub-namespaces. The file IS the namespace:

```ts
// slack-app.ts
export namespace SlackApp {
  const name = "SlackApp";

  export function create(appToken: string, botToken: string): SlackBolt.App {
    // ...
  }

  export async function start(app: SlackBolt.App, port: number): Promise<void> {
    // ...
  }
}
```

### Style B — `export * as` wrapper (preferred for pure utilities)

Good for pure utility modules with no private state. `main.ts` has free exports, `index.ts` wraps them:

```ts
// main.ts
export function lerp(a: number, b: number, step: number) {
  return a + step * (b - a);
}

export function clamp(value: number, min: number, max: number) {
  return Math.max(min, Math.min(max, value));
}

// index.ts
export * as Mathematics from "./main";
```

### Barrel Files

A directory-level barrel re-exports its modules under a shared parent namespace:

```ts
// slack/index.ts
export { SlackApp as App } from "./slack-app";
export { SlackEvents as Events } from "./slack-events";
export { SlackLogger as Logger } from "./slack-logger";
export { SlackUI as UI } from "./slack-ui";
```

Used as: `Slack.App.create(...)`, `Slack.Events.register(...)`, etc.

### Nested Namespaces for Organization

Use nested namespaces to group related types, helpers, or variants rather than flat prefixes:

```ts
export namespace Deploy {
  export enum State {
    GATHERING = "gathering",
    WAITING = "waiting",
    APPROVED = "approved",
  }

  export type Data = {
    id: number;
    name: string;
    state: State;
    // ...
  };

  export namespace Partial {
    export type FormationData = Omit<Deploy.Data, "id">;
    export type ModifyData = Pick<Deploy.Data, "name" | "message">;
  }
}

export namespace Database {
  export async function query(...) { /* ... */ }

  export namespace Helpers {
    export function getResultHeader(data: unknown) { /* ... */ }
  }
}
```

Use `Deploy.Partial.FormationData` and `Database.Helpers.getResultHeader(...)` instead of `DeployFormationData` and `getDatabaseResultHeader(...)`.

---

## Naming Conventions

| Element                  | Style                | Example                               |
| ------------------------ | -------------------- | ------------------------------------- |
| Variables                | camelCase            | `enemyPosition`, `hitCount`           |
| Functions                | camelCase            | `getPosition`, `calculateDamage`      |
| Constants (local, value) | camelCase            | `maxEnemies`, `reconnectInterval`     |
| Constants (true consts)  | SCREAMING_SNAKE_CASE | `TAU`, `SIN_45`, `MAX_RETRY_COUNT`    |
| Namespaces               | PascalCase           | `SlackApp`, `LogicApproval`, `Deploy` |
| Types / Interfaces       | PascalCase           | `Deploy.Data`, `User`, `Config`       |
| Enums                    | PascalCase           | `State`, `Priority`                   |
| Enum values              | SCREAMING_SNAKE_CASE | `GATHERING`, `HIGH`, `NONE`           |
| Files (modules)          | kebab-case           | `logic-approval.ts`, `slack-app.ts`   |
| Files (JSX components)   | PascalCase           | `Hero.tsx`, `Layout.tsx`              |

### Never Abbreviate

**NEVER ABBREVIATE!**
**NEVER ABBREVIATE!**
**NEVER ABBREVIATE!**

Always use full, descriptive names. Long variable names like `isNextUpdateAvailable` are totally fine.

```ts
// Good
const enemyPosition = enemies.getPosition(enemyIndex);
const attackDamage = calculateDamage(baseAttributes);
const userSlackID = event.body.user.id;

// Avoid
const ePos = enemies.getPos(eIdx);
const atkDmg = calcDmg(baseAttrs);
const uSID = event.body.user.id;
```

Clarity above conciseness, above all else. Reduce cognitive load.

**Accepted initialisms** stay as they are — `ID`, `URL`, `API`, `JSON`, `HTML`, `DOM`, `UI`, `GL`, `CSS`, `HTTP`. Keep the case consistent with the surrounding identifier: `userID`, `jiraIssueKey`, `fetchURL`, `parseJSON`.

### Booleans Ask Questions

```ts
// State fields
isRunning: boolean;
isActionLocked: boolean;
hasData: boolean;

// Functions
function isReady(): boolean {
  /* ... */
}
function hasPermission(user: User, action: Action): boolean {
  /* ... */
}
function shouldRetry(attempt: number): boolean {
  /* ... */
}

// Locals
const isPlayerInRange = distanceSquared < rangeSquared;
const shouldChase = !isPlayerInRange;
```

### Functions Are Verbs

```ts
function getPosition(index: number): Vector2 {
  /* ... */
}
function calculateDamage(base: number, mods: Mods): number {
  /* ... */
}
function applyKnockback(target: State, velocity: Vector2): void {
  /* ... */
}
```

---

## Code Style

### Early Returns (Guard Clauses)

Handle edge cases and error paths first, keep the main logic flat:

```ts
// Good
async function processDeploy(deployID: number) {
  const deploy = await Repositories.Deploy.read(deployID);
  if (!deploy) {
    Output.errorBy(name, `Deploy ${deployID} not found`);
    return null;
  }

  const user = Users.getById(deploy.requestorID);
  if (!user) return null;

  if (!Rules.canProceed(user, deploy)) return null;

  // Main logic, un-nested
  return processDeploy_impl(user, deploy);
}

// Avoid
async function processDeploy(deployID: number) {
  const deploy = await Repositories.Deploy.read(deployID);
  if (deploy) {
    const user = Users.getById(deploy.requestorID);
    if (user) {
      if (Rules.canProceed(user, deploy)) {
        return processDeploy_impl(user, deploy);
      }
    }
  }
  return null;
}
```

### Extract Complex Conditionals

Move complex conditions into named constants:

```ts
// Good
const isBeforeToday = deployTime.getTime() <= Date.now();
const isCritical = priority === Deploy.Priority.CRITICAL;
const isOnCriticalOnlyDay = criticalOnlyDays.includes(deployTime.getUTCDay());

if (isBeforeToday) return false;
if (!isCritical && isOnCriticalOnlyDay) return false;

// Avoid
if (deployTime.getTime() <= Date.now()) return false;
if (
  priority !== Deploy.Priority.CRITICAL &&
  [5, 6, 0].includes(deployTime.getUTCDay())
)
  return false;
```

### Throw on Invalid States

For programmer errors or invariants that should never be violated, throw — don't return a silent fallback. Prefix messages with `DEV:` so they're obvious in logs:

```ts
// Good
switch (attackLevel) {
  case 1:
    return attributes.attack1Damage;
  case 2:
    return attributes.attack2Damage;
  case 3:
    return attributes.attack3Damage;
  default:
    throw new Error(`DEV: invalid attack level ${attackLevel}`);
}

// Avoid
switch (attackLevel) {
  case 1:
    return attributes.attack1Damage;
  case 2:
    return attributes.attack2Damage;
  case 3:
    return attributes.attack3Damage;
  default:
    return attributes.attack1Damage; // silent bug
}
```

Throwing is for **programmer errors**. For **runtime failures** (DB down, bad user input, network error), return `null` and log — see _Error Handling_ below.

### Always Be Explicit

Set fields explicitly, even when the value equals the default. Don't rely on field omission / `undefined` to mean "default":

```ts
// Good
const config: IDatabaseConfig = {
  reconnectInterval: 2_000,
  databaseName: "deploybot",
  settings: {
    host: "127.0.0.1",
    user: "root",
    password: "",
    enableKeepAlive: true,
  },
};

// Avoid
const config = {
  databaseName: "deploybot",
  settings: { host: "127.0.0.1", user: "root" }, // rest implicit
};
```

### Avoid Fancy Syntax

Prefer an explicit `for` loop over a chained `.map().filter().reduce()` when the chain obscures intent or requires reading multiple lambdas to follow. Clever one-liners that need a second read to understand are not worth the character savings.

```ts
// Good — clear
let hitCount = 0;
for (let i = 0; i < candidates.length; i++) {
  if (isHit(candidates[i])) {
    hits[hitCount] = candidates[i];
    hitCount++;
  }
}

// Fine for simple transforms
const doubled = numbers.map((n) => n * 2);

// Avoid — obscures the state machine
const [hits, hitCount] = candidates.reduce(
  ([acc, count], c) => (isHit(c) ? [[...acc, c], count + 1] : [acc, count]),
  [[] as Candidate[], 0] as const,
);
```

---

## Types

### Prefer `type` Over `interface`

Use `type` aliases for data shapes. Reserve `interface` for cases that genuinely benefit from declaration merging or `implements`. Having one way to declare a shape reduces decision fatigue.

```ts
// Preferred
export type User = {
  id: number;
  name: string;
  email: string;
};

// Use interface only when you have a reason
export interface Renderable {
  render(ctx: CanvasRenderingContext2D): void;
}
```

### String Enums for Categorical Values

Use string enums for states, types, kinds, categories — values that appear in logs, in the database, or are sent over the wire. String enums remain readable when serialized.

```ts
export enum State {
  GATHERING = "gathering",
  WAITING = "waiting",
  APPROVED = "approved",
  DEPLOYING = "deploying",
  COMPLETED = "completed",
}
```

Avoid numeric enums — the serialized numbers are opaque and enum reordering silently corrupts stored values.

### `null` for Absent Values, Not Optional Fields

Prefer `null` as an explicit sentinel in data types over optional fields (`foo?: T`). This makes it obvious at every callsite that the value may be absent.

```ts
// Good — explicit
export type Deploy = {
  id: number;
  jiraKey: string | null;
  slackTimestamp: string | null;
};

// Avoid — hides absence
export type Deploy = {
  id: number;
  jiraKey?: string;
  slackTimestamp?: string;
};
```

Use optional (`?`) for function parameters that the caller legitimately might omit, not for persistent data fields.

Use `NONE` string-enum variants only for cross-system values (configs, databases, APIs) where sending the literal string `"NONE"` has semantic meaning on the other end.

### Nested Namespaces Over Prefixed Names

```ts
// Good
export namespace Deploy {
  export type Data = {
    /* ... */
  };
  export namespace Partial {
    export type FormationData = Omit<Deploy.Data, "id">;
    export type ModifyData = Pick<Deploy.Data, "name">;
  }
}

// Avoid
export type DeployData = {
  /* ... */
};
export type DeployFormationPartialData = Omit<DeployData, "id">;
export type DeployModifyPartialData = Pick<DeployData, "name">;
```

### Explicit Return Types on Exported Functions

Exported functions must declare their return type. It's a contract and it catches type-inference regressions.

```ts
// Good
export function getUser(id: number): User | null {
  /* ... */
}

// Avoid on exports
export function getUser(id: number) {
  /* inferred */
}
```

For local helpers, inferred return types are fine.

---

## Error Handling

### `tryCatch` Wrapper for Promises

Promise rejection with `try`/`catch` scatters control flow. Wrap awaited promises in a helper that returns a `Result`:

```ts
type Success<T> = { data: T; error: null };
type Failure<E> = { data: null; error: E };
type Result<T, E = Error> = Success<T> | Failure<E>;

export async function tryCatch<T, E = Error>(
  promise: Promise<T>,
): Promise<Result<T, E>> {
  try {
    const data = await promise;
    return { data, error: null };
  } catch (error) {
    return { data: null, error: error as E };
  }
}
```

Callsite:

```ts
const result = await tryCatch(Database.query(sql, values));
if (result.error) {
  Output.errorBy(name, "Failed query!");
  console.error(result.error);
  return null;
}

const header = Database.Helpers.getResultHeader(result.data);
```

### Return `null` for Runtime Failures

Business logic functions return `null` on failure (not exceptions), and log before returning:

```ts
export async function readDeploy(
  deployID: number,
): Promise<Deploy.Data | null> {
  const result = await tryCatch(Database.query(sql, [deployID]));
  if (result.error) {
    Output.errorBy(name, `Failed reading deploy ${deployID}`);
    return null;
  }
  return parseDeployRow(result.data);
}
```

Callers check for `null` and handle it explicitly. Throws are reserved for programmer errors.

### Logging by Name

Each namespace declares a `name` constant and uses it as a prefix in log output. This makes traces navigable:

```ts
export namespace LogicApproval {
  const name = "LogicApproval";

  export async function onCreation(event: ViewArgs) {
    Output.outBy(name, "Creating approval");
    // ...
    Output.successBy(name, `Created approval ${approvalID}`);
  }
}
```

Keep the four log levels consistent across projects: `out` (info), `success`, `warning`, `error`.

---

## Imports

Order imports in two blocks, separated by a blank line:

1. External dependencies (npm packages)
2. Internal imports (project files)

```ts
import "dotenv/config";
import * as mysql2 from "mysql2/promise";
import chalk from "chalk";

import { Config } from "./config";
import { Output } from "./output";
import { Database } from "./database";
```

Within each block, any order is fine — don't waste time sorting alphabetically. Let Prettier handle the rest.

---

## Formatting

Use Prettier with the following settings:

- **Print width**: 120
- **Indentation**: 2 spaces
- **Semicolons**: always
- **Quotes**: double (`"string"`)
- **Trailing commas**: all (multiline objects, arrays, function params)

---

## Comments

Default to writing **no comments**. Good names and clear structure should carry the meaning.

Write a comment only when the _why_ is non-obvious — a hidden constraint, a subtle invariant, or a workaround for a specific bug.

```ts
// Good — explains non-obvious intent
// Tracks deploys that have already had DevOps tagged as the last approver,
// so we don't re-post the message as further approvals come in.
const devopsTaggedDeploys = new Set<number>();

// Avoid — restates the code
// Increment the counter
hitCount++;
```

### Doc Comments (`/** ... */`)

Reserve JSDoc for exported utility APIs that benefit from parameter documentation (math libraries, shared helpers). Don't litter business logic with doc comments.

```ts
/**
 * Linear interpolation between two values.
 *
 * @param a Start value
 * @param b End value
 * @param step Interpolation factor (0 = a, 1 = b)
 */
export function lerp(a: number, b: number, step: number): number {
  return a + step * (b - a);
}
```

---

## Directory Structure

- Single-file modules: `module.ts` (kebab-case)
- Grouped modules: `module/` directory with `index.ts` as the barrel
- Pure utilities: `utility/src/main.ts` + `utility/src/index.ts` pattern
- JSX components: `ComponentName/ComponentName.tsx` + `ComponentName.module.css`

Entities (data types) live in their own directory and export data shapes, enums, and variant namespaces — no behavior:

```
src/
├── main.ts                  # entry point
├── config/                  # configuration
├── entities/                # data types (Deploy, User, ...)
├── repositories/            # database access (one file per entity)
├── logic/                   # business logic (logic-*.ts)
├── utilities/               # pure helpers
└── <integration>/           # external integrations (slack/, jira/)
```

Each layer depends downward only: logic → repositories → database → config. Entities depend on nothing.
