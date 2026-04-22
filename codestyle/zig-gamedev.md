# Code Style

Code style and conventions for this Zig game codebase.

## Goals

1. **Simplicity** - Straightforward code that does what it says
2. **Readability** - Code that reads like documentation
3. **Performance** - Optimized cache-friendly data layouts
4. **Reduced Cognitive Load** - Consistent patterns everywhere

## Development-Only Rule

This project is development-only, not production.

Do not preserve backward compatibility, legacy code paths, migration scaffolding, deprecated config layouts, or dead systems unless the user explicitly asks for that.

When replacing a system, make the new system canonical and delete the old one in the same change.

Prefer clean refactors, schema cutovers, and removal of unused code over compatibility layers or temporary bridges.

Do not add save/config version bumps, migration paths, compatibility loaders, or fallback handling for stale schemas unless the user explicitly asks for that.

If the current design smells wrong, improve it properly instead of patching around it.

---

## The `Out` Export Pattern

Every file exports its public API through `pub const Out`. This is the only `pub` declaration in the outer scope.

### File Structure Rule

Each file contains exactly:

1. `const In = struct { ... }` for imports (never inline imports inside structs/functions)
2. `pub const Out = ...`
3. One main struct (matching the conceptual name of the file)
4. Nothing else in the outer scope

When a file uses the `In` wrapper, the outer scope should contain only `In`, `Out`, and the one main struct, in that order. Helper constants, aliases, capacities, and sentinels belong inside the main struct, not at file scope.

### Direct Alias

When the struct IS the entire public API -- all its `pub` members are meant to be exposed -- alias it directly:

```zig
pub const Out = Countdown;

const Countdown = struct {
    remaining: f32 = 0.0,

    pub fn isReady(self: Countdown) bool { ... }
    pub fn set(self: *Countdown, duration: f32) void { ... }
    pub fn update(self: *Countdown, deltaTime: f32) void { ... }
};
```

This works for types used as values (Vector2, Countdown, State, Attributes) and for utility namespaces where everything is public (Math, Easing, Collision).

### Curated API

When selectively exposing parts of a larger implementation, use an explicit `Out` struct. Members of the internal struct should NOT be `pub` -- they are exposed through `Out`:

```zig
/// Temporary timed effects that modify attributes during runtime.
pub const Out = struct {
    pub const Effect = Effects.Effect;
    pub const Types = Effects.Types;
    pub const Accumulator = Effects.Accumulator;

    pub const accumulate = Effects.accumulate;
    pub const add = Effects.add;
    pub const remove = Effects.remove;
};

const Effects = struct {
    const Types = enum { NONE, Movespeed_flat, Movespeed_scale };

    const Effect = struct {
        type: Types = .NONE,
        clock: f32 = 0.0,
        magnitude: f32 = 0.0,
    };

    fn accumulate(effects: []const Effect) Accumulator { ... }
    fn add(effectsCount: *u8, effects: []Effect, newEffect: Effect) void { ... }
};
```

Use this pattern when there are private helpers, internal state, or types that should not be part of the public API.

### Module Aggregators

Files named `all.zig` aggregate and re-export sub-modules:

```zig
/// Combat system module.
pub const Out = struct {
    pub const HitDetection = @import("./hit_detection.zig").Out;
    pub const HitApplication = @import("./hit_application.zig").Out;
    pub const Sweep = @import("./sweep.zig").Out;
};
```

### Import Pattern

Imports always access `.Out` directly:

```zig
const Config = @import("./config.zig").Out;
const Vector2 = @import("./vector2.zig").Out;
const Player = @import("./player/all.zig").Out;
const Combat = @import("./combat/all.zig").Out;
```

### The `In` Import Struct

Wrap imported files in `In`:

```zig
const In = struct {
    const Table = @import("./table.zig").Out;
    const SkillsSet = @import("./skills_set.zig").Out;
};

pub const Out = struct {
    pub const Table = In.Table;
    pub const SkillsSet = In.SkillsSet;
    pub const process = MainStruct.process;
};

const MainStruct = struct {
    fn process(table: In.Table) In.SkillsSet { ... }
};
```

---

## Struct Namespaces

Heavy use of structs as namespaces for organization.

### `Data` Struct for Internal State

```zig
const Player = struct {
    const Data = struct {
        var attributes: Attributes = undefined;
        var state: State = undefined;
        var effects: [maxEffects]Effect = undefined;
        var effectsCount: u8 = 0;
    };

    fn update() void {
        Data.state.position = Data.state.position.add(velocity);
    }
};
```

