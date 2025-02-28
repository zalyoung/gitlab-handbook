---
title: "Track Vulnerabilities Across Multiple Branches"
status: proposed
creation-date: "2025-02-28"
authors: [ "@ghavenga" ]
approvers: [ ]
coach: ["@theoretick"]
owning-stage: "~group::security_infrastructure"
participating-stages: ["~group::security_insights"]
toc_hide: true
---

{{< design-document-header >}}

## Summary

Perhaps one of the most in demand features for GitLab currently is the ability to [track vulnerabilities across multiple branches](https://gitlab.com/groups/gitlab-org/-/epics/3430). While the current implementation of vulnerability management features in GitLab offers a lot of power, the implementation is very inflexible. As a result, workflows which may involve running different versions of an application, be that old releases or modified versions are unable to track vulnerabilities without forking the code to seperate projects entirely.

Unfortunately, GitLab's current code is not built to facilitate this need, so we need to carefully consider the changes we can make to the system to make it possible without endagnering the stability of the system.

## Motivation

One of the primary examples provided by users seeking to facilitate the tracking of vulnerabilities across multiple branches is when they run multiple versions or deployments of a project concurrently. 

Under this model, an application which an organisation may continue to provide bug and security fixes for older versions is unable to easily detect vulnerabilities in older versions of code using GitLab's integratations. This can lead to users either being forced to use GitLab in unintended ways to facilitate their security scans, or opt to use other tools to facilitate their scanning to avoid this inconvenience.

### Goals

- Facilitate multi-branch vulnerability monitoring and historical tracking
- Provide this functionality in a simple, consistent and cohesive way
- Ensure this functionality is well designed and does not pose a risk to GitLab's stability now or in the long term

## Proposal

An idea that has been broached on numerous occasions is to increase the bonding between tracked vulnerabilities and the repository itself to both reduce the amount of data ingested and tracked while increasing the flexibility of the implementation.

Essentially, while the proposed implementation uses the word "branches", some users have mentioned the desire to track vulnerabilities present as specific branches. To get the best of both worlds and potentially more, the ideal would be to track the actual commit SHA values that a vulnerability is present in. With this it becomes possible for us to search, filter and compare vulnerability information across the history of the respository. This would allow comparisons and tracking of branches, tags, or even commits themselves theoretically. 



### Potential Risks / Problems

#### Scalability & Retention

A very important subject in GitLab currently is the correct application of retention policies to data to avoid eternal storage of unused information. We are already in the process of implementing a [retention policy for vulnerability](https://gitlab.com/groups/gitlab-org/-/epics/12229) information based on the age of the vulnerability.

Beginning to track vulnerability infomration across multiple branches may increase the amount of vulnerability information we ingest and hold. Some questions we need to consider is depending on how much more information this causes us to start tracking, how will this affect our desired retention policies?

Theoretically, it should be okay to continue to apply our existing retention policy of 12 months to vulnerability data tracked across all branches, but the danger here is that this could signifcantly expand the amount of data we store in the database at a given time. As this can have a variety of knock-on performance impacts, it's something for us to design around and test carefully.

## Other Considerations

### ElasticSearch

Search and filter mechanisms for vulnerabilities in GitLab are already struggling to work in GitLab at the scale of very large users, and has required significant optimisation to make possible.

Without significant modification, it is unlikely that we will be able to use our existing implementations to facilitate search and filtering once we begin tracking vulnerabilities across multiple. 

However, we are in progress implementing the ingestion of vulnerabililties into ElasticSearch to enable more powerful search and filtering functionalities for GitLab.com at our very large data scales. This implementation will likely be very useful to facilitate search and comparison across branches as we begin to track data for non-default branches. 

## Alternate Approache(s) to Consider

When we first began considering how we might support tracking vulnerabilities across multiple branches and first considered the potential scalability risks involved, it was proposed that we limit tracking to only "protected branches" to limit the impact of the implementation. This is worth keeping in mind if 