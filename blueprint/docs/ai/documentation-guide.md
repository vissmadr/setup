# Documentation Guide

Documentation rules for AI assistants.

## Purpose

Documentation exists to make future work faster and safer. It should describe the current project truth clearly enough that a fresh AI assistant can understand the project, change it, and keep the documentation current.

## Documentation Map

- `AGENTS.md` is the first-entry project map for AI assistants.
- `docs/ai/` contains AI-maintained current-truth documentation.
- `docs/plans/` contains active plans, handoffs, checklists, and task sequencing.
- `docs/superpowers/specs/` contains Superpowers brainstorming specs.
- `docs/superpowers/plans/` contains Superpowers implementation plans.
- `docs/human/`, when present, is human-only and must be ignored unless the user explicitly allows it.

## Source Of Truth Order

For implemented behavior, prefer sources in this order:

1. Current source code.
2. Current config, schema, build files, package manifests, scripts, and resource files.
3. Maintained docs in `docs/ai/`.
4. Root `AGENTS.md` and `README.md`.
5. Active plans in `docs/plans/` and `docs/superpowers/plans/`.

If documentation disagrees with source code, trust the source code and update the stale documentation.

## `AGENTS.md` Rules

`AGENTS.md` must stay optimized for a fresh AI assistant's first five minutes in the repository.

It should include:

- a one-sentence project summary
- the actual tech stack, including important language, runtime, framework, tool, and resource/config versions
- optional validation, config, and resources notes when they matter
- current architecture facts
- a project structure map that mirrors the real filesystem nesting
- all source files with short descriptions of what they do
- common commands
- documentation rules
- hard constraints and generated paths to ignore

Update `AGENTS.md` in the same task when:

- files or directories are added
- files or directories are removed
- files or directories are renamed
- file responsibilities change
- tech stack versions change
- source files need new or corrected descriptions
- commands change
- validation, config, or resource workflows change
- architecture or dependency boundaries change
- documentation structure changes

Do not let `AGENTS.md` become aspirational. It should describe the project that exists now.

## `docs/ai/` Rules

Use `docs/ai/` for stable documentation about implemented behavior.

Good `docs/ai/` topics include:

- architecture and ownership boundaries
- API endpoints and data contracts
- database or persistence behavior
- frontend routing, state ownership, and styling rules
- rendering, game systems, assets, and config ownership
- workflows and commands future agents need

Do not create empty placeholder docs. Add a doc only when it helps future work.

## Code Style Docs

Code style is split into three files:

- `docs/ai/codestyle-main.md` contains general code style fundamentals.
- The language codestyle file, such as `docs/ai/codestyle-zig.md` or `docs/ai/codestyle-typescript.md`, contains language-specific rules.
- `docs/ai/codestyle-project.md` contains project-specific rules.

Keep `docs/ai/codestyle-project.md` empty or minimal by default. If the AI assistant or human decides that this project has specific codestyle requirements, write those requirements in `docs/ai/codestyle-project.md` instead of changing the main or language codestyle files.

## Plans Rules

Use `docs/plans/` for task-specific plans, handoffs, checklists, decisions, and remaining work.

Plans are not canonical documentation for implemented behavior. When a plan is implemented, update `AGENTS.md` and relevant `docs/ai/` files so the current truth is not buried in a plan.

## Human-Only Docs Rule

If `docs/human/` exists, AI assistants must not read, edit, summarize, move, delete, or rely on anything inside it unless the user explicitly asks for that directory or a specific file.

The human-only rule belongs in `AGENTS.md` and this file, not inside `docs/human/`.

## Writing Style

- Write concise, factual documentation.
- Prefer file paths, command names, and concrete ownership statements.
- Describe current behavior, not old decisions or hoped-for future behavior.
- Do not paste large code blocks unless the exact snippet is the contract.
- Do not document generated files as source truth.
- Do not rewrite docs just to polish wording.
- Make the smallest documentation change that keeps future agents correctly oriented.

## Required Updates During Code Work

Update documentation in the same task when code changes affect:

- project structure
- file ownership
- architecture boundaries
- commands or scripts
- project-specific codestyle requirements
- public APIs or data contracts
- config schema or resource layout
- persistence, migrations, or seed data
- UI routes, screens, or major workflows
- important constraints future agents must know

Docs-only verification can be done by re-reading the changed documentation and checking it against the actual repository state.
