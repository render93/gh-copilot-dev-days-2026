#!/usr/bin/env bash
# userPromptSubmitted hook for pr-helper.
# Injects the current git branch (and a hint about ahead/behind status)
# as additional context for the model.

set -euo pipefail

branch="$(git branch --show-current 2>/dev/null || true)"

if [[ -z "$branch" ]]; then
  printf '{"additionalContext":"pr-helper: not inside a git repository — branch context unavailable."}\n'
  exit 0
fi

upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"

if [[ -n "$upstream" ]]; then
  ahead_behind="$(git rev-list --left-right --count "$upstream"...HEAD 2>/dev/null || echo "0	0")"
  behind="$(printf '%s' "$ahead_behind" | awk '{print $1}')"
  ahead="$(printf '%s' "$ahead_behind" | awk '{print $2}')"
  msg="pr-helper: current branch is '$branch' (upstream: $upstream, ahead $ahead / behind $behind)."
else
  msg="pr-helper: current branch is '$branch' (no upstream configured)."
fi

jq -n --arg msg "$msg" '{additionalContext: $msg}'