### `Get` Struct for Getters

```zig
pub const Out = struct {
    pub const update = Time.update;

    pub const Get = struct {
        pub const deltaTime = Time.getDeltaTime;
        pub const now = Time.getTime;
    };
};
```

Usage: `Time.Get.deltaTime()`, `Time.Get.now()`

### Category Sub-Structs

```zig
pub const Out = struct {
    pub const Enemies = struct {
        pub const clear = All.Enemies.clear;
        pub const insert = All.Enemies.insert;
        pub const query = All.Enemies.query;
    };

    pub const Projectiles = struct {
        pub const clear = All.Projectiles.clear;
        pub const insert = All.Projectiles.insert;
        pub const query = All.Projectiles.query;
    };
};
```

Usage: `Sectors.Enemies.query(...)`, `Sectors.Projectiles.insert(...)`

---

## Naming Conventions

### General Rules

| Element       | Style      | Example                           |
| ------------- | ---------- | --------------------------------- |
| Variables     | camelCase  | `enemyPosition`, `hitCount`       |
| Functions     | camelCase  | `getPosition`, `calculateDamage`  |
| Constants     | camelCase  | `maxEnemies`, `fixedDelta`        |
| Types/Structs | PascalCase | `Vector2`, `Attributes`, `Effect` |
| Enums         | PascalCase | `Direction`, `Activity`           |
| Enum values   | PascalCase | `.StormPeaks`, `.Idle`            |

### Enum Values

Use PascalCase for regular enum values.

Use `NONE` (all caps) for technical sentinel values representing empty/null/unset states:

```zig
// Good
const Biome = enum {
    NONE,
    StormPeaks,
    EarthSanctum,
};

// Avoid
const Biome = enum {
    none,         // should be NONE
    stormPeaks,   // should be StormPeaks
    earthSanctum, // should be EarthSanctum
};
```

### Never Abbreviate

Having long variable names like for example `isNextUpdateAvailable` is totally fine.

**NEVER ABBREVIATE!**
**NEVER ABBREVIATE!**
**NEVER ABBREVIATE!**

**Always use full, descriptive names!**

```zig
// Good
const context = Context.OnAttack.get();
const enemyPosition = Enemies.Get.position(enemyIndex);
const attackDamage = calculateDamage(baseAttributes);
const knockbackVelocity = state.knockbackVelocity;

// Avoid
const ctx = Context.OnAttack.get();
const ePos = Enemies.Get.position(eIdx);
const atkDmg = calcDmg(baseAttrs);
const kbVel = state.kbVel;
```

Value clarity above conciseness, and in general above all else.

Try to reduce cognitive load as much as possible.

### Booleans Ask Questions

```zig
// State variables
isRunning: bool,
isActionLocked: bool,
isStunned: bool,
hasData: bool,

// Query functions
pub fn isReady(self: Countdown) bool { ... }
pub fn isNearZero(self: Vector2) bool { ... }
pub fn isDashReady() bool { ... }

// Local variables
const isHit = Collision.circleToCircle(position, radius, enemyPosition, enemyRadius);
const isPlayerInAttackRange = (distanceSquared < rangeSquared);
const shouldChasePlayer = !isPlayerInAttackRange;
```

### Functions Are Verbs

```zig
fn getPosition(index: u16) Vector2 { ... }
fn calculateDamage(base: f32, mods: Mods) f32 { ... }
fn applyKnockback(target: *State, velocity: Vector2) void { ... }
fn queryEnemiesInCircle(buffer: *[128]u16, position: Vector2, radius: u16) u16 { ... }
```

### Type Suffixes for Clarity

When converting types or when multiple type variants exist:

```zig
const radius_f32: f32 = @floatFromInt(radius);
const isHit = Collision.circleToCircle(position, radius_f32, enemyPosition, enemyRadius);
```

```zig
// Type variants
const Vector2 = @import("./vector2.zig").Out;       // f32 version
const Vector2_i32 = @import("./vector2_i32.zig").Out; // i32 version
```

### Modifier Suffixes

For game mechanics with flat/scale modifiers:

```zig
const Accumulator = struct {
    power_scale: f32 = 0.0,
    movespeed_scale: f32 = 0.0,
    armor_flat: f32 = 0.0,
};
```

---

## Code Style

### Early Returns (Guard Clauses)

Prefer early returns over nested if-else chains. Handle edge cases and exit conditions first, keeping the main logic flat:

