# dev-guardian

A Copilot CLI plugin that adds lightweight quality and safety guardrails to a developer session.

## What's inside

### Skills

- **`explain-error`** — parse a stack trace or error message, explain the root cause, and propose a fix.
- **`add-test`** — scaffold an AAA-style unit test for a given function or file.
- **`secret-scan`** — grep the working tree for hard-coded secrets (API keys, tokens, private keys).

### Custom agent

- **`test-writer`** (model: `claude-haiku-4-5`) — fast and cheap agent specialised in writing focused unit tests.

### MCP server

- **`filesystem`** — the official `@modelcontextprotocol/server-filesystem`, scoped to `${HOME}/Documents` for safe demo access.

### Hooks

- **`postToolUse`** on `edit` / `write` / `str_replace_editor` → `scripts/log-edit.sh` appends a line to `.dev-guardian.log` in the session's working directory.
- **`sessionStart`** → `scripts/session-banner.sh` injects a banner so the model is aware the plugin is active.

## Demo usage

```bash
# After installing the plugin:
copilot

# Inside the session — explicit skill invocation:
/explain-error "TypeError: Cannot read properties of undefined (reading 'name')"
/add-test src/utils/format.ts
/secret-scan

# Custom agent:
/agent test-writer
"Write unit tests for the parseQuery function in src/lib/query.ts."
```

## Prerequisites for the live demo

- Node.js available on PATH (the filesystem MCP runs via `npx`).
- Pre-cache the MCP server to avoid a cold start mid-talk:
  ```bash
  npx -y @modelcontextprotocol/server-filesystem --help
  ```

## How to show each hook to the audience

- **`sessionStart` banner** — right after entering the session, ask: *"Which plugins are active in this session?"*. The model will cite the banner content (it was injected as `additionalContext`).
- **`postToolUse` audit** — ask Copilot to edit any file (e.g. *"add a comment to README.md"*), then run `cat .dev-guardian.log` outside the session. The new entry appears.

## Notes

- The `.dev-guardian.log` file lives in the current working directory of the session — add it to `.gitignore` if you don't want to commit demo runs.
