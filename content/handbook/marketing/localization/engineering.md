---
title: Localization Engineering
description: Technical details of GitLab's localization infrastructure and engineering processes.
---

Technical overview of GitLab's localization infrastructure and engineering processes across documentation and product interfaces. Includes translation environments, branch management, development workflows, and preview systems for internationalized content.

## Internationalized Documentation - docs.gitlab.com

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

#### Overview

Each project within these environments maintains the following branch structure:

1. **main** Used exclusively for pulling upstream changes into our fork. Do not contribute to this branch.
2. **main-translation** Used for delivering translations from our Translation Management System (TMS). Do not contribute to this branch.
3. **main-development** This is our development workspace for i18n features.
4. **live-preview** A stable live preview branch for the internationalized GitLab documentation. [See MR for more details](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/test/gitlab-docs/-/merge_requests/17).

#### Branch maintence

##### How to Update Localization Forks with Upstream Changes**

###### Steps

1. **Update the Fork's main branch**  
   * Update your fork's default branch (`main` or `master`) to match the Production Project's default branch
   * Use the "Update Fork" button in the UI
2. **Create a merge request (MR)**
   * Create an MR that merges the default branch to `main-translation`
   * This MR will contain all documentation changes since the last update
3. **Review changed files**
   * **Pipelines**: If pipelines fail, this is typically due to upstream configuration issues
     * In most cases, you can force the merge and ignore pipeline issues
     * Attempting to fix these issues often consumes engineering resources unnecessarily
   * **Merge Conflicts**: Review these case by case
     * May need to be relayed to the localization team
     * Conflicts occur because of upstream changes
     * Ignoring conflicts on target files will cause future translations to overwrite upstream changes
4. **Merge the MR to `main-translation`**
   * This updates the translation branch with the default branch
   * Triggers GitLab Integration to check for source language file updates

[See example MR](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/prod/omnibus-gitlab/-/merge_requests/11) for updating the `main-translation` branch with content from the Omnibus Production fork.

### Development Environments

When working on i18n features:

1. Always use the **main-development** branch to create your feature branch
2. Follow the standard merge request review process for any changes
3. Test thoroughly using the actual translations available in the branch
4. Once approved, changes can be submitted upstream to the original repositories

This workflow ensures we can develop and validate i18n features in an environment with real translations before integrating them with the primary codebase.

#### Live Preview Environment

The `live-preview branch` provides a stable environment to review internationalized documentation before production deployment. It consolidates translated content from all five repositories (GitLab, Operator, Omnibus, Runner, Charts), maintains production-identical build pipelines, and mirrors the translation workflow.

Use this environment to review translations in context, verify integration, and identify formatting issues before they reach production

##### Accessible Live Preview URLs

| Repository | Live Preview URL |
| ----- | ----- |
| GitLab | [https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/ci/yaml/](https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/ci/yaml/) |
| Operator | [https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/operator/backup\_and\_restore/](https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/operator/backup_and_restore/) |
| Omnibus | [https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/omnibus/build/build\_docker\_image/](https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/omnibus/build/build_docker_image/) |
| Runner | [https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/runner/register/](https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/runner/register/) |
| Charts | [https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/charts/installation/](https://gitlab-docs-hugo-19c275.gitlab.io/review-mr-17/ja-jp/charts/installation/) |

This implementation follows the architecture detailed in [tech-docs-forked-projects/test/gitlab-docs/-/merge_requests/17](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/test/gitlab-docs/-/merge_requests/17).
