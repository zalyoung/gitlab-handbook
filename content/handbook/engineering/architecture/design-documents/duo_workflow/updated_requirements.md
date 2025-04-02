---
title: "Duo Workflow Architecture Updated Requirements"
toc_hide: true
---

## Overview

This document is intended to give an overview of the updated requirements onto the Duo Workflow architecture and the context behind them.
It is based both on the learnings after building out the architecture and delivering it to private beta as well as updated plans towards future product offerings built ontop of it.
The resulting requirements can if necessary be used to drive subsequent ADRs to change the architecture to support them.

### Background Context

After building out Duo Workflow there are a few essential pieces of context that should inform future requirements:

1. In contrast to the originally envisioned architecture the Duo Workflow Service has been built out in a [separate project](https://gitlab.com/gitlab-org/duo-workflow/duo-workflow-service) rather than within the AI gateway. This was done to increase iteration velocity at the start of the project.
1. Performance in terms of speed of replies is important for Duo Workflow when it's running in the IDE.
1. When running in the IDE, tying into IDE native functionality such [as diagnostics](https://gitlab.com/gitlab-org/gitlab/-/issues/519561) can be important for Workflow.
1. Having both executor and language server running locally increases overhead for the team in development for features such as [showing git diffs](https://gitlab.com/gitlab-org/gitlab/-/issues/516956).
1. Duo Chat is supposed to use the same architecture in order to become agentic as outlined in [this epic](https://gitlab.com/groups/gitlab-org/-/epics/17182).
1. We've encountered race conditions due to [conflicting status updates](https://gitlab.com/gitlab-org/editor-extensions/gitlab-lsp/-/issues/911).
1. Customers are [encountering issues](https://gitlab.com/gitlab-org/gitlab/-/issues/527057) with the need to have HTTP/2 enabled for connecting to Duo Workflow from a local machine.
1. Custom models has been released as a feature for GitLab Duo which increases the expectation that Duo Workflow will need to support this as well.

### Open questions

1. Should we continue to use gRPC with its need for HTTP/2 even though it can create networking problems for enterprise customers?
2. Should we create a separate Executor, built into the Language-Server, to simplify development for the IDE agent and enable streaming support?
3. Should we merge Duo Workflow Service into AI gateway to simplify self-managed setup and reduce potential double work as more and more features become agentic?
4. How should state management for Duo Workflow look like in the future, considering the outlined context?
