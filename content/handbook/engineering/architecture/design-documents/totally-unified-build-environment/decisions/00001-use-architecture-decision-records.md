---
title: 'Totally Unified Build Environment ADR 001: Use architectural decision records'
owning-stage: "~devops::systems"
toc_hide: true
---

## Decision

Use architectural decision records in Markdown format (MADR). Store the
metadata information as YAML front matter.

## Context

To simplify project documentation, move decisions into a clear format that
can eventually be searchable and indexed. This prevents extraneous
information that makes implementation more difficult and makes it easier for
new contributors to understand the design.

## Rationale

Examined [`adr-tools`](https://github.com/npryce/adr-tools) and
[`madr-tools`](https://github.com/butonic/adr-tools).

The additional tools do not add much to the process. For simplicity of the
first iteration, an example record is provided to be used by decision
record authors.

The format choice both extracts metadata into a machine readable format and
supports the future move to `hugo` for GitLab documentation.

## Resources and additional information

- [MADR](https://adr.github.io/madr/)
- MADR decision to [use YAML front matter for metadata](https://adr.github.io/madr/decisions/0013-use-yaml-front-matter-for-meta-data.html)
- GitLab Handbook [Engineering > Architecture > Architecture Design Workflow](../../engineering/architecture/workflow/_index.md#design-document)
- [GitLab Handbook Hugo Migration]((https://gitlab.com/gitlab-org/technical-writing-group/gitlab-docs-hugo).
