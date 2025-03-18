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

Unfortunately, GitLab's current code is not built to facilitate this need, so we need to carefully consider the changes we can make to the system to make it possible without endangering the stability of the system.

## Motivation

One of the primary examples provided by users seeking to facilitate the tracking of vulnerabilities across multiple branches is when they run multiple versions or deployments of a project concurrently. 

Under this model, an application which an organisation may continue to provide bug and security fixes for older versions is unable to easily detect vulnerabilities in older versions of code using GitLab's integratations. This can lead to users either being forced to use GitLab in unintended ways to facilitate their security scans, or opt to use other tools to facilitate their scanning to avoid this inconvenience.

### Goals

- Facilitate multi-branch vulnerability monitoring and historical tracking
- Provide this functionality in a simple, consistent and cohesive way
- Ensure this functionality is well designed and does not pose a risk to GitLab's stability now or in the long term

## Proposal(s)

### Vulnerability -> Commit binding

An idea that has been broached on numerous occasions is to increase the bonding between tracked vulnerabilities and the repository itself to both reduce the amount of data ingested and tracked while increasing the flexibility of the implementation.

Essentially, while the proposed implementation uses the word "branches", some users have mentioned the desire to track vulnerabilities present as specific branches. To get the best of both worlds and potentially more, the ideal would be to track the actual commit SHA values that a vulnerability is present in. With this it becomes possible for us to search, filter and compare vulnerability information across the history of the respository. This would allow comparisons and tracking of branches, tags, or even commits themselves theoretically. 

Benefits: 

- Comparing any commit to any commit is super simple. Since Tags and Branches are simply identifiers for a sequence of commits, this means we can compare vulnerabilty states very easily.
- Because most commmits are probably present in 

Risks:

- Controlling the scaling for this approach coulb be complicated, or force us to reduce the benefit of doing it in the first place. 

#### Growth Estimation

The GitLab project reports 622566 commits at time of writing. 3153 of which in the last hour. And 50481 branches.
Lets assume a data structure of vulnerability has_many vulnerability_commits, we can track every commit that contains a respective vulnerability. However, as you might guess, this in itself would be a vastly multiplicative proposition. If we propose a worst case that the project contains 10000 vulnerabilities since it existed, then we would create 6_225_660_000 vulnerability_commit records to track this. This is entirely infeasible without improvements.

However, we know that a vulnerability present in a codebase is not functionally different from commit to commit. So what we're actually more interested in, is when a vulnerability started being in a codebase, and when it ceased to be.
Using `git rev-list --ancestry-path 7b4a07a..ecf5891` one can trace back the commit ancestry from one commit sha to another. If we store this commit range in our vulnerability_commit records, then we technically only need a record for every branch. Using our prior example of 10_000 vulnerabilities to the 50_481 branches, we end up with 504_810_000 records. This is still immense, but 1/12 of the amount of records needed compared to tracking per commit.

##### Mitigation - Protected Branches Only

Proposed by Alana Bellucci originally as a potential mitigation to our scaling concerns. The idea is to only track vulnerabilities for protected branches to avoid overingestion and uncontrollable data growth. Ideally we would want to be able to track information for longer, but we need to architect according to our architectural capabilities. The gitlab project currently only has 12 protected branches. Using the proposed vulnerability_commits model with ancestry_path tracking, this means we would would track 120_000 vulnerability_commit records for the gitlab project, which is well within the realm of feasible, though would mean potentially many user cases would go unserved.

##### Mitigation - Branch Assumption

Not all changes in a codebase are going to add or remove vulnerabilities. Frequently, they do neither. So we can likely significantly mitigate the amount of commits we need to track by only tracking vulnerability_commit records for branches that result in one of these two events. It is hard to statistically quantify the impact of this, but if we pessimistically assume 75% of branches affect vulnerability counts in some way, this would reduce the predicted vulnerability_commit records from 504_810_000 to 378_607_500

##### Mitigation - Branch Merging

Branches merged into another branch will have their commits merged into that branch. This means that any vulnerabilities in that branch will begin to present in pipelines executed on the branch it was merged to. As a result, outside of historical/audit purposes, it is likely not necessary to continue tracking vulnerability presence on branches merged to the default branch. We can perhaps consider retaining this information for a shorter duration or otherwise culling it fully in the interest of preserving stability and feasibility of the feature. If we only track vulnerabilities for the default branch + branches that are not currently merged to it, the amount of distinct vulnerability paths we would potentially need to track drops down to 134 per vulnerability if we assume every vulnerability exists in every branch (as a worst case.) This brings us to a merge 134_000 vulnerability_commit messages for gitlab using the 10_000 example.

##### Combining Mitigations

If we consider the Branch Merging mitigation to be a sufficient case where we may only be interested in vulnerabilities on unmerged branches, we are currently tracking 134_000 vulnerability_commits. If we then add the Branch Assumption mitigation in which we do not track records for branches where no change to the vulnerability counts occurs, we can use the same pessimistic assumption and drop this by a further 25% to only 101 branches we'd need track, and thus 101_000 vulnerability_commit records to track.

### Potential Risks / Problems

#### Scalability & Retention

A very important subject in GitLab currently is the correct application of retention policies to data to avoid eternal storage of unused information. We are already in the process of implementing a [retention policy for vulnerability](https://gitlab.com/groups/gitlab-org/-/epics/12229) information based on the age of the vulnerability.

Beginning to track vulnerability infomration across multiple branches may increase the amount of vulnerability information we ingest and hold. Some questions we need to consider is depending on how much more information this causes us to start tracking, how will this affect our desired retention policies?

Theoretically, it should be okay to continue to apply our existing retention policy of 12 months to vulnerability data tracked across all branches, but the danger here is that this could signifcantly expand the amount of data we store in the database at a given time. As this can have a variety of knock-on performance impacts, it's something for us to design around and test carefully.

### Ingestion and Processes

The majority of GitLab has been written in such a way that most services and processes operate under the expectation that a vulnerability is a singular entity (even despite the 1 to many relationship with vulnerability_occurrences). As a result, we may encounter a significant amount of potential issues in application logic depending on how we approach the implementation.

## Other Considerations

### ElasticSearch

Search and filter mechanisms for vulnerabilities in GitLab are already struggling to work in GitLab at the scale of very large users, and has required significant optimisation to make possible.

Without significant modification, it is unlikely that we will be able to use our existing implementations to facilitate search and filtering once we begin tracking vulnerabilities across multiple. 

However, we are in progress implementing the ingestion of vulnerabililties into ElasticSearch to enable more powerful search and filtering functionalities for GitLab.com at our very large data scales. This implementation will likely be very useful to facilitate search and comparison across branches as we begin to track data for non-default branches. 
