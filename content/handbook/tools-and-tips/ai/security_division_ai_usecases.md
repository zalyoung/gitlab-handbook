---
title: "AI use cases within the Security Division at GitLab"
---

Learn how the [Security Division](https://handbook.gitlab.com/handbook/security/) leverages Claude and DUO to optimize workflows, improve productivity and automate manual tasks. 

## Active Use Case Library

| Tool | AI Engine | Use Case | Team |
|------|-----------|----------|------|
| [TLDR Customer Threat Detections](https://gitlab.com/gitlab-com/gl-security/security-operations/signals-engineering-public/tldr) | Claude | Signals Engineering uses Claude to generate new TLDR threat detections - a Slack slash command (/tldr) is available to kick off a new Claude written MR for review. | [Signals Engineering](https://internal.gitlab.com/handbook/security/security_operations/signals_engineering/) |
| [AppSec Assistant](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/tooling/assistant) | Duo | AI reviews development issues to identify security risks at design time | [Product Security Engineering ](https://handbook.gitlab.com/handbook/security/product-security/product-security-engineering/)on behalf of [Application Security](https://handbook.gitlab.com/handbook/security/product-security/application-security/) |
| [Sir Tanuki](https://internal.gitlab.com/handbook/security/security_operations/sirt/operations/incident_response/sirtanuki/) (SIRT Incident Review Bot) | Duo | The SecOps Incident Reviewer (Sir) Tanuki is SIRT’s GitLab Duo-powered incident report reviewing tool. It works by leveraging GitLab Duo to analyze security incident issues and give feedback on the different sections of the issue description. | [Security Incident Response Team (SIRT)](https://handbook.gitlab.com/handbook/security/security-operations/sirt/) |
| [/sirt_summary](https://internal.gitlab.com/handbook/security/security_operations/sirt/platforms/slack/bots_commands/#sirtmanager) | Claude | Incident summarization slash command in Slack | [Security Incident Response Team (SIRT)](https://handbook.gitlab.com/handbook/security/security-operations/sirt/) |
| [Duo generated CVE descriptions](https://gitlab.com/gitlab-com/gl-security/engineering-and-research/automation-team/h1bot/-/merge_requests/46) | Duo | Generates CVE description from the imported HackerOne reports that can optionally be used in our CVE's. | [Application Security](https://handbook.gitlab.com/handbook/security/product-security/application-security/) |
| [Automate our Continous Control Monitoring Program](https://gitlab.com/gitlab-com/gl-security/security-assurance/security-compliance/team/-/tree/AWS-API-test/Continuous%20Control%20Monitoring/AWS?ref_type=heads) | Claude | Generate entire scripts used for: Pull data from resources (e.g. AWS); Pull policies from a yaml file; Perform an audit analysis and Conclusion (example [here](https://gitlab.com/gitlab-com/gl-security/security-assurance/security-compliance/continous-control-monitoring-program/-/issues/2)) | [Security Compliance](https://handbook.gitlab.com/handbook/security/security-assurance/security-compliance/) |
| [Generation of Test Cases for gitlab-assistant](https://gitlab.com/gitlab-com/gl-security/security-assurance/governance-and-field-security/governance/security-assurance-automation-subgroup/gitlab-assistant) | Duo | Generate basic and complex test cases for a Python module that standardizes scripting of solutions across the team when building automations and functionality for interactions with GitLab. The module introduces business logic beyond the basic API endpoint interactions. |

## Ideas, Experiements and Tests

The security division works out of GitLab issues to keep track of AI integrated ideas, experiements and tests. Generally it is a good idea to add the `AI` GitLab label to issues for tracking.
