# AGENTS Template

This is a blueprint template, not active project guidance. When applying the blueprint, write a new project-specific `AGENTS.md` based on this structure.

<One factual sentence describing what this project is.>

## Required Reading

- Read `docs/ai/documentation-guide.md` before documentation work.
- Read `docs/ai/codestyle-main.md` before non-trivial code changes.
- Read the relevant language or project codestyle file before non-trivial code changes:
  - `docs/ai/codestyle-zig.md`
  - `docs/ai/codestyle-typescript.md`
  - `docs/ai/codestyle-project.md`

## Tech Stack

- **Language**: <language and version if known>
- **Runtime**: <runtime, engine, browser, server, or platform>
- **Frameworks**: <frameworks>; optional
- **Data**: <database, files, config, memory, or none>; optional
- **Config**: <config format and owner if important>; optional
- **Resources**: <asset/resource formats and directories if important>; optional
- **Package manager**: <npm, pnpm, bun, Zig package manager, Cargo, etc.>; optional
- **Validation**: <typecheck, build, compile, smoke check, or test command if useful>; optional

## Architecture

- <Current architecture fact.>
- <Where source data, config, runtime state, public APIs, or domain contracts live.>
- <Where config is defined, loaded, validated, and edited if the project has important config.>
- <Where resources/assets live and which formats matter if the project has important resources.>
- <Important dependency direction or ownership boundary.>
- <Important things this project intentionally does not have.>

## Project Structure

```text
README.md                              -- human setup and operation guide
AGENTS.md                              -- first-entry AI project map, file inventory, and working rules
docs/
  ai/
    documentation-guide.md             -- documentation rules for AI assistants
    codestyle-main.md                  -- general code style fundamentals
    codestyle-<language>.md            -- language-specific code style rules
    codestyle-project.md               -- project-specific code style rules; empty or minimal by default
  plans/                               -- active implementation plans, handoffs, and checklists
  superpowers/
    specs/                             -- Superpowers brainstorming specs
    plans/                             -- Superpowers implementation plans
src/                                   -- main source code
```

Write this structure like the real filesystem.
If source files are nested, show the same nesting here instead of flattening paths into one list.
Add every important source file and directory with a short sentence describing what it owns.
Update this inventory when files are added, removed, renamed, or responsibilities change.

## Commands

- `<command>` -- <what it does>

## Documentation Rules

- `AGENTS.md` is the first file AI assistants should read.
- Keep `AGENTS.md` updated whenever files are added, removed, renamed, or responsibilities change.
- Keep the tech stack section current, including important language, runtime, framework, tool, and resource/config versions.
- Keep the project structure inventory current. It should list all source files with short descriptions of what they do, following the real directory nesting.
- `docs/ai/` contains AI-maintained current-truth documentation.
- `docs/plans/` contains active plans and handoffs, not canonical implemented behavior.
- `docs/superpowers/` contains Superpowers-generated specs and plans.
- If `docs/human/` exists, it is human-only. AI assistants must not read, summarize, edit, or rely on it unless explicitly asked.
- Prefer current source code, config, manifests, and scripts over stale prose.

## Important

- <Hard project constraint.>
- <Generated or ignored paths that must not be edited.>
- <Features, frameworks, compatibility layers, migrations, or systems not to add unless explicitly requested.>
