---
title: Tenant Scale Group
description: Information about the Tenant Scale Group
---

## Mission

Ensure the viability of GitLab’s multi-tenant platforms.

## Vision

Build GitLab’s next generation multi-tenant, horizontally scalable SaaS platform, and the logical application container to enable customers to move across GitLab’s platforms as their needs evolve.

## Team Members

### Group Leads

{{< member-and-role-by-gitlab "glopezfernandez" "ayufan" "sxuereb" "tkuah" "rymai" "nhxnguyen" >}}

### Geo

{{< team-by-manager-slug manager="luciezhao" >}}

### Organizations

{{< team-by-manager-slug manager="mandrewsgl" team="Organizations" >}}

### Cells Infrastructure

{{< team-by-manager-slug manager="dlogalbo" team="Cells Infrastructure" >}}

## Resources

- Slack (internal only): [#s_tenant_scale](https://gitlab.enterprise.slack.com/archives/C07TWC3QX47)

## Projects

1. [Cells and Organizations project](cells_and_organizations/_index.md)

## How to Get Support from the Group Tenant Scale (GTS) Teams

The Group Tenant Scale (GTS) organization includes multiple specialized teams working on scalability solutions for GitLab. This section outlines the process and expectations when requesting support from GTS teams for customer support issues or technical assistance.

### Our Teams

The GTS group includes the following teams, each with their own areas of expertise:

- **Geo and Disaster Recovery** - Data redundancy and disaster recovery solutions
- **Cells** - Horizontal scaling and tenant isolation 
- **Organizations** - Organization entity development to support Cells

### Before Requesting Support

Before submitting a request for support, please:

1. **Review relevant documentation** - Check the specific team's documentation, handbook pages, and any related GitLab docs
2. **Search previous issues** - Look through existing customer issues in the relevant team's project
3. **Check team-specific channels** - Reach out in the appropriate team's Slack channel first for quick questions:
   - Geo: `#g_geo` or `#spd_pod_geo`
   - Cells: `#g_cells_infrastructure`
   - Organizations: `#g_organizations`

### Getting Quick Help

#### General Questions

If you have a general question that you can't find an answer to in documentation, feel free to ask in the relevant team's Slack channel. Please keep in mind that engineers will do their best to answer questions quickly, but for more complex scenarios requiring research, you'll need to create a support issue.

#### When to Create a Support Issue

Create a support issue when:

- Slack discussions indicate more investigation is needed
- The question involves customer-specific scenarios
- You need documentation or context preserved beyond Slack retention
- The issue requires coordination across team members
- Priority assignment and tracking is needed

### Creating Support Requests

#### Issue Creation Process

We use issues to help prioritize work and maintain context. Please:

1. **Create the RFH**: Create issues in the [Request For Help Repo](https://gitlab.com/gitlab-com/request-for-help):
   
2. **Use the correct template**: Select the appropriate issue template for the type of support needed
   - Most teams have specific support request templates
   - Include customer information and detailed support questions
   - For collaboration requests (joining calls), use collaboration-specific templates where available

3. **Provide essential information**:
   - **Customer information** - Account details, subscription level, environment info
   - **Zendesk links** (for support cases) - Required for proper triage
   - **Logs and diagnostic data** - Include relevant technical details
   - **Context** - Background information and what has been tried already

⚠️ **Important**: Issues missing Zendesk links and essential diagnostic information will not enter the normal triage process.

#### Request for Help (RFH) Requirements

- RFHs must generally be opened by Support Engineers once a support ticket exists
- Include all relevant context and previous troubleshooting steps
- Issues with no updates for 2 weeks will be auto-closed by the team

### Priority Levels and Response Times

You may assign a priority label to your request. Team members will review and adjust priority during triage as needed.

| Priority | Typically Used For | Expected Response Time* |
|----------|-------------------|------------------------|
| **P4** | General questions requiring investigation that can't be answered quickly | 2-3 days |
| **P3** | Non-urgent customer problems with workarounds, or future engagement scheduling | 1 day |
| **P2** | Somewhat time-sensitive customer problems blocking progress or decisions | 1/2 day |  
| **P1** | Fires and emergencies that customers are experiencing | 1-2 hours |

\* Response times are based on weekdays (excluding holidays) within regular business hours across team member time zones.

### Escalation for Urgent Issues

For outages and other urgent matters that require immediate attention:

- Use GitLab's [incident management](../../infrastructure/incident-management/) processes
- Contact the appropriate on-call engineer if your organization has established escalation procedures
- For P1 emergencies, you may also reach out directly in team Slack channels while creating the formal issue

### Team-Specific Resources

Each team maintains their own additional resources and processes:

- **Geo Team**: See [Geo support process](geo/#how-to-ask-for-support-from-geo/_index.md) for detailed Geo-specific guidance
- **Cells and Organizations**: Check the [Cells handbook page](cells_and_organizations/_index.md) for cells-specific information
- **Organizations Team**: See [Organizations team page](tenant-scale/organizations/_index.md) for organization-specific guidance

### Best Practices

- **Be specific**: Include exact error messages, steps to reproduce, and environment details
- **Check documentation first**: Teams maintain comprehensive docs - please review them before requesting support  
- **Provide context**: Explain what you're trying to achieve, not just what's not working
- **Use clear titles**: Make issue titles descriptive and actionable
- **Follow up appropriately**: Respond to questions from team members promptly to keep issues moving

This process helps us provide the best possible support while managing our workload effectively. Thank you for following these guidelines!
