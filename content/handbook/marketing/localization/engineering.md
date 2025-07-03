---
title: Localization Engineering
description: Technical details of GitLab's localization infrastructure and engineering processes.
---

Technical overview of GitLab's localization infrastructure and engineering processes across documentation and product interfaces. Includes translation environments, branch management, development workflows, and preview systems for internationalized content.

## Iteration Process

We start our iteration on a Tuesday. We release throughout the iteration. Iterations are 2 weeks long. 

See our [Localization engineering iterations here](https://gitlab.com/groups/gitlab-com/localization/-/cadences/).

### Labels and Workflow Boards

We use issue boards to track issue progress throughout an iteration. Issue boards should be viewed at the highest group level for visibility into all nested projects in a group.

The Localization team uses the following issue labels for distinguishing which part of the org the work belongs to and distinguishing between specialities:

| Organization          | Title       |
| ----------    | -----------|
| [Documentation - docs.gitlab.com](https://gitlab.com/gitlab-com/localization/docs-site-localization/-/issues/?sort=created_date&state=opened&label_name%5B%5D=L10n-docs&first_page_size=100) | `~"L10n-docs"`     |
| [Marketing - about.gitlab.com](https://gitlab.com/dashboard/issues?sort=created_date&state=opened&label_name[]=L10n-mktg) | `~"L10n-mktg"`     |
| [Localization engineering work](https://gitlab.com/gitlab-com/localization/docs-site-localization/-/issues?label_name=L10n%3A%3Aengineering) | `~"l10n::engineering"` |

The Localization team uses the following scope labels to categorize documentation engineering work.

| What & Current Issues          | Title       |
| ----------    | -----------|
| [Documentation engineering work to be triaged](https://gitlab.com/gitlab-com/localization/docs-site-localization/-/issues/?sort=created_date&state=opened&label_name%5B%5D=L10n-docs-engineering%3A%3Atriage&first_page_size=100)| `~"l10n-docs-engineering::triage"`   |
| [Documentation engineering work required for launch](https://gitlab.com/gitlab-com/localization/docs-site-localization/-/issues/?sort=created_date&state=opened&label_name%5B%5D=L10n-docs-engineering%3A%3Alaunch-required&first_page_size=100)| `~"l10n-docs-engineering::launch-required"` |
| [Documentation engineering work post launch](https://gitlab.com/gitlab-com/localization/docs-site-localization/-/issues/?sort=relative_position&state=opened&label_name%5B%5D=L10n-docs-engineering%3A%3Apost-launch&first_page_size=100)| `~"l10n-docs-engineering::post-launch"`  |

#### Iteration Board #9140637 

Board: https://gitlab.com/groups/gitlab-com/localization/-/boards/9140637

Displays all issues with ~"L10n::engineering" label assigned to current [Localization engineering iterations](https://gitlab.com/groups/gitlab-com/localization/-/cadences/)  

#### Docs Engineering (Stream) Boards #7828627

Board: https://gitlab.com/groups/gitlab-com/localization/-/boards/7828627

Tracks all documentation-related engineering tasks in the Localization project. This board displays all issues with both ~"L10n-docs" and ~"L10n::engineering" labels.

## Internationalized Documentation - docs.gitlab.com

The GitLab docs site is beeing enabled for internationalization, with initial support for Japanese translations.
https://docs.gitlab.com/ja-jp/

### Translation content sources

Translated content for https://docs.gitlab.com is pulled from separate `/doc-locale/` directories in the following repositories:

* [GitLab](https://gitlab.com/gitlab-org/gitlab/-/tree/master/doc-locale/) 
* [Operator](https://gitlab.com/gitlab-org/cloud-native/gitlab-operator/) 
* [Omnibus](https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/doc-locale/)  
* Runner  
* [Charts](https://gitlab.com/gitlab-org/charts/gitlab/-/tree/master/doc-locale/)

### Translation environments

We maintain two separate environments that contain all projects used to compile docs.gitlab.com. These contain forks of the upstream projects.

**Production environment**: [localization/tech-docs-forked-projects/prod/](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/prod/)

**Test environment**: [localization/tech-docs-forked-projects/test/](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/test/)

Each project within these environments maintains the following branch structure:

1. **main** Used exclusively for pulling upstream changes into our fork. Do not contribute to this branch.
2. **main-translation** Used for delivering translations from our Translation Management System (TMS). Do not contribute to this branch.

### Translation Preview 

Our production fork of the gitlab-docs project includes a dedicated branch for internationalization development:

`main-development` – Our i18n feature development environment that:

* Builds localized documentation routes  
* Enables review apps using translations from production forks' `main-translation` branches  
* Allows the team to review translations before upstream deployment

The setup is documented in this merge request: [https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/prod/gitlab-docs/-/merge_requests/31](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/prod/gitlab-docs/-/merge_requests/31)

The review app provides a comprehensive testing environment that:

* Consolidates translated content from all five documentation repositories (GitLab, Operator, Omnibus, Runner, Charts)  
* Maintains production-identical build pipelines  
* Leverages Hugo's built-in i18n features  
* Enables pre-production review of internationalized documentation and feature development

**Note**: The preview doesn't automatically sync with `main-translation` fork updates. To incorporate the latest translation changes, manually trigger a new pipeline.

### Enabling i18n in Production

The i18n features are now deployed to production. To toggle the translated site:

1. Edit `config/_default/hugo.yaml`  
2. Change the language setting:

```yaml
languages.ja-jp.disabled: false
```

This single configuration change activates/deactivates the entire translated documentation site.

## Localization engineering by partnership with Spartan Software

The Localization team partners with [Spartan Software, Inc.](https://gitlab.com/gitlab-com/localization/localization-team/-/issues/41) to develop and maintain the [localization request management system](https://gitlab.com/groups/gitlab-com/localization/-/epics/35) and a suite of microserices and integrations. Spartan Software engineers and architects provide specialized expertise in language technology platforms and integrations.

The suite of various integrations, components and microservcies is referred to by the overarching term of **Argo**. See high level architecture [here](https://gitlab.com/groups/gitlab-com/localization/-/epics/35#note_1963781412), and the GitLab-specific architecture [here](https://gitlab.com/groups/gitlab-com/localization/-/epics/35#note_2526391642).

### Engineering labels and workflow related to Argo

We use the following scoped labels to track Argo engineering work performed by Spartan Software:

| Label | Purpose | Usage |
| ------ | ------------ | ------ |
| `Argo-Engineering` | Core Argo enhancements requiring engineering work from Spartan Software | Applied to all Argo development work |
| `Argo-Engineering::Complete` | Enhancement completed and deployed to production | Applied when Spartan delivers finished work |
| `Argo-Engineering::In Progress` | Active development work being performed by Spartan | Applied when development starts on an enhancement |
| `Argo-Engineering::Ready for Deployment` | Development complete, enhancement ready for review and deployment | Applied when Spartan completes development and testing |

### Argo system components

Argo serves as GitLab's centralized localization technology and management infrastructure, encompassing:

* **Request Management System**: centralized intake and tracking of localization requests across all GitLab content types, both manual or automatic via integrations
* **Translation Management System integrations**: automated connections between GitLab systems and commercial TMS platforms (Phrase, TranslationOS, Contentful, etc.)
* **[Argo GitLab Agent](https://gitlab.com/gitlab-com/localization/argo-gitlab-agent)**: a purpose-built microservice / component of the Argo ecosystenm for specialized localization-related tasks, such as translatable file pre- / post-processing, etc.
* **[Argo-GitLab Integration](https://gitlab.com/gitlab-com/localization/argo-gitlab-integration) aka [GitLab Translation Service](/handbook/engineering/architecture/design-documents/gitlab_translation_service/)**: direct integrations with GitLab projects, merge request workflows, and CI/CD pipelines

### Argo engineering board

The [Argo Development board](https://gitlab.com/groups/gitlab-com/localization/-/boards/9354744?label_name[]=Argo-Engineering) board displays all issues with `Argo-Engineering` labels and provides visibility into:

* Current development work in progress by Spartan Software
* Completed enhancements ready for deployment via relevant [milestones](https://gitlab.com/groups/gitlab-com/localization/-/milestones)
* Planned Argo system improvements and integrations

### Communication channels

`#spartan-software`: Direct Slack communication channel with Spartan Software engineering team

Technical coordination occurs through GitLab issues tagged with appropriate Argo-Engineering labels

This partnership enables the Localization team to maintain sophisticated translation infrastructure while focusing internal engineering team on core localizability, feature development and enhancements for marketing website, GitLab product documentation, and GitLab product.
