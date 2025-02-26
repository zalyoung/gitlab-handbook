---
title: "Managing Limits"
description: ""
---

## Overview

TODO: Write overview for why these processes are important

## Where to configure the limit

Use the following diagram to determine where the limit should be configured,
then follow the corresponding guidance for the appropriate configuration method.

```mermaid
flowchart TD
    selfmanaged[Should GitLab.com and Self-Managed match?]

    ip-one[Is throttling by IP sufficient?]
    ip-two[Is throttling by IP sufficient?]

    dedicated[Should GitLab.com and Dedicated match?]

    subgraph layer[Configure the limit in...]
        subgraph app[Application]
            rackattack[RackAttack]
            appratelimiter[ApplicationRateLimiter]
        end
        subgraph cf[Cloudflare]
            cloudflare-waf-module
            custom-rule
        end
    end

selfmanaged -- no --> ip-one
selfmanaged -- yes --> ip-two

ip-one -- yes --> dedicated
ip-one -- no --> appratelimiter

ip-two -- yes --> rackattack
ip-two -- no --> appratelimiter

dedicated -- yes --> cloudflare-waf-module
dedicated -- no --> custom-rule
```


## Evaluation

Rate limits should be enabled by default. If we are considering introducing new limits enabling or changing a limit, we should do an evaluation first.

1. Determine if a rate limit already exists
  -

### Cloudflare

TODO: Talk about process of setting in log mode, whether to create in cloudflare-waf-module or custom-rule, how to validate the potential impact, engaging with customers, etc.

### Application

TODO: Break down by RackAttack and ApplicationRateLimiter, reference existing documentation.

## Continued

- Get Approval
- Raise a Change Request
