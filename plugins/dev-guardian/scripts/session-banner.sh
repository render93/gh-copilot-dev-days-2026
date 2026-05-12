#!/usr/bin/env bash
# sessionStart hook for dev-guardian.
# Injects a banner into the model context so it knows the plugin is active
# and which guardrails are armed.

set -euo pipefail

cat <<'EOF'
{"additionalContext":"dev-guardian plugin active. Armed hooks: postToolUse (edits are appended to ./dev-guardian.log) and sessionStart (this banner). Available skills: explain-error, add-test, secret-scan. Custom agent: test-writer."}
EOF
