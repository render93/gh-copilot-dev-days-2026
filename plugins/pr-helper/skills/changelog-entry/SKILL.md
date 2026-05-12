---
name: changelog-entry
description: Append a Conventional Commits entry to CHANGELOG.md under the Unreleased section. Use when the user says "add a changelog entry", "log this change", or before tagging a release.
license: MIT
---

# Changelog Entry

Append a Conventional Commits entry to `CHANGELOG.md`.

## Arguments

The skill expects two arguments from the user prompt:

- **`type`** — one of: `feat`, `fix`, `chore`, `docs`, `refactor`, `perf`, `test`, `build`, `ci`.
- **`subject`** — short imperative phrase (e.g. *"add plugin marketplace demo"*).

If either argument is missing, ask the user to provide it. Do not guess.

## Steps

1. If `CHANGELOG.md` does not exist, create one with this skeleton:

   ```markdown
   # Changelog

   All notable changes to this project will be documented in this file.

   The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
   and this project adheres to [Conventional Commits](https://www.conventionalcommits.org).

   ## [Unreleased]

   ```

2. Locate the `## [Unreleased]` heading. If absent, insert it directly under the intro block.
3. Insert a new entry under `## [Unreleased]`:

   ```
   - **<type>:** <subject>
   ```

4. Preserve any existing entries — append after them, alphabetically by type, then chronologically.

## Hard rules

- Never rewrite or reorder existing entries.
- Never invent the `type` or `subject` — both must come from the user.
- After editing, output a single line confirming: *"Added: `<type>: <subject>` to CHANGELOG.md"*.