```zig
// Good - early returns
fn processEntity(entity: u16) void {
    if (entity >= maxEntities) return;
    if (!Data.isActive[entity]) return;
    if (Data.health[entity] <= 0) return;

    // Main logic here, un-nested
    const damage = calculateDamage(entity);
    applyDamage(entity, damage);
}

// Avoid - nested conditionals
fn processEntity(entity: u16) void {
    if (entity < maxEntities) {
        if (Data.isActive[entity]) {
            if (Data.health[entity] > 0) {
                // Main logic buried in nesting
                const damage = calculateDamage(entity);
                applyDamage(entity, damage);
            }
        }
    }
}
```

### Extract Complex Conditionals

Move complex conditions into named constants for clarity:

```zig
// Good - clear intent
const isHit = Collision.circleToCircle(position, radius_f32, enemyPosition, enemyRadius);
if (isHit) {
    buffer[hitCount] = enemyIndex;
    hitCount += 1;
}

// Good - readable game logic
const distanceToPlayerSquared = state.position.distanceSquared(Player.Get.position());
const attackRangeSquared = attributes.attackRange * attributes.attackRange;
const isPlayerInAttackRange = (distanceToPlayerSquared < attackRangeSquared);
if (isPlayerInAttackRange) shouldChasePlayer = false;

// Good - bounds checking
const isOffBounds = (cell.x < 0 or cell.x >= cols or cell.y < 0 or cell.y >= rows);
if (isOffBounds) return 0;
```

### Never Use `unreachable`

Always use `@panic("DEV: ...")` instead of `unreachable`. Even when a branch is logically impossible, `@panic` gives a clear error message if assumptions are ever wrong:

```zig
// Good
.NONE => @panic("DEV: invalid enum value"),

// Avoid
.NONE => unreachable,
```

### Panic on Invalid States

Use `@panic` in switch `else` branches to catch development errors instead of silent fallbacks:

```zig
// Good - catches invalid states during development
const damage = switch (attackLevel) {
    1 => attributes.attack1Damage,
    2 => attributes.attack2Damage,
    3 => attributes.attack3Damage,
    else => @panic("DEV: invalid attack level"),
};

// Avoid - silently hides bugs
const damage = switch (attackLevel) {
    1 => attributes.attack1Damage,
    2 => attributes.attack2Damage,
    3 => attributes.attack3Damage,
    else => attributes.attack1Damage, // Bug goes unnoticed
};
```

### Float Literals

Always write float literals with a decimal point:

```zig
// Good
timeElapsed: f32 = 0.0,
speed: f32 = 1.0,

// Avoid
timeElapsed: f32 = 0,
speed: f32 = 1,
```

### Avoid Fancy Syntax

Keep code straightforward:

```zig
// Good - explicit and clear
var hitCount: u16 = 0;
for (0..candidateCount) |i| {
    const enemyIndex = buffer[i];
    if (checkHit(enemyIndex)) {
        buffer[hitCount] = enemyIndex;
        hitCount += 1;
    }
}

// Avoid - clever one-liners that obscure intent
```

### Avoid Labeled Blocks

Never use labeled blocks (`blk: { break :blk value; }`) to compute values inline. Extract to a helper function or restructure:

```zig
// Avoid - labeled block for inline computation
const hasLeafFields = comptime blk: {
    for (info.fields) |field| {
        if (@typeInfo(field.type) != .@"struct") break :blk true;
    }
    break :blk false;
};

// Good - extract to a function
fn hasLeafFields(comptime info: std.builtin.Type.Struct) bool {
    for (info.fields) |field| {
        if (@typeInfo(field.type) != .@"struct") return true;
    }
    return false;
}
```

### Avoid Fancy Data Structures

Use simple building blocks:

- Constants
- Variables
- Arrays (fixed-size)
- Structs
- Enums

Avoid:

- `ArrayList`
- `HashMap`
- `StringHashMap`
- Complex generic containers

### Always Be Explicit

Always set fields explicitly, even when the value matches the default. Never rely on implicit defaults or optional field omission.

```zig
// Good - explicit
.isMelee = false,
.knockbackForce = 0.0,
.spawnOnDeath = .NONE,

// Avoid - relying on defaults
// (field omitted, hoping the default is correct)
```

Exception: struct-wide zero-init with `.{}` is fine when initializing an entire struct to defaults.

### Prefer `NONE` Sentinels Over Optionals

