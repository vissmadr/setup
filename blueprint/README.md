# Project Blueprint

Reusable documentation blueprint for projects.

This README is the usage guide for the blueprint. All other non-template files should be pure project files: after copying them into a project, they should read as normal project guidance and should not mention the blueprint.

Template files use `-template` in the filename. They are not copied directly under the same name. They are rewritten by the AI assistant into the final project file.

## Target Structure

```text
AGENTS.md
docs/
  ai/
    documentation-guide.md
    codestyle-main.md
    codestyle-<language>.md
    codestyle-project.md
  plans/
  superpowers/
    specs/
    plans/
  human/
```

Human-only notes live under `docs/human/`. AI assistants must ignore it completely.

## Copy Rules

- Copy pure files verbatim. Do not modify them for a project.
- Rewrite template files into their final project paths.
- Keep `docs/ai/codestyle-main.md` as the general style baseline.
- Keep the relevant main language codestyle file, such as `docs/ai/codestyle-zig.md` or `docs/ai/codestyle-typescript.md`. Projects usually have one main programming language.
- Always write `docs/ai/codestyle-project.md` from `docs/ai/codestyle-project-template.md`. It should start empty or nearly empty by default.
- Keep `docs/plans/` for implementation plans and handoffs.
- Keep `docs/superpowers/specs/` and `docs/superpowers/plans/` for Superpowers-generated specs and plans.
- Keep `docs/human/` as human-only space.

## Pure Files

Copy these directly into the target project when relevant:

- `docs/ai/documentation-guide.md`
- `docs/ai/codestyle-main.md`
- one main language codestyle file, such as `docs/ai/codestyle-zig.md` or `docs/ai/codestyle-typescript.md`
- `.gitkeep` placeholders under empty directories

Do not edit pure files while applying the blueprint. If a pure file needs improvement, change it here in the blueprint source, then copy the improved version everywhere.

## Template Files

Rewrite these into final project files:

- `AGENTS-template.md` -> `AGENTS.md`
- `docs/ai/codestyle-project-template.md` -> `docs/ai/codestyle-project.md`

Template files contain placeholders and blueprint notes. Remove all placeholders and template notes in the final project files.

`codestyle-project.md` is always present in the final project, but it should usually be empty or very small. Add content only when the AI assistant or human identifies concrete project-specific exceptions, ownership rules, validation commands, config/resource rules, or architectural constraints that are not covered by `codestyle-main.md` and the language codestyle file.

The final project should not contain `AGENTS-template.md`, `docs/ai/codestyle-project-template.md`, unused language codestyle files, or the `blueprint/` directory itself.

## How To Apply To A New Project

1. Copy pure files and directories into the target project.
2. Use `AGENTS-template.md` to write the target project's root `AGENTS.md`.
3. Keep `AGENTS.md` concise enough for a fresh AI agent to read first.
4. In `AGENTS.md`, list the important project files and directories with a short sentence for each one.
5. Keep `docs/ai/codestyle-main.md` and `docs/ai/documentation-guide.md` unchanged.
6. Keep the relevant main language codestyle file unchanged and delete unused language codestyle files.
7. Use `docs/ai/codestyle-project-template.md` to write `docs/ai/codestyle-project.md`; leave it empty or nearly empty unless real project-specific rules are known.
8. Add optional stable docs under `docs/ai/` only when the project has real implemented behavior to document.

## How To Apply To An Existing Project

- Do not blindly overwrite existing guidance.
- Read current `AGENTS.md`, documentation, build files, package manifests, config, and source layout first.
- Preserve accurate project-specific rules.
- Replace stale guidance with the blueprint structure only when it improves future AI sessions.
- Do not edit pure copied files for one project. Put project-specific exceptions in `docs/ai/codestyle-project.md` or `AGENTS.md`.
- Ignore human-only docs while migrating.

## Required Result

After applying the blueprint, a fresh AI assistant should know:

- what the project is
- which files matter
- what commands to run
- which documentation to read before code or documentation work
- where plans and handoffs belong
- which directories are generated, ignored, or human-only
