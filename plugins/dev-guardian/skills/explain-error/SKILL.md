---
name: explain-error
description: Explain a stack trace or error message in plain language and propose a concrete fix. Use when the user pastes an error, asks "what does this mean?", or asks "why does this fail?".
license: MIT
---

# Explain Error

Turn an error message or stack trace into a plain-language explanation plus a concrete next step.

## Steps

1. **Classify the error.**
   - Language / runtime (e.g. Node.js, Python, .NET, Go).
   - Category: type error, null/undefined access, IO/network, permissions, syntax, dependency.
2. **Locate the failing frame.** Read the topmost user frame from the stack (skip framework frames). Use `read` to open the file at that line and inspect surrounding code.
3. **Explain.** Write 2-4 sentences explaining what the runtime was trying to do and why it failed. Avoid jargon when a simpler word will do.
4. **Propose a fix.** Suggest the smallest change that addresses the root cause. If multiple fixes are reasonable, pick one and mention the alternative in a single line.

## Output format

```markdown
## What went wrong
<plain-language explanation>

## Where
`path/to/file.ext:line` — <one-line description of the failing code>

## Suggested fix
<concrete change, one sentence + optional 3-5 line code snippet>

## Alternative
<optional: one-line mention of a different approach>
```

## Hard rules

- Never speculate beyond what the trace shows. If the trace is truncated, say so.
- Never apply the fix automatically — only suggest. Editing is out of scope for this skill.
- If the input does not look like an error or trace, ask the user for clarification.
