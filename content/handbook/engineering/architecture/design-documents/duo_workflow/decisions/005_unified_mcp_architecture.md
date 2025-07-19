---
title: "Duo Workflow ADR 005: Unify Model Context Protocol intergration for Duo Workflow"
owning-stage: "~devops::ai_powered"
toc_hide: true
---

## Context

The Duo Workflow Service is Gitlab owned AI powered agentic platform providing LLM backed automation of various DevSecOps lifcycle related processed. At the current moment Duo Workflow highlevel architecture consists of following participants as shown in this design doument [diagram](../_index.md#gitlabcom-architecture):
1. Duo Workflow Service - built with Python, LangGraph based orchestration platform for multi-step LLM interactions
1. Duo Workflow Executor -  twin clients built with TypeScript and GO, that provides integration into external world for an AI agents operating at Duo Workflow Service. Executors both supply additional context information on AI agents demand, as well as takes actions on their behalf (eg: reading and writing files on local file system). Executors can be spawned either on a local user machine, or on a CI runner virtual machine.
1. LSP (Language Server) - GitLab Language Server integrating Duo Workflow Executor (among other features) into IDEs

The [Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) that defines a standardized way of integrating LLMs with external environment. Since its announcement plethora of official [MCP servers](https://github.com/modelcontextprotocol/servers?tab=readme-ov-file#%EF%B8%8F-official-integrations) has been built, which offer broad range of available intergration that AI agents can harness to increase their functionalities. Understanding improtance of MCP Duo Workflow engineers has already started pilot implementaitons ([1](https://gitlab.com/gitlab-org/gitlab/-/issues/519938), [2](https://gitlab.com/gitlab-org/editor-extensions/gitlab-lsp/-/merge_requests/1764/), [3](https://gitlab.com/gitlab-org/modelops/applied-ml/code-suggestions/ai-assist/-/merge_requests/2611/)) for integration of MCP support with Duo Workflow platform.

## Promblem

Due to the fact that Duo Workflow has been designed and built prior to introcuditon of MCP, it core integrations (including GitLab API, local filesystem, and terminal access) do not follow MCP protocol, creating disparity between GitLab owned Duo Workflow integrations, and external MCP servers. This situation increase complexity of resulting system, causing higher maintainance burden, and increase risk of defects.

## Proposal

Convert GitLab owned Duo Workflow integrations built into Executors into MCP servers that can be connected to Executors in the same way as the external MCP servers. This change should unify  Duo Workflow integrations fully with the domain standard for LLMs integrations.

![MCP servers integration](/images/engineering/architecture/design-documents/duo_workflow/diagrams/duo-workflow-mcp-integration-highlvel-diagram.png)

[PoC: Self contained tools as GitLab maintained MCP Servers](https://gitlab.com/gitlab-org/editor-extensions/gitlab-lsp/-/merge_requests/1786)


### Implementation


Tools that integrates with environment external to Duo Workflow service should being implemented as stand alone MCP servers.
Those MCP servers can group different tools into packages when it is reasonbale and practical, for example: all tools that interact with a local file system could be 
implemented as a single _file system_ MCP Server.

#### Permissions and approval system

##### The current tools approval system

1. Developers assigning requested tools to agents during a graph implementation via `Toolset`s
2. Users define available tools buckets via agent privileges
3. Users defnie pre approved tools buckets via pre approved agent privileges
4. Workflow at runtime intersect sets of tools that are being defined by agent privileges with requested agent's `Toolset`s to constitue resulting `Toolset`
5. The resulting `Toolset` is being split between pre approved tools allow list, and all other tools
6. Tools from pre approved allowlist are being skipped when resolving tool approval requirements
7. Tools that are NOT included in allowlist trigger tools approval subworkflow before their execution


##### The new MCP approval system

In order to integrate MCP Servers into the current tool approval system, which batch tools into buckets and grants users ability to enforce approval, or even fully disable some tools for thier workflows,
MCP Servers will be treated as stand alone tool buckets, that users could gate with approvals, or disable at will.

Following that approach each MCP Server will constitute an agent privilege eg: `GitLab Epics MCP Server` would have corresponding `giltab_epics` agent privilege.
In the new MCP based approach workflow admins will enable and pre approve MCPs rather then a tool buckets.

In addition [`message McpTool`](https://gitlab.com/gitlab-org/modelops/applied-ml/code-suggestions/ai-assist/-/blob/94e861a26c6209970a1337111814ba105d58ec03/contract/contract.proto#L147) protobuff contract should
include new field `server_id` that is going to identify owning MCP Server, and tie each tool with corresponding approval rule.

Furthermore Group and Project Admins will be given new settings page to configure MCPs approvals permissions, that is going to stored inside a new table `duo_workflow_mcps` in GitLab Rails PostgreSQL DB.
In order to extend MCPs support beyong GitLab owned MCPs, Admins will be allowed to _install_ custom MCPs for their groups (and projects). Installation of a new MCP will result in
a new record being added to `duo_workflow_mpcs` table. Furthermore in case of custom MCPs, Admins should be able to _uninstall_ an MCP. That capability won't be allowed for GitLab MCPs, which could only be disabled.

**Tool level approvals**

In situations when current bucket based approval system is too broad, forcing Admins to either pre approve tools that they won't be fully comfortable with, or hindering productivity with excessive approvals for tools that are being considered safe to use, it should be possible to suplement the current approach with a per tool based extension. MCP protocol define [tools discovery API](https://modelcontextprotocol.io/docs/concepts/tools#tool-discovery-and-updates) wich is used by MCP clients discover available tools, by pluggin into this API GitLab could extract list of available tools from each of installed MCP servers.
That tools list then should be presnted to Admins as a drill down option of general high level MCP approval settings section.

#### Delivery and packaging

GitLab owned MCP Servers should be vendored along with Duo Workflow executors assuring compatibility, as well as reducing pontential friction related to 
donwloading and managing muplitple dependencies on a client side, on top of that MCPs vendoring should also help with service discovery process described in a [following section](#mcp-discovery) of this document.

In order to vendor GitLab ownded MCPs each ot the MCP Servers will be created as a stand alone repository under a single MCP dedicated group.
Every repository then will be published to GitLab's package [registry via CI/CD pipeline](https://docs.gitlab.com/user/packages/npm_registry/#publish-a-package-with-a-cicd-pipeline).

The executors will manage GitLab MCP Servers via dedicated package managers (eg: `npm` or `pip`), and will have dedicated configuration files eg: `package.json` to controll
which version of GitLab MCP Servers are being vendored with.

#### MCP Discovery

Each GitLab owned MCP Server repository should include `mcp.json` file, with a default configuration for an MCP Server (see an [example `mcp.json`](https://gitlab.com/gitlab-org/editor-extensions/gitlab-lsp/-/merge_requests/1786/diffs#721cf765f17ef4b992af1cf791d1b9bc69077d7f_0_4)).
```json
{
  "mcpServers": {
    "simple-file-server": {
      "command": "npx",
      "args": ["/gitlab/gitlab-lsp/vendor/duo_workflow_mcps/duo-workflow-test-project"],
      "description": "Simple MCP server for reading local files",
    }
  }
}
```

During packaging process of each executor GitLab MCP Servers will be donwladed and vendored. Upon an executor start up a `/vendor/gitlab/mcps` directory will be
scanned in search of `mcp.json` files for each available MCP Server, which will be combined together forming a config for complete set of GitLab maintained Duo Workflow MCP Servers

See [discovery procedure built in the PoC](https://gitlab.com/gitlab-org/editor-extensions/gitlab-lsp/-/merge_requests/1786/diffs#57c558b2fab1dbef0f543cdb809aaaa183e0e8f9_26_156)

## Decision

All new tools should be implemented as part of a GitLab owned MCP server. 
The currently existing tools implemented as part of executors, should be deprecated and their development should be frozeen,
they may remain in use as long as there won't be any change required. If a change to a tool implmented by executors will be required,
that tool should be moved into a GitLab owned MCP server.

In addition there should be a new group created under https://gitlab.com/gitlab-org/duo-workflow to house all GitLab owned MCPs
As well as automation like [renovate bot](https://gitlab.com/gitlab-org/frontend/renovate-gitlab-bot) should be configured to automatically 
propage MCP servers releases to dependant repositories.

## Consequences

- **Pros**
  - Tools implementation is encapsulated to a single repository including tool interface definition, description, and tool implementation, reducing burden related with cross system coordination, or reimplementing tools for each supported client
  - Opportunity to streamline and open up development of Duo Workflow integrations
  - Standardized communication architecture for all available integrations  
  - Standardized permissions and approval patterns for all integrations
  - Simplified interoperabitlity of GitLab owned integrations across different execution environment including CI runners, and various IDEs
  - Opportunity to expose some of GitLab owned integrations (eg: GitLab API) as official GitLab MCP servers
  - Ability to versions tools
  - Improved backwards compatibility

- **Cons**  
  - A risk of overindexing on a new protocol, that might be subjected to changes, or might get superseded in the future
  - Negative impact on executor start up time caused by added overhead related to launch of broad set of MCP servers
    

## Open questions:

1. Which programimng languages should be supported for GitLab maintained MCP Servers? At the current moment available [SDKs](https://modelcontextprotocol.io/introduction) include: Python, TypeScript, Java, Kotlin, C#, Swift and Ruby
1. What will be the impact of starting up multiple MCP servers on workflows time to first response, should some warmup procedure be considered?