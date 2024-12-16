---
title: "Rate Limiting Troubleshooting"
description: "This documentation is intended to aid in investigations related to GitLab.com rate limiting and potential IP blocks."
---

## Overview

Troubleshooting rate limiting issues can be complicated,
particularly as requests can be throttled at different layers of our stack.
This page provides GitLab team members (who have the correct permissions) steps to follow
in order to find where a customer's request has been rate limited, and why.

## Has a request been rate limited?

Rate limited requests will return a `429 - Too Many Requests` response.

## What layer is rate limiting the request?

All traffic to GitLab.com is subject to rate limiting,
there are different [limits](/handbook/engineering/infrastructure/rate-limiting/#limits) applied at Cloudflare and within the Application.

Note: If you are troubleshooting rate limiting issues for GitLab Pages or Registry, see [other rate limits](/handbook/engineering/infrastructure/rate-limiting/#other-rate-limits) for details on how these are configured.

The following diagram should aid you in determining where to look first,
and for further detail scroll down to the related section.

```mermaid
flowchart TD

    http[HTTP request] --> 429
    429[Was there a 429 response?]

    not-limited[The request was likely not rate limited]
    header[Does the response contain RateLimit-* Headers?]

    subgraph Cloudflare
        c-status[Filter the Cloudflare Dashboard by status code]
        c-http[Did you find the request in the Cloudflare Dashboard?]
    end

    subgraph Application
        r-logs[Did you find the request in the RackAttack logs?]
        a-logs[Did you find the request in the ApplicationRateLimiter logs?]
    end

    yay[You hopefully found what you were looking for!]
    sre[Request SRE help]

    429 -- no --> not-limited
    429 -- yes --> header

    not-limited --> c-status

    header -- no --> c-http
    header -- not sure --> c-http
    header -- yes --> r-logs

    c-status --> yay
    c-http -- yes --> yay
    r-logs -- yes --> yay
    a-logs -- yes --> yay

    c-http -- no --> r-logs
    r-logs -- no --> a-logs

    a-logs -- no --> sre
    yay -- still require assistance?--> sre
```

### Rate Limit Response Headers

Sometimes users will see `RateLimit-*` response headers when a request has been rate limited;
this depends on the layer that has throttled the request.
For example, Cloudflare does not return a `RateLimit-*` response header.
This behaviour is better documented in the [Rate Limiting Headers](/handbook/engineering/infrastructure/rate-limiting/#headers) section of the handbook.

The presence (or absence) of these headers can be used to signal where to start your investigation,
as the `RackAttack` rate limits configured in the Application return these response headers on throttled requests.

### Cloudflare

GitLab employees with access can use SSO to login to our Cloudflare account.
To do so, enter your GitLab email and the `Log in with SSO` option will appear.

#### Quick Links

- [Cloudflare Overview: gitlab.com domain](https://dash.cloudflare.com/852e9d53d0f8adbd9205389356f2303d/gitlab.com)
- [Analytics & Logs: HTTP Traffic for gitlab.com](https://dash.cloudflare.com/852e9d53d0f8adbd9205389356f2303d/gitlab.com/analytics/traffic)
- [Security Events for gitlab.com](https://dash.cloudflare.com/852e9d53d0f8adbd9205389356f2303d/gitlab.com/security/events)

#### HTTP Traffic Analytics

![Cloudflare HTTP Traffic Analytics](/images/handbook/engineering/infrastructure/rate-limiting/troubleshooting/cloudflare-http-traffic-analytics.jpeg)

##### 1. Apply Filters

There are a number of filters that can be applied when looking at HTTP traffic.
A few useful filters to be aware of:

- `Source IP` - filter by the customer's IP address.
- `Edge status code` - this is the response code from Cloudflare.
- `Origin status code` - this is the response code from GitLab.

For example, seeing that the Edge status is different
to the Origin status returned from GitLab
could be an indication that a request isn't making it past Cloudflare.

You can apply as many filters as required,
then scroll down to see the results.
The default view will return the top 5 items,
but this can be increased to 15 items if required.

###### 2. Select custom date range

Doing so serves two purposes:

1. It narrows your search to a specific time period.
1. It allows you to share a URL with a snapshot view with colleagues, whereas the `Previous 24 hours` will return a rolling window.

#### Security Events

### HAProxy

### Application

#### RackAttack

#### ApplicationRateLimiter

### Requesting further assistance
