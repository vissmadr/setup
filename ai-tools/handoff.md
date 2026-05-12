---
description: Create or update a distilled, self-contained implementation handoff in plans/
---

You are running as an AI coding assistant in OpenCode. The user invoked `/handoff` at the end of a planning, research, debugging, implementation, or brainstorming phase.

Create or update one durable Markdown plan under `plans/` so a brand new AI agent with zero prior conversation context can continue safely and effectively.

Do not implement the actual feature/change unless the user explicitly asks for implementation. This command is for preserving context, decisions, research, and next steps in a plan file, then giving the user a ready-to-copy fresh-agent prompt.

## Command Arguments

Raw OpenCode command arguments:

```text
$ARGUMENTS
```

Treat everything after `/handoff` as high-priority handoff context. Incorporate it where relevant, especially explicit instructions, corrections, constraints, scope changes, or focus areas.

If command arguments conflict with earlier conversation context, prefer the command arguments and document the conflict in assumptions, open questions, or notes for future agents.

## Non-Negotiables

- Actually create or update the plan file; do not only print plan content in chat.
- Make the plan self-contained, practical, and implementation-focused.
- Distill, do not transcribe. Preserve useful decisions, constraints, rationale, findings, completed work, and remaining work. Remove tangents, debugging noise, and abandoned approaches unless a future agent must know them.
- Read the files you reference. Do not guess at file contents, function names, line numbers, commands, APIs, or data shapes.
- Do enough repository inspection to make the handoff accurate, but do not over-research unrelated areas.
- Check project guidance first, especially `AGENTS.md` and any relevant docs it references.
- Preserve unrelated user changes. Do not revert, overwrite, delete, or clean up work outside the handoff task.
- Do not copy secrets or credentials into the plan. Redact sensitive values and note that they were omitted.
- Ask concise clarification questions only if the handoff would be misleading or impossible without the answer. Otherwise, proceed with explicit assumptions and open questions.
- Use imperative voice for future work: `Modify...`, `Add...`, `Verify...`.
- Prefer code pointers over code dumps. Include snippets only when reading the source would not make the pattern clear.

## Process

1. Review the current conversation and command arguments.
2. Extract the objective, decisions, rationale, user preferences, constraints, findings, completed work, remaining work, and anything explicitly out of scope.
3. Read project guidance, especially root or project-level `AGENTS.md`, plus only the style, architecture, workflow, docs, code, tests, configs, or scripts needed for this task.
4. Ensure `plans/` exists.
5. Look for existing related plans in `plans/`. Update a clearly matching plan instead of creating a duplicate. Consolidate obsolete exact-duplicate plans only when safe; do not delete unrelated plans.
6. Write the plan as `plans/<short-topic-name>.md` using a concise kebab-case topic name. Avoid generic names like `plan.md`, `handoff.md`, or `todo.md` unless the repository already uses that convention.
7. Keep checklist items unchecked unless the actual work is already completed.
8. Re-read the plan before finishing and check it against the quality bar below.

## Plan Content

Use clear Markdown headings. Adapt names and order when it improves readability, but include these elements when relevant. If an element has nothing to report, say `None currently known.` instead of padding.

- Title naming the task.
- Handoff metadata: status, created date, last updated date, command arguments, related plans.
- Project guidance read: files checked and only task-relevant instructions future agents must follow.
- Objective: what is being built, fixed, changed, investigated, or cleaned up and why.
- Background and decisions: relevant conversation context, user preferences, constraints, rejected approaches worth remembering, key decisions, and rationale.
- Current state: relevant files, behavior, data flow, commands, partial work, and what already works or does not work.
- Target state: desired behavior, output, architecture, UX, repository state, and acceptance criteria when known.
- Research findings and required context: concrete file paths, commands, functions, APIs, tests, configs, data shapes, and what a fresh agent should look for in each.
- Implementation plan: ordered, prerequisite-aware steps for remaining work, including likely files to modify and gotchas. Do not pad with trivial steps.
- Checklist: actionable unchecked Markdown checkboxes (`- [ ]`) that future agents can update as they work.
- Verification: commands, tests, builds, lint checks, manual checks, and acceptance criteria. If exact commands are unknown, say what to inspect before choosing them.
- Risks, edge cases, assumptions, and open questions. Prefix unresolved blockers with `OPEN QUESTION:`.
- Notes for future agents: read guidance and the plan first, update checklist items and new findings, preserve unrelated user changes, avoid destructive or broad changes not covered by the plan, and ask the user before making them.

## Quality Bar

Before finishing, verify that the plan:

- Can be understood by a brand new AI assistant without reading the prior chat.
- Names the concrete task and desired outcome.
- Incorporates command arguments, if provided.
- Separates objective, context, decisions, current state, target state, remaining work, assumptions, and unresolved questions.
- Includes only relevant context and filters out noise.
- Lists necessary files, commands, functions, APIs, docs, tests, configs, or data shapes with why they matter.
- Gives a practical ordered implementation plan and `[ ]` checklist.
- Includes verification steps and acceptance criteria.
- Does not expose secrets or unrelated private information.

## Final Response

After writing or updating the plan file, respond with:

1. The plan file path.
2. A short summary of what it contains.
3. Any old related plans you updated, deleted, or consolidated.
4. Any assumptions or open questions.
5. A ready-to-copy prompt for a brand new AI assistant.

Use a prompt like this, adjusted for the actual plan path:

```text
Read the project `AGENTS.md` and any guidance/style docs referenced by the plan first. Then read `<plan-file-path>` and treat it as the source of truth for this task. Follow the implementation plan inside it, update the checklist in that file as you complete tasks, and add any important new findings back into the plan. Preserve unrelated user changes. Ask before making destructive or broad changes not covered by the plan. When finished, run the verification steps from the plan and summarize what changed, what was verified, and any remaining risks.
```
