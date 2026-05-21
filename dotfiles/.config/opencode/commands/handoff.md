---
description: Create or update a distilled, self-contained implementation handoff in plans/
---

You are running as an AI coding assistant in OpenCode. The user is invoking the `/handoff` command at the end of a planning, research, debugging, implementation, or brainstorming phase.

Your job is to create or update a durable handoff plan under `plans/` so a brand new AI agent with zero prior conversation context can continue safely and effectively.

Do not implement the actual feature/change unless the user explicitly asks for implementation. This command is for preserving context, decisions, research, and next steps in a plan file, then giving the user a ready-to-copy fresh-agent prompt.

## Command Arguments

Raw OpenCode command arguments:

```text
$ARGUMENTS
```

Treat everything after `/handoff` as high-priority handoff context. Incorporate it where relevant, especially explicit instructions, corrections, constraints, scope changes, or focus areas.

If command arguments conflict with earlier conversation context, prefer the command arguments and document the conflict in `Open Questions`, `Assumptions`, or `Notes For Future Agents`.

## Core Outcome

Create or update one self-contained Markdown plan file in `plans/` that captures:

- The concrete objective and desired outcome
- Key decisions made and the rationale behind them
- What has already been done, including any files changed or partial work completed
- What remains to be done
- Relevant codebase context from inspected files
- Required files or docs a fresh agent should read first
- A practical implementation plan
- An actionable checklist using unchecked Markdown checkboxes: `[ ]`
- Verification commands, manual checks, and acceptance criteria
- Risks, edge cases, assumptions, and open questions
- Instructions for future agents to update the plan as they work
- A ready-to-copy prompt for starting a fresh AI agent in the final response

The plan must be detailed enough that a fresh AI assistant can read the project guidance and the plan file, then understand what needs to be done, where to look, how to implement it, and how to verify it.

## Operating Rules

- Actually create or update the plan file. Do not only print the plan content in chat.
- Distill, do not transcribe. This is a task brief, not conversation minutes.
- Preserve useful decisions, constraints, and findings. Remove debugging noise, tangents, abandoned approaches, and irrelevant chat unless a future agent must know not to repeat them.
- Prefer facts from files, commands, and the current conversation over guesses.
- Read the files you reference. Do not guess at file contents, function names, line numbers, commands, or APIs.
- Do just enough repository inspection to make the handoff accurate. Do not over-research unrelated areas.
- Preserve unrelated user changes. Do not revert, overwrite, or clean up work outside the handoff task.
- If secrets or credentials appear in context, do not copy them into the plan. Redact them and note that sensitive values were omitted.
- Ask concise clarification questions only if the handoff would be misleading or impossible without the answer. Otherwise, proceed with explicit assumptions and open questions.
- Keep the plan practical and implementation-focused. Avoid vague checklist items like "fix stuff" or "improve code".
- Use imperative voice for future work: "Modify...", "Add...", "Verify..." rather than "We discussed...".
- Prefer code pointers over code dumps. Include small snippets only when the pattern is not obvious from reading the source.

## Process

1. Review the current conversation and command arguments.

2. Extract the objective, decisions, rationale, user preferences, constraints, findings, completed work, remaining work, and anything explicitly out of scope.

3. Check for and read the project guidance entry file, especially `AGENTS.md` at the repository or project root.

4. Read any relevant style, architecture, workflow, or fresh-session docs referenced by `AGENTS.md`, such as `README.md`, `codestyle.md`, `code-style.md`, or equivalent files.

5. Identify the key code files, docs, tests, configs, scripts, commands, APIs, or data shapes needed for the remaining work. Read the important ones before writing the plan.

6. Ensure the `plans/` directory exists. If it does not exist, create it.

7. Look for existing related plan files in `plans/`.

8. If an existing plan is clearly about the same task, update it instead of creating a duplicate.

9. If there are obsolete duplicate plans about the exact same task, consolidate them when safe. Do not delete unrelated plans.

10. Write the plan as `plans/<short-topic-name>.md` using a concise kebab-case topic name. Avoid generic names like `plan.md`, `handoff.md`, or `todo.md` unless the repository already uses that convention.

11. Make the plan self-contained. Do not rely on phrases like "as discussed above", "the previous agent", or hidden conversation context.

12. Keep implementation checklist items unchecked unless the actual implementation work has already been completed.

13. Add explicit open questions and assumptions for unresolved or uncertain points. Do not silently fill important gaps with guesses.

14. Before finishing, re-read the plan and check it against the quality bar below.

## Required Plan Structure

Use this structure unless there is a strong reason to adapt it. Every section should be present. If a section has nothing to report, keep the heading and write a short note such as "None currently known.".

