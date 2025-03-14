---
title: "GitLab Hosted Runner Compute Minutes"
status: proposed
creation-date: "2024-01-18"
authors: [ "@allison.browne" ]
coach: [ "@fabiopitino", @amknight, @vitallium" ] 
approvers: ["@sgoldstein" ] # Add PM
owning-stage: "~devops::ops section"
toc_hide: true
---

{{< design-document-header >}}

## Problem Summary

For most of the history of 'GitLab Hosted Runners' they have been instance runners (priviously known as shared runners) on GitLab.com. Customers would like to be able to use a GitLab managed runner in other installation types such as on dedicated and and self-managed instances. This is a paradigm shift in a number of ways.

1. **Consumption based billing** - We will no longer pre-pay for minutes for dedicated and self-managed installations, and instead send bills to customers after the month is over.
   - To be determined: if gitlab.com will eventually also move to retroactive billing
   - On .com we likely need to award minutes prior, and drop builds when they exceed those limits, to support the current product requriements and to enable free plan accounts to have access to minutes if we move to pay after use billing.
1. **Customer's GitLab instance ownership** - Customer's will have more access to the GitLab instance on self-managed instances making it unsuitable for storing data that will be used to stop builds that are over the compute minute quota.
   - Customers can tamper with the data through the admin panel (set cost factors for runners, reset minutes)
   - Customers can tamper with the data by owning the infrasturcture on self managed
   - * Authorization/Identity * - We now need more mechanisms to cryptographically prove the data comes from a hosted runner since customers can also register self-managed instance runners on dedicated or self-managed.

Additionally there are existing challenges with the mechanisms we use to track minutes:

1. When the usage data stored at unaggregated at the build level in PostGres we were unable to perform efficent real time querying of the data.
1. To solve for point 1 we created aggregated tables like `ci_namespace_monthly_usages` which suffers from contention on some self-managed instances as all runners for a namespace try to update the same row.
1. The data is better suited for an OLAP store (although postgres can be used for OLAP other data stores may be better suited to this)

## Goals

1. The billing source of truth should be an immutable auditable system 
1. Reduce code and infrastructure complexity by keeping special cases and number of tracking systems to a minimum  
1. Allow for the visualization minutes in GitLab (can be eventually consistent)
1. Allow for up to date minute tracking only from trusted/verifiable from hosted runners
1. Allow for real-time querying of minute consumption per namespace, that is close to real-time
   - We need to cancel builds for some users if they go over their aloted minutes
1. Bills should be generated from the immutable logs using a verifiable means rather than via un-tested ad-hoc reporting
1. For dedicated we have the unique requirement that logs will live inside of each tenant account. 
   - This is not a requirement for self-managed and gitlab.com where a single bucket with keys per customer could suffice.
   - Question: Is there really much of a destinction between sending events via api versus appending to an s3 file 
1. Cost factors for gitlab hosted runners should have a single source of truth

## Proposal

1. Usage logs will be created by runner directly in s3.
1. Add a usage service in `CustomerDot` outside of GitLab that is responsible for 
  - Attributing and transforming the imutable data logs into data to be sent to Zuora
  - Sending the transformed usage data to Zuora
  - Storing aggregated data for purposes of querying gitlab visualizations
     - Question: Will cost factors be applied in Zuora? Can GitLab directly query Zuora for the aggregations?
  - Store and provide query interface for the compute mintes with cost factors applied for each namespace per month 
      - Can't be behind by more than a minute (minute is somewhat arbitrary but it needs to be as close to real time as possible)
1. Each customer will have their own dedicated GitLab runner(s) to execute CI/CD jobs:
   - CopyCustomer A ---> Runner Pool A (dedicated to Customer A)
   - Customer B ---> Runner Pool B (dedicated to Customer B)
   - Customer C ---> Runner Pool C (dedicated to Customer C)
1. For .com and Self Managed usage will be logged to an s3 bucket 

## Design of Architecture for GA

For GA we took on tech debt by having multiple records/ledgers for usage data: 

https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/team/-/issues/6769#1-flow-proposal

