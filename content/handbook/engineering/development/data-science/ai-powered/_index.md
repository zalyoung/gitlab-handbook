---
title: AI-Powered Stage
description: "The AI-Powered Stage in the Data Science section is focused on providing applied AI capabilties to the GitLab product."
---

## Core Focuses

### Key Priorities (in order)

1. Agentic framework and customer solutions
1. Scalability of AI throughout the SDLC
1. Enterprise-grade completeness 
1. Design System integration/component creation

### Areas of opportunity

- Experience AI features as enterprise customers do across all deployment types (self-hosted, Dedicated, .com)
- Track AI feature adoption, usage, and cost using shared instrumentation to understand maintenance burden and identify high-priority improvement areas
- Build infrastructure to proactively support 4+ quarters of anticipated feature growth
- Identify AI components not using the standard Design System and prioritize UI/UX standardization
- Establish cross-team testing protocols for enterprise-grade reliability
- Identify emerging industry tools, techniques, models, concepts and validate for application within GitLab
- [Evaluate existing E2E tests and map to defined user journeys for our domains](https://gitlab.com/groups/gitlab-com/-/epics/2513)
- Audit database headroom and forecast end of year growth
- 
- 

### User Journeys

- **Critical to Duo Chat:**
  - Developer needs to comprehend code written by others quickly without extensive manual review
  - Developer wants to troubleshoot failed pipeline jobs with root cause analysis
  - Product Manager needs to summarize lengthy issue discussions for team alignment

- **Duo Chat:**
  - Development Team Lead wants to create status updates for multiple work items efficiently
  - Developer needs to have conversations about specific files in their codebase

- **Critical to Custom Models:**
  - Administrator needs to configure self-hosted models on their self-managed GitLab environment
  - Administrator requires visibility into LLM flows for debugging, auditing, and validation purposes
  - Administrator needs to monitor and control AI usage across their organization

- **Custom Models:**
  - Enterprise customer needs to leverage Duo features in air-gapped environments
  - Administrator wants to deploy models on different platforms (vLLM, AWS Bedrock, Azure OpenAI)
  - Administrator wants to validate that customized models are performing at a high quality level

- **Critical to AI Framework:**
  - DevOps engineer needs to implement specific models (Mistral, Claude 3.5 Sonnet, OpenAI) based on performance requirements
  - Product team needs to integrate AI capabilities with minimal infrastructure concerns
  - Engineer wants to test and switch between different AI models seamlessly
  - DevOps engineer requires monitoring dashboards to track AI feature performance
  - Developer requires automated validation tools to ensure AI feature quality
  - Administrator needs high availability and scalability for AI services

- **AI Framework:**
  - System architect wants to implement regional or customer-specific gateways
  - Quality engineer needs to validate AI model performance before deployment

- **Critical to Global Search:**
  - Product team requires a Context Management Framework to enhance AI feature quality

- **Global Search:**
  - Developer needs AI services to understand user context for more relevant responses

- **Critical to Duo Workflow:**
  - Team lead wants to automate repetitive development workflows to increase productivity
  - User requires AI assistance that continuously improves based on interactions and feedback
  - Developer prefers to run AI agents in their local environment for security and control
  - Enterprise customer wants a fully managed cloud execution solution for AI workflows
  - Developer wants AI to automatically fix MR comments and failing tests

- **Duo Workflow:**
  - Developer needs intelligent agents to execute complex tasks across GitLab projects
  - Developer needs a way to assign AI agents to tasks and manage their work throughout the GitLab platform
  - DevOps engineer needs to trigger team-wide AI workflows from the GitLab UI
  - User needs to create and configure AI workflows intuitively without deep technical knowledge
  - Team member requires real-time monitoring of AI agent activities and progress
  - Compliance officer requires comprehensive audit trails for all AI-generated activities
  - Security engineer needs AI agents to resolve identified vulnerabilities

### Standards of Quality and Completeness

- Systems must meet enterprise SLA expectations for availability and performance as measured by 99.9% Error Budget
- Features should work consistently across all deployment types (SaaS, Self-hosted, Dedicated)
- All new and existing features should follow the [GitLab Design System](https://design.gitlab.com/)
- Instrumentation should be standardized for aggregation with metrics
- Removing areas of technical burden / maintenance
- Optimizing areas of high impact

## Duo

We are the driving force behind Duo, supporting features directly or through the empowerment of other teams. For a single source of truth of feature use-cases that we enable, [see this list](https://docs.gitlab.com/user/gitlab_duo/).

### AI Powered Operating Principles

[See here](https://gitlab.com/groups/gitlab-org/ai-powered/-/wikis/home/operating_principles).

## Stage Meetings

Although we have a bias for asynchronous communication, synchronous meetings are necessary and should adhere to our [communication guidelines](/handbook/communication/#video-calls).

Some regular meetings that take place for all AI teams on the shared AI-Powered Stage Calendar (Calendar ID: c_n5pdr2i2i5bjhs8aopahcjtn84@group.calendar.google.com) are:

| Frequency | Meeting               | DRI         | Possible topics                 |
|-----------|-----------------------|-------------|---------------------------------|
| Monthly   | [AI Powered Monthly](https://docs.google.com/document/d/1WrhJIMzSBkdpfpirxx10AwZyR7FYztyTXZcX3DhOUtE/edit?tab=t.0#heading=h.tw90k29p2p43)            | Michelle Gill & Roger Woo     | Roadmap review, leadership feedback, stage-wide direction & strategy |
| Weekly    | AI Management Strategy and Alignment    | Michelle Gill, Jacki Bauer, Roger Woo   | AI Powered stage-wide / Duo strategy, execution, collaboration and decision making |

## Stage Groups
