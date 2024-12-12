---
title: "Compliance Frameworks ADR 006: Storing Controls in a separate Table"
toc_hide: true
---

## Context

As [outlined previously](./003_custom_controls.md), we decided to store the control expression as a json within the
`compliance_requirements` table. In the previous ADR it was decided to allow logical operators such as AND, OR, etc.
and create complex nested expressions, however after our current customer and competitor research it was found that
we do not need to allow nested expressions and each control within a requirement should be ANDed. This means that a
compliance requirement fails if a control fails.

With the previous approach there was also a challenge to evaluate and store the status of individual controls
separately, however, on the dashboard the plan is to display the status of each control separately.

## Decision

Instead of storing the expression as json within the `compliance_requirements` table it was decided to create a
separate database table named `compliance_requirements_control`. With the introduction of this new database table
we also had to update the existing `compliance_requirements` and `project_control_compliance_status` tables a
bit.

```mermaid
classDiagram

    class compliance_requirements {
        id: bigint
        created_at: timestamp
        updated_at: timestamp
        namespace_id: bigint
        framework_id: bigint
        name: text
        description: text
    }

    class compliance_requirements_control {
        id: bigint
        created_at: timestamp
        updated_at: timestamp
        namespace_id: bigint
        requirement_id: bigint
        name: text
        control_type: smallint
        external_url: text
        expression: text
    }

    class project_control_compliance_status {
        id: bigint
        created_at: timestamp
        updated_at: timestamp
        project_id: bigint
        namespace_id: bigint
        compliance_requirement_id: bigint
        compliance_requirements_control_id: bigint
        status: smallint
    }

    compliance_requirements --> compliance_requirements_control : has_many
    compliance_requirements_control --> project_control_compliance_status : has_many
```

We would create schema validators for validating the `expression` column of the `compliance_requirements_control`
table. This columns would contain simple expressions of the following form:

```json
{
  "operator": "=",
  "field": "minimum_approvals_required",
  "value": "2"
}
```

We would have a unique constraint for `compliance_requirements_control` table with `requirement_id` and `name`.
This will ensure that a requirement cannot have more than one control of the same name. Example: A requirement cannot
have two rows for 'minimum_approvals_required' control.

`project_control_compliance_status` table would also have a unique constraint on
`compliance_requirements_control_id` and `project_id`. This will ensure that each row in this table will tell the
compliance status of a specific control for a project.

The results would be stored in the `project_control_compliance_status` status as decided previously, however, the
status would be at a control level per project instead of a requirement level per project.

The plan for [external requirements](./003_custom_controls.md#external-requirements) remains unchanged with the above
changes to internal requirements.
