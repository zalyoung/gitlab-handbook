---
title: "Product Security Unified Ingest Process (Pilot)"
description: "The Product Security Department **is piloting** a unified ingest process that will provide engineering teams with a single, clear entry point for all security-related requests. This pilot system aims to eliminate the need to understand our internal team structure and ensure requests reach the right security experts efficiently."
---

## Overview and Goal

The Product Security Department **is piloting** a unified ingest process that will provide engineering teams with a single, clear entry point for all security-related requests. This pilot system aims to eliminate the need to understand our internal team structure and ensure requests reach the right security experts efficiently.

## Pilot Approach

We're currently testing this new approach with **Infrastructure Security** (active) and **Vulnerability Management** (in the workings) teams to validate the process before broader rollout. This allows us to identify improvements and refine the system based on real-world usage.

## How the Pilot Works

### Single Entry Point Philosophy

During the pilot, participating teams are testing whether engineering teams can engage with Product Security with some minimal knowledge on which specific team and services they need.

In later phases our pilot system should handles the routing automatically based on a question/answers based input and request details. Our other project of redefining the [Security review process](https://gitlab.com/groups/gitlab-com/gl-security/product-security/appsec/-/epics/60) (Internal) will also significantly contribute into using this new engagement model.

### Providing Feedback

Your input is crucial for refining this process before broader rollout. You can provide your feedback on [this feedback issue](https://gitlab.com/gitlab-com/gl-security/product-security/product-security-meta/-/issues/181) (Internal).

### Pilot Engagement Methods and Status

#### 1. Direct Issue Creation (Active Pilot Phase)

- Issues created in the [Product Security Requests repository](https://gitlab.com/gitlab-com/gl-security/product-security/product-security-requests) (Internal)
- Pilot team templates available for testing
- Automated labeling and routing being validated

#### 2. Handbook-Guided Requests (Active Pilot Phase)

- Updated handbook pages for pilot teams
- Direct links to create properly categorized requests
- Standardized templates being tested and refined

#### 3. Slack Integration (In Development Soon)

- Planned `/ProdSecHelp` command functionality
- Bot detection of security-related questions
- Interactive forms to identify specific needs
- Automatic routing to appropriate teams

#### 4. Existing Issue Enhancement (Planned)

- Future capability to add `ProdSecHelp` labels to existing issues for engagement
- Automation to detect labels and initiate engagement process

## Pilot Request Lifecycle

Pilot requests follow our standardized workflow using scoped labels:

1. **`::new-request`** - Initial submission and intake
1. **`::planned`** - Triaged and scheduled for upcoming milestones
1. **`::ongoing`** - Active work in progress
1. **`::completed`** - Work finished and closed

This labeling system is being tested to provide clear visibility and enable automated workflow management.

## Expected Benefits

### For Engineering Teams (Pilot Goals)

**Simplified Access**: Testing whether one clear process eliminates confusion about which security team to contact.

**Faster Response**: Validating that automated triage and routing reduce time from request to engagement.

**Consistent Experience**: Piloting standardized templates and workflows for predictable interactions.

**Reduced Friction**: Testing whether teams can engage without researching Product Security's organizational structure.

### For Product Security Teams (Pilot Objectives)

**Improved Efficiency**: Testing whether automated routing reduces manual triage overhead.

**Enhanced Visibility**: Evaluating centralized intake for comprehensive demand visibility.

**Standardized Processes**: Piloting consistent workflows and templates across teams.

**Better Metrics**: Collecting data to enable improved capacity planning and resource allocation.

## Participating in the Pilot

### Current Pilot Teams

- [Infrastructure Security](infrastructure-security/)
- [Vulnerability Management](vulnerability-management/)

### For Engineering Teams Working with Pilot Teams

1. **New Requests**: Use the standardized templates in the Product Security Requests repository
2. **Feedback**: Share your experience to help us improve the process
3. **Questions**: Reach out to pilot team members for guidance

## Next Steps

Based on pilot results, we plan to:

1. **Refine the process** based on feedback and lessons learned
2. **Implement automation** for improved efficiency and accuracy
3. **Expand to all Product Security teams** once validated
4. **Launch company-wide communication** about the new process

## Timeline

- **Current Phase**: Pilot with Infrastructure Security and Vulnerability Management
- **Validation Phase**: Testing automation and gathering comprehensive feedback
- **Rollout Phase**: Expansion to all Product Security teams and company-wide launch
