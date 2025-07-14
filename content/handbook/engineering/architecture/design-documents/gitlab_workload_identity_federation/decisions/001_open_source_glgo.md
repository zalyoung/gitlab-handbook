---
title: 'GitLab WLIF: STS-001 Open source GLGO'
toc_hide: true
---

## Context

We built GLGO as an identity translation layer between GitLab and Google Cloud
Platform / AWS. Now we plan to extend it to become a generic-purpose GitLab
Secure Token Service: a service which will be able to mint tokens users will
then be able to use to authenticate against GitLab APIs.

## Decision

Make GLGO open-source project, using permissive licensing.

## Consequences

GLGO will be available for the community to audit and contribute to.

## Alternatives

Keeping GLGO as a closed-source project will limit its availability in GitLab
distribution packages, which can hinder our plans to deliver GitLab WLIF and
other engineering projects which could depend on us having GLGO available
everywhere.

We can build the functionality which today belongs to GLGO inside GitLab Rails,
but this would not provide sufficient isolation of authentication data and
signing material from the rest of GitLab monolith.
