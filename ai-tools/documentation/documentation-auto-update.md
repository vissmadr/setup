# Documentation Auto-Update Workflow

This file defines the manual AI workflow for periodically updating maintained documentation to match the current codebase truth.

---

## Purpose

Use this workflow when a human wants AI to review all code changes since the last documentation checkpoint and bring the maintained docs up to date.

The checkpoint commit subject name is always exactly `update(docs): auto`.

---

## Required Project File

`docs-ai/documentation-guide.md` is required and is written by humans.

Always read it first.

It can define project-specific documentation expectations, scope exceptions, naming preferences, any extra canonical files outside `docs-ai/` that also need maintenance, and anything specific for the project in general.

If this file is missing, stop and report that the project is not configured for this workflow.

The file is allowed to be empty, which simply means default workflow with no project-specific details and requirements.

---

## Documentation Goal

The goal is not to preserve old documentation structure.

The goal is to make the maintained documentation reflect the current codebase truth as well as possible.

Document the final current state, not the commit-by-commit story of how the project got there.

---

## Scope

The default maintained documentation scope is `docs-ai/`.

`docs-ai/documentation-guide.md` may explicitly expand that scope to additional canonical files such as `AGENTS.md` or `README.md`. Do not infer extra scope on your own.

---

## Checkpoint Rule

Use the most recent reachable commit whose subject is exactly `update(docs): auto` as the baseline.

Review every relevant commit and diff from that checkpoint to `HEAD`.

If no such commit exists, stop and report that a manual bootstrap `update(docs): auto` commit is required before this workflow can be used.

Commit subjects in the reviewed range are hints, not truth. Verify against the actual diff and current code.

---

## Allowed Documentation Operations

You have full control over the maintained documentation when needed to keep it accurate and well structured. You may:

- update existing docs
- create new docs
- rename docs
- merge docs
- split docs
- delete stale docs
- reorganize documentation structure

Prefer extending an existing doc when the topic already fits there cleanly. Create a new file when a new topic deserves its own home or when the current structure has become awkward or misleading.

---

## When A Change Is Justified

A documentation change is justified when at least one of these is true:

- a current statement is now false
- a current statement is now stale
- a current statement is incomplete in a way that matters
- a current statement is misleading
- a new feature, system, or major behavior exists and important coverage is missing
- current names, file paths, config ownership, module ownership, or key helper or system names mentioned by docs are outdated
- the current documentation structure no longer matches the current system structure

Refactors matter when they change what the docs need to say to stay accurate, or when the old documentation structure no longer explains the current system well.

Renames matter when docs mention the old names.

---

## When To Do Nothing

Prefer no change over speculative change.

Do not rewrite docs just to polish wording, restyle prose, or churn structure without a concrete accuracy or coverage reason.

If the maintained documentation already reflects the current truth well enough, make no edits and do not create a commit.

---

## Required Reason Per File

Before changing, creating, renaming, merging, splitting, or deleting a maintained doc file, be able to answer:

- What changed since the last `update(docs): auto`?
- What is outdated, missing, or misleading in the current maintained docs?
- Why is this file the right place to update, or why is a new file, rename, merge, split, or deletion the best choice?

If you cannot answer those questions clearly, leave that file alone.

---

## Workflow

1. Read `docs-ai/documentation-guide.md`.
2. Determine the maintained documentation scope from that guide.
3. Find the most recent reachable commit whose subject is exactly `update(docs): auto`.
4. If none exists, stop and report that manual bootstrap is required.
5. Review the commits and diffs from that checkpoint to `HEAD`.
6. Read the relevant maintained docs and the current code needed to verify the changes.
7. Update the maintained documentation so it best reflects the current truth.
8. If no meaningful documentation changes are needed, stop with a no-op and do not commit.
9. If documentation changes are made, stage only the documentation files touched by this workflow and commit them as `update(docs): auto`.

Do not revert or modify unrelated worktree changes during this workflow.

---

## Commit Rule

If this workflow changes documentation, create one commit with subject exactly `update(docs): auto`.

Only include documentation files changed by this workflow in that commit.

If the result is a no-op, do not create an empty commit.

---

## Suggested Result Report

When finished, report:

- last checkpoint commit
- reviewed range
- maintained docs changed, or `none`
- one short reason per changed file
- result: `no-op` or `committed update(docs): auto`

---

## Core Instruction

Update the documentation files covered by `docs-ai/documentation-guide.md` when code since the last `update(docs): auto` made the current docs inaccurate, incomplete, stale, misleading, or missing important coverage for new features or systems. Prefer the documentation structure that best explains the current codebase, even if that means rewriting, creating, renaming, merging, splitting, or deleting docs. If no meaningful documentation change is needed, do nothing.
