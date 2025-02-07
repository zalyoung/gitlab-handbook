---
title: "Vue 3 Router 4 Test Compatibility Task Group"
description: "Learn more about the Vue 3 Router 4 Test Compatibility Task Group's attributes, goals, roles and responsibilities"
---

## Attributes

| Property | Value |
| -------- | ----- |
| Date Created | 2025-01-02 |
| Target End Date | 2025-03-31 |
| Slack | [#tg_vue3_router4_tests](https://gitlab.enterprise.slack.com/archives/C086YM54QQM) |

## Context

A major effort is underway to ensure that the [GitLab](https://gitlab.com/gitlab-org/gitlab) unit tests are passing and compatible with Vue compat.
A major cause of the current failures is a compatibility issue in how tests are written when incorporating Vue Router.

Vue 2's router version is [Vue router 3](https://v3.router.vuejs.org/), whereas Vue 3's router version is [Vue router 4](https://router.vuejs.org/guide/). There are several differences between the two, explained in the [migration guide](https://router.vuejs.org/guide/migration/).

These differences between Vue Router 3 and 4 require that unit tests are re-written based on the findings of [the initial investigation](https://gitlab.com/gitlab-org/gitlab/-/issues/509084).

## Goal

Fix all tests that are currently failing due to Vue Router incompatibility.

The initial investigation on [how many tests are failing due to the incompatibility](https://gitlab.com/gitlab-org/gitlab/-/issues/509084#note_2284897081) highlighted the following test suites:

* ee/spec/frontend/insights/insights_router_spec.js
* ee/spec/frontend/on_demand_scans/components/tabs/base_tab_spec.js
* spec/frontend/crm/crm_form_spec.js
* spec/frontend/ml/experiment_tracking/routes/experiments/show/ml_experiments_show_spec.js
* spec/frontend/organizations/groups_and_projects/components/app_spec.js
* spec/frontend/projects/your_work/components/app_spec.js

Once these tests are fully addressed, it will be necessary to take another look at the [jest speed reporter](https://gitlab-org.gitlab.io/frontend/playground/jest-speed-reporter/vue3) to make sure that no other tests are failing due to router compatibility. The above investigation has assumed that tests failing due to compatibility issues are exposed by the string "Vue router" in the failure message.

The strategy for fixing these tests has been documented in the [Testing Vue router](https://docs.gitlab.com/ee/development/testing_guide/testing_vue3.html#testing-vue-router) section of the Vue 3 testing handbook.

## Non-goals

* Tests that are not directly related to the compatibility of Vue Router 3 and 4 won't be considered, as they are not covered by the migration strategy.

## Exit Criteria

* [Tests](https://gitlab-org.gitlab.io/frontend/playground/jest-speed-reporter/vue3) issuing a `Vue router warn` fixed (where applicable, see non-goals above).

## Roles and Responsibilities

| Task Group Role | Person | Title |
| --------------- | ------ | ----- |
| DRI | Marina Mosti | Sr. Frontend Engineer, Switchboard |