Use an explicit `NONE` enum value (all caps) instead of Zig optionals (`?T`) for fields that may have no value. `NONE` is a technical sentinel -- all caps distinguishes it from actual design enum values.

```zig
// Good - NONE sentinel
const PresetType = enum(u8) { NONE, MeleeImpact, MeleeBleed };
spawnOnDeath: PresetType,  // set to .NONE when unused

// Avoid - optional
spawnOnDeath: ?PresetType = null,
```

---

## External Data (TOML)

All tunable game parameters live in external TOML files under `config/`, loaded at runtime. Nothing is hardcoded for gameplay values.

### DataLoader

`data_loader.zig` provides a generic, zero-heap TOML loader. It uses two static fixed-size buffers (`fileBuffer: [16KB]u8`, `parseBuffer: [32KB]u8`) and resolves paths relative to the executable directory. The third-party `sam701/zig-toml` library handles parsing.

```zig
const data = DataLoader.load(FileData, "config/actors/enemies.toml");
```

The parser is **type-driven**: you pass a Zig struct type, and it fills the struct from the TOML data. Field names must match TOML keys exactly.

### The `FileData` Pattern

Each consumer defines a private `FileData` struct that mirrors the TOML file's schema:

```zig
const FileData = struct {
    Grunt: EnemyPreset,
    Archer: EnemyPreset,
};

var data: FileData = undefined;

fn init() void {
    data = In.DataLoader.load(FileData, "config/actors/enemies.toml");
    In.Validate.enemies(data);
}
```

Two patterns for exposing the loaded data:

**Pattern A: Scatter into `pub var`** (used by Config, Colors)

The loaded data is destructured into individual `pub var` fields. The `FileData` is used only transiently:

```zig
pub var inputCaptureTime: f32 = undefined;

pub fn loadData() void {
    const data = In.DataLoader.load(GeneralFileData, "config/core/general.toml");
    In.Validate.general(data);
    General.Input.inputCaptureTime = data.Input.inputCaptureTime;
    // ... scatter each field
}
```

**Pattern B: Store the whole `FileData`** (used by Enemies, Projectiles, Hazards, Items, Biomes)

The entire parsed struct is stored in a module-level `var data` and accessed through getter functions:

```zig
var data: FileData = undefined;

fn init() void {
    data = In.DataLoader.load(FileData, "config/actors/enemies.toml");
    In.Validate.enemies(data);
}

fn generate(enemyType: EnemyType, varietyRng: fn () f32) Attributes {
    const attributes = switch (enemyType) {
        .Grunt => data.Grunt.attributes,
        .Archer => data.Archer.attributes,
    };
    // ...
}
```

### Validation

Every TOML load is immediately followed by a validation call through `validate.zig`. Validation uses `@panic` with a `"DATA: ..."` prefix to catch configuration errors at startup:

```zig
data = In.DataLoader.load(FileData, "config/actors/enemies.toml");
In.Validate.enemies(data);
```

### Config Namespace

`config.zig` is the unified namespace for all externally loaded configuration. It has three layers:

- **`Config.Limits`** - hardcoded comptime constants that never change (max entity counts, grid sizes, time step, etc.)
- **`Config.General`** - small config sections loaded from `config/core/general.toml` (Input, Game, Knockback, BodyCollision, Player, Healthbars, Corpses)
- **`Config.Debug`**, **`Config.ScreenShake`**, **`Config.SlashArc`**, etc. - each loaded from its own TOML file under `config/`
- **`Config.Colors`** - re-exported from `colors.zig`, loaded from `config/presentation/colors.toml`

### TOML Conventions

- **Table names** use PascalCase: `[Grunt]`, `[Lightning]`, `[Sprint]`
- **Dotted sub-tables** for hierarchy: `[Grunt.attributes]`, `[Grunt.skills]`, `[Grunt.variety]`
- **Sentinel biome** uses `NONE` (all caps), matching the enum convention
- **Attribute modifiers** use `_flat` / `_scale` suffixes: `power_scale`, `movespeed_scale`, `armor_flat`
- **2D vectors** as inline tables: `spawnPosition = { x = 670.0, y = 670.0 }`
- **Colors** as inline RGBA tables: `color = { r = 230, g = 41, b = 55, a = 255 }`
- **Enum values** as quoted strings: `weapon = "BasicSword"`, `helmet = "NONE"`
- **Cross-references** via string keys: `onDeathHazard = "FirebombBlast"`
- **Always set all fields explicitly**, even when the value is zero or `"NONE"`. Never omit fields to rely on code defaults

