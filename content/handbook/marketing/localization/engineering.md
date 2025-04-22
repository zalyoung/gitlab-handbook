---
title: Localization Engineering
description: Technical details of GitLab's localization infrastructure and engineering processes.
---

## Internationalized Documentation 

### Tooling

The GitLab docs site has been enabled for internationalization, with initial support for Japanese translations.

### Translation content sources

Translated content for docs.gitlab.com is pulled from separate `/doc-locale/` directories in the following repositories:

* GitLab  
* Operator  
* Omnibus  
* Runner  
* Charts

### Translation environments

We maintain two separate environments for translation work:

**Production environment**: [localization/tech-docs-forked-projects/prod/](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/prod/)

**Test environment**: [localization/tech-docs-forked-projects/test/](https://gitlab.com/gitlab-com/localization/tech-docs-forked-projects/test/)

### Branch structure

Each project within these environments maintains the following branch structure:

1. **main** Used exclusively for pulling upstream changes into our fork. Do not contribute to this branch. 
2. **main-translation** Used for delivering translations from our Translation Management System (TMS). Do not contribute to this branch.  
3. **main-development** This is our development workspace for i18n features.

#### Branch maintence 

To be added here

### Local development workflow

When working on i18n features:

1. Always use the **main-development** branch for development work  
2. Follow the standard merge request review process for any changes  
3. Test thoroughly using the actual translations available in the branch  
4. Once approved, changes can be submitted upstream to the original repositories

This workflow ensures we can develop and validate i18n features in an environment with real translations before integrating them with the primary codebase.
