#!/usr/bin/env bash
# preToolUse hook for pr-helper.
# Reads the tool-call payload from stdin and refuses dangerous force-pushes
# to the main/master branch. Emits a JSON permission decision on stdout.

set -euo pipefail

payload="$(cat)"

# Extract the bash command being attempted. The exact JSON path is
# documented in the Copilot CLI hooks reference; we read a few common
# fallbacks so the hook stays robust if the schema evolves.
command_str="$(printf '%s' "$payload" | jq -r '
  .toolArgs.command
  // .tool_input.command
  // .input.command
  // ""
')"

if [[ -z "$command_str" ]]; then
  # Nothing actionable — let the call through.
  printf '{"permissionDecision":"allow"}\n'
  exit 0
fi

# Match: `git push ... --force` (or --force-with-lease / -f) targeting main/master.
if printf '%s' "$command_str" | grep -Eq 'git[[:space:]]+push([[:space:]]+[^[:space:]]+)*[[:space:]]+(-f|--force(-with-lease)?)([[:space:]]+|$)' \
  && printf '%s' "$command_str" | grep -Eq '(^|[[:space:]])(origin[[:space:]]+)?(main|master)([[:space:]]|$)'; then
  jq -n --arg cmd "$command_str" '{
    permissionDecision: "deny",
    permissionDecisionReason: ("pr-helper: force-push to main/master blocked. Attempted: " + $cmd)
  }'
  exit 0
fi

printf '{"permissionDecision":"allow"}\n'
