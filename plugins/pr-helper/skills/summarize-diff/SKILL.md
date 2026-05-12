---
name: summarize-diff
description: Summarize the working-tree or staged git diff as a short bullet list grouped by file. Use when the user asks "what changed?", "summarize my changes", or before opening a PR.
license: MIT
---

# Summarize Diff

Produce a terse bullet-point summary of the current git diff so the user can quickly review what is about to be committed or pushed.

## Steps

1. Detect what to summarize:
   - If there are staged changes (`git diff --cached --name-only` is non-empty), summarize the staged diff.
   - Otherwise, summarize the working-tree diff (`git diff`).
   - If both are empty, report *"No changes to summarize."* and stop.
2. List affected files with `git diff --name-status` (or `--cached --name-status`).
3. For each file, read the diff with `git diff <path>` (or `--cached`) and write **1-3 bullets** describing the substantive change. Skip whitespace-only changes.
4. Render the output as:

   ```
   ## Diff summary (<N> files)

   ### path/to/file.ext  (M/A/D/R)
   - <change 1>
   - <change 2>
   ```

## Constraints

- Never invent changes — every bullet must be grounded in lines from the actual diff.
- Do not include the raw diff in the output.
- Keep each bullet under ~120 characters.
- If a file is binary, write *"binary file — not summarized"*.
