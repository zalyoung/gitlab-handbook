---
title: Dedicated Migration Team
---


## The Team

The Dedicate migration team is a team focussed on performing migrations into GitLab Dedicated. This is achieved using either [Geo](https://docs.gitlab.com/administration/geo/) or [Congregate](https://gitlab.com/gitlab-org/professional-services-automation/tools/migration/congregate).

### Team members

| Name | Title | Role | 
|---   | -----|------|
|Muhamed Huseinbašić|  Senior Site Reliability Engineer | [Environment Automation SRE](#environment-automation-sre-sre---infrastructure-provisioning-monitoring-and-platform-reliability-during-migrations) |
|Dave Dittman|         Site Reliability Engineer        | [Environment Automation SRE](#environment-automation-sre-sre---infrastructure-provisioning-monitoring-and-platform-reliability-during-migrations) |
|Sophia Langer|        Project Manager | [Project Manager](#project-manager-pjm---coordinating-project-timelines-stakeholder-communication-and-driving-deliverable-completion) |
|Eddie Yoffe|          Program Manager | [Project Manager](#project-manager-pjm---coordinating-project-timelines-stakeholder-communication-and-driving-deliverable-completion) |
|Oliver Seldman|       Program Manager | [Project Manager](#project-manager-pjm---coordinating-project-timelines-stakeholder-communication-and-driving-deliverable-completion) |
|Eren Ekca|            Senior Technical Architect | [Technical Architect](#technical-architect-ta---scoping-and-overseeing-the-migration-related-work) |
|Saurav Issar|         Senior Technical Architect | [Technical Architect](#technical-architect-ta---scoping-and-overseeing-the-migration-related-work) |
|Petar Prokić|         Senior Engineer| [Migration Engineer](#migration-engineer-ps-eng---execution-of-the-migration-related-work) |
|Jessykah Bird |       Engineer | [Migration Engineer](#migration-engineer-ps-eng---execution-of-the-migration-related-work) |
|Jordan Ng |           Engineer | [Migration Engineer](#migration-engineer-ps-eng---execution-of-the-migration-related-work) |
|Alex Rosencrans|      Engineer | [Migration Engineer](#migration-engineer-ps-eng---execution-of-the-migration-related-work) |
|Scott Murray|         Engineer | [Migration Engineer](#migration-engineer-ps-eng---execution-of-the-migration-related-work) |
|Douglas Alexandre|    Staff Engineer| [Migration Engineer](#migration-engineer-ps-eng---execution-of-the-migration-related-work) |
|Sampath Ranasinghe|   Senior Product Manager| |
|Akanksha Joshi|      Senior Technical Program Manager| |
|Lyle Kozloff| Technical Program Manager | |

## Mission

Successfully manage incoming migrations through FY26Q2 and FY26Q3 and establish a repeatable process for both Geo and Congregate migrations with a SSOT.

## Resources

- [GitLab group](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group)
- [GitLab project](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/dedicated-migrations)
- [Migrating Customers to Dedicated internal documentation](https://internal.gitlab.com/handbook/engineering/dedicated/migrating-customers-to-dedicated/)
- [Cutover Cancellation Impact](https://drive.google.com/drive/folders/12GInLFxnT5BPbPJh1JsemUE089-Ctj0e) 

## Roles

### Technical Architect (TA) - scoping and overseeing the migration related work

The Technical Architect serves as the strategic lead for migration projects, working closely with customers and internal teams to design migration strategies. They assess customer requirements, evaluate existing infrastructure, and determine the most appropriate migration approach (Geo/Congregate). The TA provides technical oversight throughout the entire migration lifecycle. They collaborate with Sales, Solutions Architects, and customers during the planning phase to scope project complexity and resource requirements.

### Migration Engineer (PS Eng) - execution of the migration related work

The Migration Engineer is the hands-on technical executor who implements the migration plan developed by the Technical Architect. They perform the actual data migration work for Congregate migrations and Direct Transfer imports, monitor migration progress, and troubleshoot technical issues that arise during execution. They collaborate closely with SREs to ensure platform stability during migration activities and participate in post-migration validation and cleanup efforts.

### Project Manager (PjM) - coordinating project timelines, stakeholder communication, and driving deliverable completion

The Project Manager orchestrates the entire migration project from sales completion through customer success handover. They coordinate between multiple teams (Sales, Professional Services, SREs, Customer Success), manage project timelines and milestones, and serve as the primary communication hub for status updates. The PjM ensures all migration phases are completed according to schedule, manages resource allocation across team members, facilitates customer meetings and check-ins, and tracks project deliverables. They work across all migration steps to maintain project momentum and ensure smooth handoffs between phases.

### Engineering Manager (EM) - Resource and team management

The Engineering Manager provides people leadership and resource management for the technical migration team members. They ensure appropriate staffing levels for migration projects, manage team member workloads and capacity planning. The EM coordinates with Project Managers to align resource availability with project demands, handles escalations that require management intervention, and ensures team members have the support and tools needed to execute successful migrations. They also contribute to process improvements and knowledge sharing across the migration team.

### Environment Automation SRE (SRE) - Infrastructure provisioning, monitoring, and platform reliability during migrations

The Site Reliability Engineer handles all infrastructure-related aspects of GitLab Dedicated migrations. They create and provision GitLab Dedicated infrastructure, and monitor platform health throughout migrations. SREs validate infrastructure performance, handle maintenance schedules, configure infrastructure-level settings, and provide technical support for Switchboard access and credentials. They play a critical role in Geo migrations by setting up replication and managing failover processes, while also monitoring platform performance and addressing issues during high-volume Congregate migrations.

### Geo Engineer (Geo Eng) - Specialized in GitLab Geo replication

The Geo Engineer is a specialist focused on GitLab's Geo replication capabilities. They design and implement Geo replication strategies, configure primary and secondary Geo nodes, and manage the technical aspects of Geo-based migrations. The Geo Engineer works closely with SREs and customers to set up background synchronization, plan and execute cutover processes. They provide expertise in Geo troubleshooting, and performance optimization.

### Import Engineer (Import Eng) - Specialised in GitLab import functionality

The Import Engineer is a specialist focused on GitLab’s Import/Export functionality. Their primary focus is getting the GitLab import/export functionality to cover all functionality and mapping necessary for migration from non-GitLab platforms (e.g. Github , Bitbucket, etc.). The Import Engineers provide support to SRE’s to ensure that migration waves from other platforms are possible within the existing capacity of GitLab, and provide expertise in troubleshooting and performance optimization.




    
## Process
