---
title: Localization Engineering
description: Technical details of GitLab's localization infrastructure and engineering processes.
---

## Internationalized Documentation 

The GitLab docs site is beeing enabled for internationalization, with initial support for Japanese translations.
https://docs.gitlab.com/ja-jp/

### Translation content sources

Translated content for https://docs.gitlab.com is pulled from separate `/doc-locale/` directories in the following repositories:

* [GitLab](https://gitlab.com/gitlab-org/gitlab/-/tree/master/doc-locale/) 
* [Operator](https://gitlab.com/gitlab-org/cloud-native/gitlab-operator/) 
* [Omnibus](https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/doc-locale/)  
* Runner  
* Charts

### Translation environments

We maintain two separate environments that contain all projects used to compile docs.gitlab.com. These contain forks of the upstream projects.

**Production environment**: [localization/tech-docs-forked-projects/prod/](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/prod/)

**Test environment**: [localization/tech-docs-forked-projects/test/](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/test/)

### Branch structure

Each project within these environments maintains the following branch structure:

1. **main** Used exclusively for pulling upstream changes into our fork. Do not contribute to this branch.
2. **main-translation** Used for delivering translations from our Translation Management System (TMS). Do not contribute to this branch.
3. **main-development** This is our development workspace for i18n features.
4. **live-preview** A stable live preview branch for the internationalized GitLab documentation. [See MR for more details](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/test/gitlab-docs/-/merge_requests/17).

#### Branch maintence

##### How update localization forks with upstream changes

1. A localization team member updates the Fork Project’s main branch to match the Production Project’s default branch.
2. The localization team member creates an MR that merges the default branch to a `main-translation`. This MR contains all the changes to the default branch since the last time this step was done, which includes all the changes to the documentation that have occurred since then.
3. The localization team member merges the MR to the `main-translation`, bringing the translation branch up to date with the default branch and triggering the GitLab Integration to check for source language file updates.`

[Here is an example](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/prod/omnibus-gitlab/-/merge_requests/11) update `main-translation` branch with content form upstream from Omnibus Production fork.

### Local development workflow

When working on i18n features:

1. Always use the **main-development** branch for development work  
2. Follow the standard merge request review process for any changes  
3. Test thoroughly using the actual translations available in the branch  
4. Once approved, changes can be submitted upstream to the original repositories

This workflow ensures we can develop and validate i18n features in an environment with real translations before integrating them with the primary codebase.
