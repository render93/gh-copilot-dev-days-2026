# story-crafter

A Copilot plugin for writing development-ready user stories.

## What's inside

### Custom agent

- **`user-story-writer`** (model: `claude-sonnet-4-6`) — a Product Management agent that writes user stories in Mike Cohn format (`As a / I want to / so that`) with Gherkin acceptance criteria. Opinionated about quality: it flags anti-patterns and proposes fixes rather than silently accepting bad input. User-invocable.

## How to use

```bash
# After installing the plugin:
copilot

# Write a new story from a raw need:
/agent user-story-writer
"We need to let enterprise admins bulk-invite team members via CSV upload."

# Refine an existing draft:
/agent user-story-writer
"As a user, I want a faster dashboard."
```
