# Project Code Style Template

This is a blueprint template, not active project guidance. When applying the blueprint, rewrite this file as `docs/ai/codestyle-project.md` with factual project-specific rules.

Always read these files first:

- `docs/ai/codestyle-main.md`
- the relevant language codestyle file, such as `docs/ai/codestyle-zig.md` or `docs/ai/codestyle-typescript.md`

## Purpose

Use this file only for rules that are specific to this project. Do not repeat general rules from `codestyle-main.md` or language rules from the language codestyle file.

This file should start empty or nearly empty. Delete sections that do not have real project-specific rules. If the main and language codestyle files already cover the project, the final `codestyle-project.md` should contain only a short note that there are no project-specific rules yet.

## Project-Specific Goals

- <Project-specific code goal.>
- <Project-specific performance, architecture, or maintainability goal.>

## Architecture Rules

- <Project-specific module, package, layer, or dependency direction rule.>
- <Project-specific ownership boundary.>

## Naming And Structure

- <Project-specific naming exception or directory/file structure convention.>
- <Project-specific namespace, export, or public API convention.>

## Config And Resources

- <Project-specific config ownership, schema, loader, validation, or save rule.>
- <Project-specific resources/assets format, directory, or import rule.>

## Runtime And Error Handling

- <Project-specific runtime invariant or error handling rule.>
- <Project-specific logging, panic, validation, or user-facing error convention.>

## Verification

- <Smallest useful validation command for project-specific code changes.>
- <Manual smoke check if useful.>
