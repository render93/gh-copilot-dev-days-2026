---
name: add-test
description: Scaffold a unit test (AAA style) for a given file or function. Use when the user asks to "add a test", "test this function", or "increase coverage for X".
license: MIT
---

# Add Test

Scaffold a single, focused unit test for the file or function the user indicates.

## Steps

1. **Identify the target.** Argument from the user is either a file path or `path:functionName`. If missing, ask.
2. **Read the source** with `read`. Note inputs, outputs, side effects, and dependencies that may need mocking.
3. **Detect the test framework**:
   - `package.json` → `jest`, `vitest`, `mocha`.
   - `pyproject.toml` / `setup.cfg` → `pytest`, `unittest`.
   - `*.csproj` → `xUnit`, `NUnit`, `MSTest`.
   - `go.mod` → standard `testing` package.
   If ambiguous, ask the user before writing.
4. **Decide the test file location.** Use the project's existing convention if one is detectable (`__tests__/`, `tests/`, sibling `*.test.ts`, `*_test.py`). Otherwise, sibling file with the framework's standard suffix.
5. **Write a single test** covering the happy path. Use the `edit` tool. Layout:

   ```
   // Arrange
   ...
   // Act
   ...
   // Assert
   ...
   ```

6. **Print a one-line confirmation** with the file path and the command to run it (e.g. `npm test -- format.test.ts`).

## Hard rules

- Write **one** test in this skill. The user can ask for more separately.
- Never modify the source under test.
- Never invent a function signature — derive it from the actual source.
- If the source is too complex to test without refactoring (e.g. hidden global state), say so and propose what the user should change first.
