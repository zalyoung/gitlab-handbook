---
title: "Compliance Frameworks ADR 005: Violations Engine"
toc_hide: true
---

## Context

While the adherence report states the current state of a project against the configured framework and requirements/controls,
it does not show a history of the state. Most importantly it does not show when the project might not have been adhering
and when there was a violation of the requirement/control.

## Approach

The violation engine is similar to the configuration checks engine, at certain trigger points the system will audit that
the event does not violate any configured compliance controls.

For certain controls defined in GitLab there will be a event trigger point. When this event is triggered for a project the violation engine will check whether the project has a compliance framework configured with that requirement controls. If the project does have this configured then the event will be logged as a violation.

For example when a Merge Request is merged the system will trigger a potential violation event. The violations engine will check if there is a control defined for the project which states all Merge Requests requiring 2 approvers, if the Merge Request has less then 2 then a violation is created from the event.

All GitLab defined controls will have an audit event type configured as its trigger point. We will update the audit event type yml file to include a new parameter that will indicate which control it is associated. One audit event may have multiple controls associated with it, such as when an MR is merged.

Here is an example audit event type yml file with the new parameter

```yml
---
name: merge_request_merged
description: A merge request is merged
introduced_by_issue: https://gitlab.com/gitlab-org/gitlab/-/issues/442279
introduced_by_mr: https://gitlab.com/gitlab-org/gitlab/-/merge_requests/164846
feature_category: compliance_management
milestone: '17.5'
saved_to_database: true
streamed: true
scope: [Project]
compliance_requirement_controls: [minimum_approvals_required_2, merge_request_prevent_committers_approval, merge_request_prevent_author_approval]
```

There are also several controls like `vulnerabilities_slo_days_over_threshold`, `review_and_archive_stale_repos`, etc.
that cannot be directly linked to an audit event. For these controls, we would rely on `FrameworkEvaluationSchedulerWorker`.
When the worker evaluates these controls and if it finds the status of these controls as failing, we would then create
an audit event for the failed control which would then eventually create a violation record.

## Design Details

```mermaid
classDiagram
class namespaces {
    id: bigint
    name: text
    path: text
    ...(more columns)
}
class projects {
    id: bigint,
    name: text
    path: text
    description: text
    ...(more columns)
}
class compliance_management_frameworks {
    id: bigint,
    name: text,
    description: text,
    ...(more columns)
}

class compliance_requirements {
    id: bigint
    created_at: timestamp
    updated_at: timestamp
    namespace_id: bigint
    framework_id: bigint
    name: text
    description: text
}

class compliance_requirements_controls {
    id: bigint
    created_at: timestamp
    updated_at: timestamp
    namespace_id: bigint
    requirement_id: bigint
    name: text
    control_type: smallint
    external_url: text
    expression: text
    encrypted_secret_token: bytea
    encrypted_secret_token_iv: bytea
}

class project_requirement_compliance_status {
    id: bigint
    created_at: timestamp
    updated_at: timestamp
    project_id: bigint
    namespace_id: bigint
    compliance_requirement_id: bigint
    status: smallint
}

class project_compliance_violations {
    id: bigint
    created_at: timestamp
    updated_at: timestamp
    project_id: bigint
    namespace_id: bigint
    compliance_requirements_controls_id: bigint
    audit_event_id: bigint
    status: smallint
}

class audit_events {
    id: bigint
    author_id: bigint
    entity_id: bigint
    entity_type: string,
    details: text,
    author_name: text,
    entity_path: text,
    target_details: text,
    target_type: text,
    target_id: bigint
    ...(more columns)
}

class notes {
    id: bigint
    note:
    notable_type:
    author_id: bigint
    project_id: bigint
    ...(more columns)
}

class issues {
    id: bigint
    title: text
    project_id: bigint
    ...(more columns)
}

compliance_management_frameworks --> compliance_requirements : has_many
compliance_management_frameworks <--> projects : many_to_many
compliance_requirements --> compliance_requirements_controls : has_many
projects <-- namespaces : has_many
namespaces --> compliance_management_frameworks : has_many
projects --> project_requirement_compliance_status : has_many
projects --> project_compliance_violations : has_many
compliance_requirements --> project_requirement_compliance_status : has_one
compliance_requirements_controls --> project_compliance_violations : has_many
project_compliance_violations --> audit_events : has_one
project_compliance_violations <-- audit_events : has_many
project_compliance_violations --> notes : has_many
project_compliance_violations --> issues : has_many
```
