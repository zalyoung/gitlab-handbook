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

A major effort is underway to ensure that the Gitlab Org unit tests are passing and compatible with vue compat. 
The main cause of the current failures is a compatibility issue in how tests are written when incorporating Vue Router.

The differences between Vue Router 3 and 4 require that unit tests are re-written based on the findings of [the initial investigation](https://gitlab.com/gitlab-org/gitlab/-/issues/509084).

## Goals

- Fix all tests that are currently failing due to Vue Router incompatibility.

## Non-goals

- Tests that are not directly related to the compatibility of Vue Router 3 and 4 may be initially skipped, as they are not covered by the migration strategy.

## Exit Criteria

- [Tests](https://gitlab-org.gitlab.io/frontend/playground/jest-speed-reporter/vue3) issuing a `Vue router warn` fixed (where applicable, see non-goals above).

## Roles and Responsibilities

| Task Group Role | Person | Title |
| --------------- | ------ | ----- |
| DRI | Marina Mosti | Sr. Frontend Engineer, Switchboard |
