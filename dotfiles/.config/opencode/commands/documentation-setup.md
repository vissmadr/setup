---
description: Create or update standard AGENTS.md, docs-ai, docs-dev, and plans documentation for a project
---

You are running as an AI coding assistant in OpenCode. The user is invoking `/documentation-setup` to create or update a project's AI-assistant documentation structure.

## Command Arguments

Raw command arguments:

```text
$ARGUMENTS
```

Treat command arguments as high-priority context. They may specify a target project path, a custom guide path, project goals, stack, documentation scope, directories to preserve, human-only docs, or whether this is a new project or an existing project.

## Setup Guide

Read the reusable setup guide before editing. Use the first available source:

1. A guide path explicitly supplied in the command arguments.
2. `documentation-setup.md` in the target project root.
3. `docs-ai/documentation-setup.md` in the target project.
4. `plans/documentation-setup.md` in the target project.
5. `~/.config/opencode/documentation-setup.md` from the installed global OpenCode config.
6. `config/documentation-setup.md` when working inside the opencode-config source repository.

If no guide file is available, continue using this command's rules and note in the final response that no external setup guide was found.

## Goal

Create or update the target project so it has the standard documentation setup:

- Root `AGENTS.md` as the factual project orientation map.
- `docs-ai/documentation-guide.md` for AI docs ownership and update rules.
- `docs-ai/codestyle.md` for stack-specific coding conventions that agents must read before code changes.
- Optional additional `docs-ai/` stable docs when there is implemented behavior to document.
- `docs-dev/` as human-only space, with only a minimal placeholder if needed.
- `plans/` for implementation plans, checklists, and handoffs.
- A setup record plan in `plans/documentation-setup.md` when useful.

## Operating Rules

- Actually edit files in the target project. Do not only print suggested content.
- Default target project is the current working directory unless command arguments specify another path.
- Keep changes minimal, factual, and project-specific.
- Preserve unrelated user changes.
- Do not commit unless the user explicitly asks.
- Do not read, edit, summarize, or rely on `docs-dev/`, `docs-human/`, or any directory already documented as human-only unless the command arguments explicitly allow it.
- Do not copy secrets, credentials, `.env` values, personal notes, or human-only docs into AI-maintained files.
- Prefer current source code and config over stale docs.
- If existing docs conflict with current code, update AI-maintained docs to match code.
- If standardization would require broad migration, deletion, or high-churn rewriting of existing docs, ask before doing that work.
- Use concise wording. Avoid generic filler.

## Process

1. Identify the target project.
   Use the current working directory by default. If command arguments provide a project path, verify it exists before editing there.

2. Read the setup guide from the first available source listed above.

3. Inspect the target project root.
   Read existing root guidance, README, package/build config, source layout, schema/config files, existing `docs-ai/`, and existing `plans/` as needed. Skip human-only directories.

4. Detect project facts.
   Identify project purpose, language, stack, package manager, commands, runtime boundaries, source directories, generated paths, API surface, database ownership, and important constraints.

5. Create or update `AGENTS.md`.
   Follow the setup guide's standard structure. Include only actual current files and commands. Clearly label planned features as planned.

6. Create or update `docs-ai/documentation-guide.md`.
   Define AI-maintained docs, source-of-truth order, update rules, `plans/` usage, and human-only docs rules.

7. Create or update `docs-ai/codestyle.md`.
   Make it stack-specific. Use the codestyle baseline in the reusable setup guide when available, then add only project-specific constraints supported by the repo or command arguments.

8. Add optional stable `docs-ai/` docs only when useful.
   Examples: `architecture.md`, `api.md`, `database.md`, `frontend.md`, `rendering.md`, `ui.md`. Do not create empty placeholder docs.

9. Ensure `docs-dev/` is treated as human-only.
   Create `docs-dev/.gitkeep` only if the directory should be tracked and does not already have a better project-specific placeholder. Do not inspect existing contents.

10. Ensure `plans/` exists.
    If useful, create or update `plans/documentation-setup.md` with what was changed, guidance read, detected stack, canonical docs, human-only docs, remaining gaps, verification, assumptions, and open questions.

11. Verify the result.
    Re-read changed files and confirm paths, commands, docs rules, and file inventories match the actual project. Run no build or test commands unless source code changed or the user requested verification beyond docs.

## Final Response

After editing, respond with:

1. Files created or updated.
2. The detected stack and important assumptions.
3. Any docs or project areas intentionally not read because they are human-only.
4. Any remaining gaps or open questions.
5. Whether verification was limited to re-reading docs or included commands.
