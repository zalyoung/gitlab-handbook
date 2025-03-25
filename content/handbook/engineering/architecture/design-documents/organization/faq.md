---
title: "Organization: Frequently Asked Questions"
owning-stage: "~devops::tenant scale"
group: Tenant Scale
toc_hide: true
---

## Do we expect large SaaS customers to be licensed at the Organization level?

Yes. At the moment billing will move to the Organization level. We will continue to update [Organization and Billing](billing.md).

## Do we expect to be able to configure alternate GitLab domain names for Organizations (such as `customer.gitlab.com`)?

There is no plan at this point to allow configuration of alternate GitLab domain names.
We have previously heard that sub-domains bring administrative challenges.
GitLab Dedicated will be a much better fit for that at this moment.

## Do we expect Organizations to have visibility settings (public/private) of their own?

Visibility is documented on the main [Organization page](_index.md) and also [Organization Users](users.md).

## What would the migration of a feature from the top-level Group to the Organization look like?

We will provide more information at a later date. It won't be possible to build a feature completely at the Organization level until the Organization feature is released.

However, data at the top-level group will still need to be linked back to an Organization for Organization data isolation purposes.
