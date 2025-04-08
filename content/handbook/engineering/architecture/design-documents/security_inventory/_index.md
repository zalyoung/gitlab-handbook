---
title: "Security Inventory"
status: ongoing
creation-date: "2025-04-07"
authors: [ "@rossfuhrman", "@gkatz1" ]
coach: "@theoretick"
approvers: [  ]
owning-stage: "~devops::security risk management"
participating-stages: ["~group::security platform management"]
toc_hide: true
no_list: true
---

{{< design-document-header >}}

## Summary
This architecture blueprint outlines a comprehensive approach to implementing a Security Inventory feature. The feature aims to provide AppSec and DevSecOps teams with visibility into their security posture across all their digital assets. The current system lacks asset-level visibility, focusing primarily on project-level vulnerabilities without providing a holistic view of security coverage and gaps. 

Our proposal introduces a performant, hierarchical inventory system that provides visibility into groups, subgroups, projects, and their security scanning coverage and vulnerability statistics. By pre-calculating and efficiently storing this data, we enable quick querying and visualization without costly aggregation operations, making the system scalable for our largest customers.```


### Proposal
Implement a Security Inventory feature that provides project and group-level visibility, showing security analyzers coverage and vulnerability statistics. The system will:
1. Maintain up-to-date analyzer status information at both project and namespace levels
2. Pre-calculate namespace-level statistics to avoid costly aggregation operations
3. Propagate changes up the hierarchy when updates occur
4. Include a schedule alignment service to detect and correct data drift


### Motivation
AppSec teams today face significant challenges in securing their company's digital assets due to lack of visibility. Without comprehensive asset inventories, they cannot:
- Understand their security coverage gaps
- Make efficient, risk-based prioritization decisions
- Track which security controls are implemented where
- Identify outdated dependencies or frameworks
- Determine which assets handle sensitive information

By implementing the Security Inventory feature, GitLab will empower security teams to visualize their entire asset portfolio and the security measures applied to each asset, enabling them to make better security decisions based on a complete picture.


#### Visibility
TO_ADD


### Goals
- Create a performant, scalable inventory system that works efficiently for GitLab's largest customers
- Provide hierarchical visibility into security posture across groups, subgroups, and projects
- Reduce the computational overhead by pre-calculating and efficiently storing security statistics
- Minimize data drift through regular alignment checks


### Non-Goals
TO_ADD


### Terminology/Glossary
- **Security Inventory**: A comprehensive view of all assets and their security posture.
- **Analyzer**: A security scanning tool that checks for specific types of vulnerabilities (e.g., SAST, DAST, SCA)
- **Analyzer Status**: Information about whether a specific security analyzer has been configured and run for a project. For the MVC - `Success`, `Failed` and `Not Configured`
- **Vulnerability Statistics**: Pre-calculated counts of vulnerabilities by severity level
- **Namespace**: A container for projects in GitLab, can be user or group namespaces
- **Group**: A collection of projects and subgroups in GitLab
- **Data Drift**: Inconsistencies between calculated statistics and actual data stored in the tables
- **Schedule Alignment Service**: A background service that periodically checks for and corrects data drift


### Design Details
TO_ADD


##### Approach
1. **Data Storage and Calculation**:
   - Pre-calculate vulnerability statistics by severity for each project and namespace   
   - Store analyzer status information at both project and aggregated namespace levels
   - Propagate changes up the hierarchy when updates occur at the project level
   - Use efficient database structures to enable fast querying without aggregation

2. **Data Collection**:
   - Update analyzer statuses based on detected security scanner executions in a post-pipeline execution step
   - Calculate and store vulnerability statistics when new security findings are generated or when dismissing a finding

3. **Data Integrity**:
   - Implement a schedule alignment services to detect and correct data drift
   - Run periodic checks to ensure project and namespace statistics remain in sync
   - Generate development notifications when data drift is detected to alert about potential bugs

4. **User Interface**:
   - Include filtering and pagination capabilities


##### Internal requirements
1. **Database Performance**:
   - Optimize database schema for read performance
   - Implement efficient indexing strategies
   - Minimize the need for joins or aggregations during page load

2. **Data Propagation**:
   - Ensure changes at project level reliably propagate to all ancestor namespaces
   - Handle edge cases like project transfers between groups and project deletions

3. **Data Consistency**:
   - Use database transactions where appropriate
   - Design the schedule alignment service to detect inconsistencies

4. **Scalability**:
   - Prefer background jobs and workers for pre-calculating statistics when possible
   - Implement pagination and efficient filtering
   - Optimize query patterns to avoid performance degradation at scale

5. **User Permissions**:
   - Show only projects and groups that the user has access to
   - Apply appropriate access controls for security information


##### External requirements
TO_ADD


###### Workflow
TO_ADD


###### Auditing


###### Application Programmer Interfaces (APIs)
TO_ADD


### Database Schema
The system will utilize the following tables:

1. **analyzer_project_statuses**

   ```sql
    CREATE TABLE analyzer_project_statuses (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    project_id bigint NOT NULL,
    analyzer_type smallint NOT NULL,
    status smallint NOT NULL,
    last_call timestamp with time zone NOT NULL,
    traversal_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL
   );


### Constraints
TO_ADD


### Security inventory workflow diagrams
TO_ADD


#### Security inventory definition
TO_ADD
