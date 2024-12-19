---
title: "GitLab Hosted Runner Compute Minutes"
status: proposed
creation-date: "2024-01-18"
authors: [ "@allison.browne" ]
coach: [ "@fabiopitino" ] # note add fullfillment engineer as coach, and perhaps someone from dedicated inf
approvers: [ "@jreporter", "@sgoldstein" ]
owning-stage: "~devops::ops section"
toc_hide: true
---

{{< design-document-header >}}

## Problem Summary

For most of the history of 'GitLab Hosted Runners' they have been instance runners(aka shared runners) on GitLab.com. Customers would like to be able to use a GitLab managed runner in other installation types such as on dedicated and and self-managed instances. This is a paradigm shift in a number of ways.

1. **Retroactive billing** - We will no longer pre-pay for minutes for dedicated and self-managed installations, and instead send bills to customers after the month is over.
   - To be determined: if gitlab.com will eventually also move to retroactive billing
   - On .com we likely need to award minutes prior to cance
1. **Customer's instance ownership** - Customer's will have more access to the GitLab instance making it unsuitable for storing data that wil be used to stop builds that are over the compute minute quota.
   - Customers can tamper with the data through the admin panel (set cost factors for runners, reset minutes)
   - Customers can tamper with the data by owning the infrasturcture on self managed
   - We now need more mechanisms to cryptographically prove the data comes from a hosted runner since customers can also register self-managed instance runners on dedicated or self-managed.

Additionally there are existing challenges with the mechanisms we use to track minutes:

1. When the data when stored at granualarly and unaggregated at the build level we are unable to perform efficent real time querying of the data.
1. To solve for point 1 we created aggregated tables like ci_namespace_monthly_usages which suffers from contention on some self-managed instances as all runners for a namespace try to update the same row.
1. The data is better suited for an OLAP store (although postgres can be used for OLAP other data stores may be better suited to this)

## Goals

1. The billing source of truth should be an immutable auditable system
2. Reduce code and infrastructure omplexity by keeping special cases and number of tracking systems to a minimum  
3. Allow for the visualization of the minutes in GitLab
4. Allow for up to date and trusted/verifiable minute accumulation which is close to real-time, since we need to cancel builds for at least free users if they go over their aloted free trail minutes

## Challenges


## Proposal