---

## Memory Management

### Zero Heap Allocation

The codebase completely avoids dynamic memory allocation.

### Fixed-Size Arrays

Define capacities as compile-time constants:

```zig
// config.zig
pub const Enemies = struct {
    pub const maxEnemies: u16 = 128;
    pub const maxEffects: u16 = 128;
};

// enemies/all.zig
const Data = struct {
    var attributes: [Config.Enemies.maxEnemies]Attributes = undefined;
    var state: [Config.Enemies.maxEnemies]State = undefined;
    var effects: [maxEnemies][maxEffects]Effect = undefined;
    var effectsCount: [maxEnemies]u8 = .{0} ** maxEnemies;
    var activeCount: u16 = 0;
};
```

### Dense Array Pools

Spawnable entities (projectiles, hazards) use a dense array with an active count. The range `[0..activeCount)` is always compact -- no gaps:

```zig
const Data = struct {
    var attributes: [maxCount]Attributes = undefined;
    var state:      [maxCount]State = undefined;
    var activeCount: u16 = 0;
};

fn spawn(...) void {
    Data.attributes[Data.activeCount] = newAttributes;
    Data.state[Data.activeCount] = newState;
    Data.activeCount += 1;
}
```

Despawn uses swap-remove (see below) to keep the array dense.

### Stack-Allocated Query Buffers

```zig
fn performAttack(params: MeleeHit) u16 {
    var hitBuffer: [Config.Sectors.capacity]u16 = undefined;

    const hitCount = HitDetection.queryEnemiesInCircle(
        &hitBuffer,
        hitboxCenter,
        hitboxRadius,
    );

    for (0..hitCount) |i| {
        const enemyIndex = hitBuffer[i];
        // process hit...
    }

    return hitCount;
}
```

### Swap-Remove for Entity Removal

```zig
fn despawn(entity: u16) void {
    const last = (Data.activeCount - 1);

    Data.attributes[entity] = Data.attributes[last];
    Data.state[entity] = Data.state[last];
    Data.effects[entity] = Data.effects[last];

    Data.activeCount -= 1;
}
```

---

## Passing Arrays as Slices

### Read-Only Slice

```zig
fn accumulate(effects: []const Effect) Accumulator {
    var accumulator: Accumulator = .{};
    for (effects) |effect| {
        // process effect...
    }
    return accumulator;
}

// Usage: pass only active portion
const result = accumulate(Data.effects[0..Data.effectsCount]);
```

### Mutable Slice

```zig
fn add(effectsCount: *u8, effects: []Effect, newEffect: Effect) void {
    effects[effectsCount.*] = newEffect;
    effectsCount.* += 1;
}

// Usage: pass full array as mutable slice
Effects.add(&Data.effectsCount, Data.effects[0..], newEffect);
```

### Buffer Pattern (Pointer to Fixed Array)

```zig
fn query(buffer: *[capacity]u16, position: Vector2, radius: u16) u16 {
    var found: u16 = 0;
    // fill buffer...
    buffer[found] = entityId;
    found += 1;
    // ...
    return found;
}

// Usage: caller provides stack buffer
var buffer: [Config.Sectors.capacity]u16 = undefined;
const count = query(&buffer, position, radius);
```

---

## Comments & Documentation

### Doc Comments (`///`)

Doc comments attach to the public API. Placement depends on the `Out` pattern:

**Curated `Out` struct:** Comment goes above `pub const Out`:

```zig
/// Combat system module.
pub const Out = struct {
    pub const HitDetection = @import("./hit_detection.zig").Out;
    pub const Melee = @import("./melee.zig").Out;
};
```

**Direct alias:** Comment goes on the main struct:

```zig
pub const Out = Attributes;

/// Player attributes - numeric parameters defining character capabilities.
const Attributes = struct {
    vitality: f32,
    movespeed: f32,
};
```

Use sparingly - only for public APIs that benefit from documentation.

### Inline Comments

Short explanations for non-obvious values:

```zig
var head: usize = 0; // write position
var tail: usize = 0; // read position

.{ .chance = 0.15, .damage = 10.0 }, // level 1
.{ .chance = 0.25, .damage = 15.0 }, // level 2
```

---

## Directory Structure

- Single-file modules: `module.zig`
- Multi-file modules: `module/all.zig` as aggregator
- Subsystems: `module/systems/all.zig`

---

## Entity Data Ownership

Entities (such as Player or Enemies) generally own their core data.

Systems define types and provide utilities, not storage.
