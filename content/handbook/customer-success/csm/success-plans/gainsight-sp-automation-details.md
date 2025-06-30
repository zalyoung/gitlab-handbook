## GitLab.com Success Plan Automation in Gainsight
Process Overview

## Data Entry (GitLab.com)

- Success Plan data is entered into GitLab.com through epics and initiatives
- GitLab.com serves as the source of truth for all Success Plan information

## Data Pipeline

- Data is automatically extracted and formatted as CSV
- Pipeline pushes data to designated Gainsight S3 bucket
- Pipeline runs on a daily schedule to ensure regular updates

## Data Ingestion

- S3 bucket data is ingested into Gainsight custom objects
- Daily ingestion process ensures data consistency

## Success Plan Creation

- System automatically creates "GitLab.com" Success Plan type for all active accounts
- Initial plans are set to DRAFT status
- The Success Plan is active once the first Objective is present

## Objective Creation

System creates new Objectives using API using ingested data
- First Objective creation triggers automatic status change from DRAFT to ACTIVE
- Objectives are mapped directly from GitLab.com data
- Objectives must have a status, name and due date or they will not get synced over

## Task Management

- System automatically creates associated Tasks for each Objective
- Tasks are linked to their parent Objectives within Gainsight
- Tasks must have a status, name and due date or they will not get synced over

## Ongoing Updates

- Objectives and Tasks are automatically updated based on GitLab.com changes
- Daily sync ensures alignment between GitLab.com and Gainsight
- Updates maintain consistency across both platforms

## Important Notes

- All data flows one-way from GitLab.com to Gainsight
- Updates must be made in GitLab.com to maintain data integrity
- Success Plans in Gainsight should not be updated directly as changes will not sync back to GitLab.com
- Daily sync ensures Gainsight reflects current GitLab.com state