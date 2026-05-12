---
name: pr-description
description: Generate a Markdown pull-request description from the current branch's commits and diff against the default branch. Use when the user asks to draft a PR body, prepare to open a PR, or fill in a PR template.
license: MIT
---

# PR Description Generator

Draft a Markdown pull-request description from the current branch.

## Inputs to collect

1. Default branch:
   ```bash
   git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null \
     | sed 's@^refs/remotes/origin/@@' \
     || echo main
   ```
2. Current branch: `git branch --show-current`.
3. Commits ahead of default: `git log --oneline <default>..HEAD`.
4. Diff stats: `git diff --stat <default>..HEAD`.

If any of the above fails (e.g. no remote tracking, detached HEAD), stop and tell the user what is missing.

## Output template

```markdown
## Summary
<1-3 sentences explaining what changed and why>

## Changes
- <bullet per logical change, grouped by area when useful>

## Test plan
- [ ] <how to verify the change manually>
- [ ] <automated test added / updated>

## Notes
<optional: migrations, env vars, follow-ups, links to issues>
```

## Rules

- Derive each bullet under **Changes** from the actual commits or diff stats — do not invent.
- The **Test plan** section is mandatory; if no tests were added, write a manual verification checklist instead.
- If the branch has a single commit, use the commit body as a starting point for the summary, then tighten it.
- Wrap each line at 100 columns; do not output extra trailing whitespace.
