#!/usr/bin/env bash
# postToolUse hook for dev-guardian.
# Appends a one-line audit entry to .dev-guardian.log for every edit/write
# operation. The log lives in the session's working directory.

set -euo pipefail

payload="$(cat)"

tool_name="$(printf '%s' "$payload" | jq -r '.toolName // .tool // "unknown"')"
target_path="$(printf '%s' "$payload" | jq -r '
  .toolArgs.path
  // .toolArgs.file_path
  // .tool_input.path
  // .tool_input.file_path
  // "<unknown>"
')"

timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

printf '[%s] %s %s\n' "$timestamp" "$tool_name" "$target_path" >> .dev-guardian.log

# Hook does not need to alter the flow — succeed silently.
printf '{}\n'
