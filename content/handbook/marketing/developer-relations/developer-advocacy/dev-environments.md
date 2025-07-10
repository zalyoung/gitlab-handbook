---
title: Development Environments for Developer Advocates
---

Developer Advocates work with different types of platforms, editors and IDEs, including AI-native workflows. This page compiles best practices and useful tips to help optimize developer advocacy-related setups.

## IDEs

Developer Advocates can use different IDEs depending on their projects and content requirements. It is key to understand the IDE capabilities and use cases, put them into focus for content requests, and diversify usage for different audiences.

### AI and GitLab Duo in IDEs

GitLab Duo and the GitLab Duo Agent Platform are integrated as [IDE extensions/plugins](https://docs.gitlab.com/editor_extensions/#available-extensions).

### Visual Studio Code

Visual Studio Code (short: VS Code) supports a variety of programming languages and development tool integrations through its marketplace.

GitLab Duo can be integrated through the [GitLab Workflow extension in the VS Code marketplace](https://docs.gitlab.com/editor_extensions/visual_studio_code/).

> **Note**
>
> Review the [internal guide for Dev Environments](https://internal.gitlab.com/handbook/marketing/developer-relations/developer-advocacy/dev-environments/) after completing the initial setup.

#### Tips and best practices for VS Code

1. Learn and practice frequently used [keyboard shortcuts for VS Code](https://code.visualstudio.com/docs/configure/keybindings).
    - Command palette: `cmd shift p` on macOS or `ctrl shift p` on Windows/Linux.
    - Settings: `cmd ,` on macOS or `ctrl ,` on Windows/Linux.
    - Tip: You can also ask [GitLab Duo Chat](https://docs.gitlab.com/user/gitlab_duo_chat/examples/), or [Claude](/handbook/tools-and-tips/ai/claude/) for help.
1. Enable auto-save while editing. This avoids data loss or missing Git commit data when writing your code.
   - UI: Open the settings by clicking the gear icon in the bottom left corner (shortcut: `cmd ,` on macOS). Search for `auto save`.
   - VS Code `settings.json`: Add a new key/value for `"files.autoSave": "afterDelay"`.
1. Enable word-wrap by default. This makes long lines readable without horizontal scrolling.
   - UI: Open the settings by clicking the gear icon in the bottom left corner (shortcut: `cmd ,` on macOS). Search for `word wrap`.
   - VS Code `settings.json`: Add a new key/value for `"editor.wordWrap": "on"`.
1. Install extensions you need regularly, and only use trusted sources.
   - Review the maintained list in [@dnsmichi's dotfiles project](https://gitlab.com/dnsmichi/dotfiles/-/blob/main/vscode-extensions-install.sh?ref_type=heads)
   - You can install extensions on the CLI with `code --install-extension`. Example `code --install-extension gitlab.gitlab-workflow`.
1. Open local Git repositories or directories using the `code .` shortcut from the terminal. This simplifies the workflow of editing/debugging code when you need to switch contexts between GitLab UI, VS Code and terminal.
1. Open a terminal in VS Code (shortcut: `cmd j` on macOS, or `cmd shift p` and search for `terminal`). This allows starting background tasks like running servers, compilers, Ansible playbooks, etc. while editing code and avoids context switching between different windows.

#### Move Chat to the right panel

By default, the Chat panel is on the left side of the VS Code UI. This might interfere with file trees in the explorer, Git commits, which are also located on the left.

In order to move the Chat to the right sidebar:

1. Open the Secondary Side bar with the icon on upper right corner.
1. Drag the Chat icon (for example, Duo Chat) and drop it to the right sidebar.
1. You can use multiple chat panels in parallel.

@dnsmichi uses this setup by default.

#### Enable additional languages for GitLab Duo Code Suggestions

1. Choose between two paths:
   - UI: Open the settings by clicking the gear icon in the bottom left corner. Search for `gitlab.duoCodeSuggestions`.
   - VS Code `settings.json`: Press `cmd shift p` on macOS to open the command palette, and search for `settings.json`. Add/Modify the entry for `"gitlab.duoCodeSuggestions.additionalLanguages"` with an array of strings as value.
1. Add `markdown` to the array when you want to see more code suggestions when editing your `README.md` file.
   - @dnsmichi is confident with the quality and the relevance of the following languages in `settings.json` (development test cycle: 1 year+):

    ```json
    {
        "gitlab.duoCodeSuggestions.additionalLanguages": [
            "powershell",
            "yaml",
            "ansible",
            "perl",
            "dockerfile",
            "markdown",
            "json"
        ],
    }
    ```

1. It is important for Code Suggestions to have proper context: Open more tabs that are relevant to your current task, as those will be used for [context](https://docs.gitlab.com/user/project/repository/code_suggestions/#the-context-code-suggestions-is-aware-of).

A full VS Code `settings.json` example is located in [@dnsmichi's dotfiles project](https://gitlab.com/dnsmichi/dotfiles/-/blob/main/vscode/settings.json?ref_type=heads).

### JetBrains IDEs

Developer Advocates can access [JetBrains IDEs](/handbook/tools-and-tips/editors-and-ides/jetbrains-ides/) for different purposes and use cases:

- IntelliJ IDEA Ultimate (Java, Kotlin, Scala)
- PyCharm (Python, Django)
- GoLand (Go)
- DataGrip (SQL, Databases)
- RubyMine (Ruby, Rails)
- PhpStorm (PHP)
- WebStorm (JavaScript, TypeScript, HTML/CSS)
- Rider (C#, .NET)
- CLion (C, C++)
- Android Studio (Android development)

IntelliJ IDEA also supports plugins for other languages, the availability depends on the subscription tier (Ultimate vs Community).

GitLab Duo can be integrated using the [GitLab Duo plugin in the JetBrains marketplace](https://docs.gitlab.com/editor_extensions/jetbrains_ide/).

> **Note**
>
> Review the [internal guide for Dev Environments](https://internal.gitlab.com/handbook/marketing/developer-relations/developer-advocacy/dev-environments/) after completing the initial setup.

#### Tips and best practices for JetBrains IDEs

1. Review the [available IDE licenses](/handbook/tools-and-tips/editors-and-ides/jetbrains-ides/licenses/), and eventually create an Access Request for additional permanent IDE licenses.
1. Read the [setup and configuration guide](/handbook/tools-and-tips/editors-and-ides/jetbrains-ides/setup-and-config/) and install the [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/) to manage individual IDEs and their updates.
   - Optional tip: By default, the toolbox keeps older installed versions. If this behavior causes problems with storage consumption, disable the setting in `Tools > Keep previous versions to enable instant rollback`.
   - JetBrains IDEs can migrate/import configuration from existing setups. This is convenient to install/configure the GitLab Duo plugin once, and import it into another JetBrains IDE.

### MS Visual Studio

> Note: Needs access to a Windows and Visual Studio license, and requires additional security review.
>
> Status: Research. Todos are tracked in [this internal issue](https://gitlab.com/gitlab-com/marketing/developer-relations/developer-advocacy/developer-advocacy-meta/-/issues/712).

GitLab Duo can be integrated using the [GitLab extension in the Visual Studio marketplace](https://docs.gitlab.com/editor_extensions/visual_studio/).

> **Note**
>
> Review the [internal guide for Dev Environments](https://internal.gitlab.com/handbook/marketing/developer-relations/developer-advocacy/dev-environments/) after completing the initial setup.

### Eclipse

GitLab Duo can be integrated using the [GitLab extension in the Eclipse marketplace](https://docs.gitlab.com/editor_extensions/eclipse/).

### neovim

> Tip: Start a new neovim configuration using a fork of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) to bootstrap and optimize your neovim experience.

GitLab Duo can be integrated using a [neovim plugin](https://docs.gitlab.com/editor_extensions/neovim/).

## Remote Development Workspaces

[Workspaces](https://docs.gitlab.com/user/workspace/) offer cloud development environments, running on [Developer Relations Cloud Resources](/handbook/marketing/developer-relations/workflows-tools/cloud-resources/).

> Status: Inactive. Currently, there is no infrastructure maintainer. The following documentation exists for historical reference in the future.

The [remote-development sub group](https://gitlab.com/gitlab-da/use-cases/remote-development) has an agent for Kubernetes installed, which is documented in the [agent-kubernetes-gke](https://gitlab.com/gitlab-da/use-cases/remote-development/agent-kubernetes-gke) project. This includes troubleshooting when the agent becomes unresponsive, and workspaces are not created.

Resources:

1. The Kubernetes cluster `da-remote-development-1` needs to be running in GKE. Current resources: 3 nodes. Total 6 vCPU, 12 GB memory.
1. The domain `remote-dev.dev` has been purchased through the Google DNS service and points to the Kubernetes cluster's public IP.
1. The TLS certificates have been generated manually with Let's Encrypt and need to be renewed quarterly (2023-08-15), following the [documentation steps](https://gitlab.com/gitlab-da/use-cases/remote-development/agent-kubernetes-gke).

## Learning resources

### Team member examples

- [@dnsmichi's dotfiles project](https://gitlab.com/dnsmichi/dotfiles) which documents the work environment setup including IDEs and development tools.

### Talks and demos highlighting Dev Environments

Review the [Developer Advocacy content library](/handbook/marketing/developer-relations/developer-advocacy/content/) and the following resources:

1. Learning AI 101: Practical Foundations for Developers - 2025-06, Open Source @ Siemens
    - Slides: [public](https://dnsmichi.click/learning-ai-101-os-siemens-2025), [internal](https://docs.google.com/presentation/d/1PUCUrVzKnzc25md8gbh1jYznz-dUFfQcENvbR9xUJ7k/edit)
1. Efficient DevSecOps workflows with a little help from AI - 2024-12, GitLab DACH Roadshow FY25
    - Slides: [public](https://go.gitlab.com/JRFMG4), [internal](https://docs.google.com/presentation/d/1Pm8yT46jpcc3kY0PLZqZlG2slIiFyZiQPKFEgyqqstw/edit)
