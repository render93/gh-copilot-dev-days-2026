# Github Copilot Dev Days 2026 Napoli — Tailoring GitHub Copilot

Demo marketplace for the **GitHub Copilot Dev Days 2026 Napoli**.

It bundles two showcase plugins, each exercising the four extensibility primitives of Copilot CLI:

| Plugin         | Skills | Agent          | MCP server  | Hooks                                            |
| -------------- | ------ | -------------- | ----------- | ------------------------------------------------ |
| `pr-helper`    | 3      | `pr-reviewer`  | `github`    | `preToolUse`, `userPromptSubmitted`              |
| `dev-guardian` | 3      | `test-writer`  | `filesystem`| `postToolUse`, `sessionStart`                    |

## Installation steps

Fork this repository to your own GitHub account and follow the instructions below.

> **Note**: Copilot CLI and Copilot Chat keep separate plugin registries. Installing a plugin in one of them does not make it available in the other: if you want to use the same plugin from both, follow the installation steps in each section below.

<details>
<summary><strong>Copilot CLI</strong></summary>
 
### Prerequisites
 
- [GitHub Copilot CLI](https://docs.github.com/en/copilot/how-tos/copilot-cli) installed and authenticated
- Git configured with credentials for this Azure DevOps organization
 
### Add this marketplace
 
```shell
copilot plugin marketplace add <marketplace-url>
# Example:
copilot plugin marketplace add https://github.com/render93/gh-copilot-dev-days-2026.git
```
 
### List available plugins
 
```shell
copilot plugin marketplace browse <marketplace-name>
# Example:
copilot plugin marketplace browse dev-days-2026-marketplace
```
 
### Install a plugin
 
```shell
copilot plugin install <plugin-name>@dev-days-2026-marketplace
# Example:
copilot plugin install pr-helper@dev-days-2026-marketplace
```
 
### Use agents and skills from a plugin
 
Once a plugin is installed, the agents and skills it ships are available in any interactive `copilot` session.
 
**Agents**: run `/agent` to pick one from the list of installed agents
You can also mention the agent by name in a natural-language prompt (e.g. *"use the pr-reviewer agent to ..."*).
 
**Skills**: skills from a plugin are exposed as namespaced slash commands using the plugin name as a prefix. Type `/` in the prompt to discover them, or invoke directly:
 
```text
/pr-helper:summarize-diff
```
 
Use `/skills list` to inspect what is currently loaded. Skills whose description matches your request can also be triggered automatically by Copilot.
 
### Update plugins
 
```shell
copilot plugin marketplace update <marketplace-name>
copilot plugin update <plugin-name>
```
 
</details>
 
<details>
<summary><strong>Copilot Chat</strong></summary>
 
### Prerequisites
 
- VS Code with the [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) and [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat) extensions installed.
- Signed in to GitHub in VS Code with an account that has access to this Azure DevOps organization.
 
### Add this marketplace

Open VS Code user settings (`Ctrl+,` => "Open Settings (JSON)") and add the marketplace URL to the `chat.plugins.marketplaces` array:
 
```json
{
  "chat.plugins.marketplaces": [
    "github/copilot-plugins",
    "github/awesome-copilot",
    "<marketplace-url>"
  ]
}
```
 
You can jump straight to this setting via `vscode://settings/chat.plugins.marketplaces`:
 
![VS Code settings for chat plugins](img/image.png)
Reload VS Code for the change to take effect.
 
### List available plugins
 
Open a Copilot Chat session and type:
 
```text
/plugins
```
 
The plugin picker opens listing every plugin available from the registered marketplaces. Type `dev-days-2026-marketplace` in the search bar at the top to filter the list to plugins published by this marketplace.
 
### Install a plugin
 
From the filtered list in the plugin picker, select the plugin you want and install it.
 
### Use agents and skills from a plugin
 
Once the plugin is installed, its agents and skills become available in the Copilot Chat input.
 
**Agents**: open the agents dropdown in the chat view. The active agent is shown in the chat header.
 
**Skills**: skills from a plugin are exposed as namespaced slash commands using the plugin name as a prefix. Type `/` in the chat input to see the available ones, or invoke directly and append extra context after the command:
 
```text
/pr-helper:summarize-diff
```
 
Skills whose description matches your request can also be loaded automatically by Copilot, unless the plugin author marked them as manual-invocation only.
 
### Update plugins
 
VS Code refreshes installed plugins together with extensions. Open the Command Palette (`Ctrl+Shift+P`) and run:
 
```text
Extensions: Check for Extensions Updates
```
 
Any newer plugin versions published in this marketplace will be picked up. Reload VS Code if prompted.
 
### Known limitation
 
Skills defined in a plugin are currently only invoked by the top-level agent. When the agent delegates to a subagent, the subagent does not have access to skill context. Tracked in [vscode#305994](https://github.com/microsoft/vscode/issues/305994).
 
</details>

## What each plugin demonstrates

- **`pr-helper`** — workflow-centric: shows skills that operate on `git diff`, a custom agent that performs code review, an MCP server that surfaces issues and pull requests, and hooks that *block dangerous git operations* and *inject branch context* on every prompt.
- **`dev-guardian`** — safety/quality-centric: shows skills for error triage and test scaffolding, a fast Haiku-powered agent for writing unit tests, an MCP server for scoped filesystem access, and hooks that *audit every edit* and *announce the session* to the model.

Read each plugin's README for usage details and demo tips.

## References

- [Creating a plugin marketplace](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/plugins-marketplace)
- [CLI plugin reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-plugin-reference)
- [CLI hooks reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-hooks-reference)
