# pr-helper

A Copilot CLI plugin that streamlines pull-request workflows.

## What's inside

### Skills

- **`summarize-diff`** — turn the working-tree diff into a concise bullet summary.
- **`pr-description`** — generate a Markdown PR description from diff and commit log.
- **`changelog-entry`** — append a Conventional Commits entry to `CHANGELOG.md`.

### Custom agent

- **`pr-reviewer`** (model: `claude-sonnet-4-6`) — a senior reviewer focused on security, correctness, and readability. User-invocable.

### MCP server

- **`github`** — the official GitHub MCP server (`ghcr.io/github/github-mcp-server`, Docker). Surfaces issues, PRs, files, and search across repositories.

### Hooks

- **`preToolUse`** on `bash` → `scripts/block-force-push.sh` rejects `git push --force` / `--force-with-lease` targeted at `main` or `master`.
- **`userPromptSubmitted`** → `scripts/inject-branch-context.sh` injects the current branch name as additional model context on every prompt.

## Demo usage

```bash
# After installing the plugin:
copilot

# Inside the session — explicit skill invocation:
/summarize-diff
/pr-description
/changelog-entry feat "add plugin marketplace demo"

# Custom agent:
/agent pr-reviewer
"Review the staged changes for security issues."
```

## Prerequisites for the live demo

- **Docker** running (the GitHub MCP server is a container).
- A `GITHUB_TOKEN` env var with at least `repo` scope.
- Pre-pull the image to avoid a cold start mid-talk:
  ```bash
  docker pull ghcr.io/github/github-mcp-server
  ```

## How to show each hook to the audience

- **`preToolUse` block** — ask Copilot: *"Run `git push --force origin main`"*. The hook returns a `deny` decision and the audience sees Copilot refuse to execute the command.
- **`userPromptSubmitted` context** — ask Copilot: *"What branch am I on?"*. The agent answers using the branch name the hook injected via `additionalContext`.
