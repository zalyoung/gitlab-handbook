---
title: "Ownership & boundaries - SCM / Import"
description: This page provides clarity and a clear expectation between Source Code Management and Import and Integrate groups over shared parts of the codebase
---

## Context

There are parts of the codebase that have shared ownership between the groups of **Create:Source Code Management (Backend)** and **Manage:Import and Integrate** and have historically been sources for instability and even causing incidents given the lack of visibility over each other work.

This page attempts to document in a Single-Source-of-Truth (SSOT) fashion who owns which part of the shared system and how each team can and should rely on the other to mitigate risk of bugs and incidents.

Owning a system part means being responsible for feature development, bug-fixes, and general maintenance of the affected part. Shared portions will clarify the expectations of either teams.

## System overview

Currently, the known related codebase system parts are as follows:

* Import state
* ...(please complete)...
* Forking
* Pull Mirroring
* Project templates
  * Built-in
  * Custom
    * Group-level
    * Instance-level

## Timeline

This page documents the status-quo today however, it's important to understand the agreed-upon direction for future development.

In the future, we expect **SCM** to decouple the **forking** and **pull-mirroring** from any code owned by **Import and Manage**. This will allow Import and Manage to have capacity to fully own the **Project templates** category.

## Ownership model

## Ownership model for features implemented in Language Server

Currently used by **Duo Workflow** and soon to be used by **Duo Chat**.

| System part | Group responsible |
| ----------- | ----------------- |
|             |                   |

## Process of notifying others

* TBD
