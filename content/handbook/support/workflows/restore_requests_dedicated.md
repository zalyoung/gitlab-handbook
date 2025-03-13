---
title: Restoring Deleted Data Requests for GitLab Dedicated
category: GitLab Dedicated
description: "Workflow for cases when a customer requests deleted projects or groups to be restored on GitLab Dedicated."
last-reviewed: 2025-03-13
---

## Overview

Use this workflow when a customer requests that we restore projects or groups that have been deleted from a GitLab Dedicated instance. This workflow is specifically for handling deletions of projects and groups.

## Process

1. Work with the customer to explore the self-serve options for recovering this data. Specifically:
  1. Have the customer [view project pending deletion](https://docs.gitlab.com/user/project/working_with_projects/#view-projects-pending-deletion). If [deplayed project deletion](https://docs.gitlab.com/user/project/working_with_projects/#delayed-project-deletion) is enabled, they may be able to **Restore** the deleted project(s).
  1. Have the customer check whether one of their team members could `git push` a local copy of the repo up to the GitLab Dedicated instance
1. If the customer can not self-serve the recovery, open an RFH to discuss the feasibility of a restore
  1. Note that requests to restore a single project for a single user will be declined.
  1. For all other requests, refrain from letting the customer know that we **will** or **won't** be able to restore until the feasibility assessment is complete in the RFH
1. Follow up with the customer based on the conversation in the RFH  

## Additional Resources

- [Restoring Deleted Data Requests](restore_requests.md) for GitLab.com
- [Updates to GitLab’s delayed deletion feature for projects and groups](https://about.gitlab.com/blog/2023/04/03/delayed-deletion/)