---
name: secret-scan
description: Scan the working tree for hard-coded secrets (API keys, tokens, private keys, passwords). Use when the user asks for a security check before committing, before pushing, or when reviewing a PR.
license: MIT
---

# Secret Scan

Grep the working tree for common secret patterns and report what was found, where, and how to remediate.

## Steps

1. **Build the file list.** Use `git ls-files` so untracked files and ignored paths are excluded automatically. Fall back to `find` only if not inside a git repo.
2. **Run the scan.** Use `grep -nE` with the following patterns (case-insensitive where appropriate):

   | Pattern                                                  | Why                                         |
   | -------------------------------------------------------- | ------------------------------------------- |
   | `AKIA[0-9A-Z]{16}`                                       | AWS access key ID                           |
   | `aws_secret_access_key\s*=\s*[A-Za-z0-9/+=]{40}`         | AWS secret access key                       |
   | `gh[pousr]_[A-Za-z0-9]{36,}`                             | GitHub personal access / fine-grained token |
   | `xox[abprs]-[A-Za-z0-9-]{10,}`                           | Slack token                                 |
   | `-----BEGIN [A-Z ]*PRIVATE KEY-----`                     | Private key block                           |
   | `(api[_-]?key|secret|password|passwd|pwd)\s*[:=]\s*["'][^"']{8,}["']` | Generic key-like literal     |

3. **Filter false positives.** Skip files under `node_modules/`, `vendor/`, `.git/`, lockfiles (`*.lock`, `package-lock.json`), and minified bundles (`*.min.js`).
4. **Report findings** in this format:

   ```markdown
   ## Secret scan — <N> potential finding(s)

   - `path/to/file.ext:line` — <which pattern matched> — preview: `...`
   ```

   Show at most ~120 characters of context per match. Never echo the full secret in the output — mask the middle (`abcd…wxyz`).

5. If nothing is found, output a single line: *"Secret scan: no findings."*.

## Hard rules

- This is a **detector**, not a fixer. Never delete or rewrite a file.
- Always mask matched secrets in the output (preserve the first 4 and last 4 characters only).
- Mention that this scan is heuristic — recommend `gitleaks` or `trufflehog` for thorough analysis.
