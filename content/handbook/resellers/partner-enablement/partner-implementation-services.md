---
title: "Channel Partner Implementation Services"
---

<link rel="stylesheet" type="text/css" href="/stylesheets/biztech.css" />

## Deciding between GitLab Community and Enterprise Editions

GitLab has [two distributions](https://about.gitlab.com/install/ce-or-ee/):

- **Enterprise Edition (EE)**: built from the [official GitLab repository](https://gitlab.com/gitlab-org/gitlab). It contains the code of [all license tiers](https://about.gitlab.com/pricing/), including the open-source code of Free and the proprietary code of Premium and Ultimate.

- **Community Edition (CE)**: built from the [open source fork of GitLab](https://gitlab.com/rluna-gitlab/gitlab-ce). It contains only the [MIT licensed](https://opensource.org/license/mit) code from the EE repository above, synced with that one automatically.

This means that both editions contain the exact same version of our Free features, but only EE contains Premium and Ultimate features.

### Which one should I install for my customer?

#### Premium or Ultimate customers

No choice: you need to install EE.

#### Free customers

The rule of thumb is: always go with EE, except when you can't.

Upsides of installing EE:

1. No need to do a [migration](./partner-migration-services.md) when your customer decides to upgrade to Premium or Ultimate.

2. Optionally get access to free Premium or Ultimate features through our [Registration Features Program](https://docs.gitlab.com/ee/administration/settings/usage_statistics.html#registration-features-program). You can find the list of those features [here](https://docs.gitlab.com/ee/administration/settings/usage_statistics.html#available-features).

**Then why would anybody go with CE?**

There are some customers who are mandated to use open source tools that has a license compatible with their internal policies. Since CE is licensed under the extremely permissive [MIT license](https://opensource.org/license/mit), it can generally satisfy any of those requirements. Thus, the only reason to install CE is if the customer explicitly asks for it. Otherwise, start with EE: even if the customer decides not to share usage statistics with us, it'll still be just a flick of a switch for them to upgrade to Premium or Ultimate later.