```md
# <Plan Title>

## Handoff Metadata

- Status: Ready for implementation | Needs clarification | Investigation only | Partially implemented
- Created: <YYYY-MM-DD>
- Last updated: <YYYY-MM-DD>
- Command arguments: <verbatim text passed after /handoff, or "None">
- Related plans: <paths to related plans, or "None">

## Project Guidance Read

List the guidance files checked for this handoff, especially `AGENTS.md` and relevant style/docs files.

Summarize only task-relevant instructions future agents must follow. Do not duplicate broad project rules unless they directly affect this task.

## Objective

Explain what is being built, fixed, changed, investigated, or cleaned up and why.

Write this as a task brief for a fresh agent, not meeting notes.

## Background

Summarize the relevant conversation context, user goals, explicit preferences, constraints, rejected approaches worth remembering, and how the current direction was chosen.

Leave out tangents and exploration that do not affect the remaining work.

## Decisions Made

List key decisions from this conversation that must carry forward.

For each decision, include the rationale. If no decisions were made, write "None currently known.".

## Current State

Describe what exists now.

Include relevant files, behavior, data flow, commands, and any work already completed. If nothing has been implemented yet, state that explicitly. If work is partial, describe what works and what does not.

## Target State

Describe the desired final behavior, output, architecture, user experience, or repository state.

Include acceptance criteria when known.

## Research Findings

Document important findings from code inspection, docs, experiments, errors, or discussion.

Use concrete references: file paths, function names, commands, APIs, data shapes, line ranges when helpful, and non-obvious behavior.

Separate facts from assumptions.

## Required Context

List the files, docs, tests, configs, or commands a fresh agent must read before starting.

For each item, include:

- Path or command
- Why it matters
- What to look for, such as functions, patterns, integration points, data contracts, or relevant line ranges

Only include context genuinely necessary for the task.

## Implementation Plan

Provide ordered, prerequisite-aware steps for the remaining work.

For each meaningful step, include what to do, likely files to create or modify, prerequisites, and gotchas. Do not pad with trivial steps. Do not include work already completed except as context.

## Checklist

Future agents should update this checklist as work is completed.

- [ ] Read the project guidance and required context listed above
- [ ] Confirm assumptions and open questions that block implementation
- [ ] Complete implementation step 1
- [ ] Complete implementation step 2
- [ ] Complete implementation step 3
- [ ] Run verification listed below
- [ ] Update this plan with any important new findings or deviations

## Verification

List the commands, tests, builds, lint checks, manual checks, and acceptance criteria that should confirm the work is correct.

If exact commands are unknown, say what the future agent should inspect before choosing verification.

## Risks And Edge Cases

List risks, tricky areas, compatibility concerns, data migration concerns, user-impacting behavior, race conditions, rollback concerns, or things likely to break.

## Assumptions

List assumptions the plan relies on. If there are none, write "None currently known.".

## Open Questions

List unresolved questions. Prefix important unresolved blockers with `OPEN QUESTION:`. If there are none, write "None currently known.".

## Notes For Future Agents

Explain how a fresh agent should proceed.

Mention that they should:

- Read `AGENTS.md` and the project guidance files listed above before implementation
- Read this plan before changing code
- Update checklist items as they complete work
- Preserve unrelated user changes
- Avoid deleting or rewriting unrelated code
- Add important new findings back into this document
- Ask the user before making destructive or broad changes not covered by this plan
```

## Quality Bar

Before finishing, verify that the handoff plan:

- Names the concrete task and desired outcome
- Incorporates command arguments, if provided
- Lists project guidance files checked, especially `AGENTS.md` when present
- Distinguishes objective, background, decisions, current state, target state, and remaining work
- Includes only relevant conversation context and filters out noise
- Lists relevant files, commands, functions, APIs, docs, tests, or data shapes when known
- Gives specific required context with why each item matters and what to look for
- Separates facts from assumptions and unresolved questions
- Has a practical, ordered checklist with `[ ]` items
- Includes verification steps and acceptance criteria
- Can be understood by a brand new AI assistant without reading the prior chat
- Does not expose secrets or unrelated private information

## Final Response

After writing or updating the plan file, respond with:

1. The path of the plan file
2. A short summary of what it contains
3. Any old related plans you updated, deleted, or consolidated
4. Any assumptions or open questions
5. A full prompt the user can give to a brand new AI assistant

The fresh-agent prompt should be ready to copy and should say something like:

```text
Read the project `AGENTS.md` and any guidance/style docs referenced by the plan first. Then read `<plan-file-path>` and treat it as the source of truth for this task. Follow the implementation plan inside it, update the checklist in that file as you complete tasks, and add any important new findings back into the plan. Preserve unrelated user changes. Ask before making destructive or broad changes not covered by the plan. When finished, run the verification steps from the plan and summarize what changed, what was verified, and any remaining risks.
```
