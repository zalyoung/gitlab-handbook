---
layout: handbook-page-toc
title: "Deprecations, removals, and breaking changes"
---

# Overview


## Announcements

Given the importance of our security features, we should aim to announce
deprecations **six milestones** before the targeted major release. Unless
absolutely necessary, deprecations should **not** use the [_minimum_ deprecation notice](https://docs.gitlab.com/ee/development/deprecation_guidelines/#when-can-a-feature-be-deprecated).
In most cases, the minimum deprecation notice provides too little time for large
customers to migrate, ultimately providing a suboptimal experience.

### Strategies

Consider the following strategies when announcing a deprecation:

- Create a release post
- State that the feature is [not actively developed](https://docs.gitlab.com/ee/development/documentation/styleguide/deprecations_and_removals.html#features-not-actively-being-developed)
- Add a pipeline warning
- Add an analyzer warning

## Migrations

All changes must have a migration path that works on:

- GitLab.com
- Self-managed
- Dedicated
- FIPS

In addition, they must also cover the following paths:

- [Pipeline execution policies](https://docs.gitlab.com/ee/user/application_security/policies/pipeline_execution_policies.html)
- [Scan execution policies](https://docs.gitlab.com/ee/user/application_security/policies/scan_execution_policies.html)
- [CI/CD template](https://gitlab.com/gitlab-org/gitlab/-/blob/b97eca307bd0986aa54eb287a7fe32f075e81d8f/lib/gitlab/ci/templates/Jobs/Dependency-Scanning.gitlab-ci.yml)
- [CI/CD component](https://gitlab.com/components/dependency-scanning/)

### Pipeline execution policies

-

### Scan execution policies

-

### CI/CD template

-

### CI/CD component

- Create a new major release in the CI/CD component project.
- Create a tool to automatically upgrade
- Write a migration guide detailing.

### Guides

-

## Automation

Requirements:

- Allow dry runs
- Easy to rollback
- Support large instances and groups
- Sufficiently tested

---

### Successful migration guide

- Must cover environments:
    - Gitlab.com
    - Self-managed
    - Dedicated
    - FIPS
- Identify namespace(s) and project(s) negatively impacted
- Automate migrations
    - binary
    - rake task?
        -
    - batched background migration?
        - hard to configure
    - housekeeper
        - scoped to gitlab only at this time
