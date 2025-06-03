---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Introduce Push Events for Pages
status: proposed
creation-date: "2025-06-03"
authors: [ "@janis" ]
coaches: [ "@username" ]
dris: [ "@mmacfarlane", "@acroitor" ]
owning-stage: "~plan::knowledge"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---
<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< engineering/design-document-header >}}

## Summary

We replace Pages' internal API response caching with an event-based push
mechanism that synchronises the Go processes' state with the Rails backend
independently of browser requests. This would ensure both a reduced load on the
internal API and improve performance for Pages sites independent of their popularity.

## Motivation

When a browser requestes a pages site, the Pages process requests the information about
the location of the files, authentication instructions etc. from the Rails internal
API.

As the popularity of GitLab Pages grew, the load on the internal API increased, so
we've introduced API response caching: The go process keeps the API response for that
Pages domain in memory for about 5 minutes and won't refetch it from the API during
that time.

While this did relieve some load on the API, it has the drawback that Pages site updates
are often not immediate, there may be version mismatches when multiple pages processes
are involved. The caching also only has an effect for sites that are requested more often 
than once per 5 minute interval. So a potential performance benefit is not available to
the long-tail of less popular Pages sites.

Moving to push state updates from Rails to Go instead of pulling it based on a browser
request would not only reduce the load on the internal API by orders of magnitude, it
would also improve the overall performance of Pages sites: We could entirely omit the
need for a roundtrip to the Rails API that currently happens on every (un-cached)
request.

### Goals

- Make Pages updates and deployments immediately available to the Pages go process
- Reduce the load on the Pages API
- Remove the need to make an inernal API request on every Pages request

## Proposal

## Design and implementation details

1. Creating an internal state DB for Pages

    We add an (ephemeral) database to the pages process, possibly with SQLite or 
    something like [go-memdb](https://github.com/hashicorp/go-memdb). The database
    receives its initial state on process startup by requesting all pages data
    from Rails via a paginated API request.

2. Connecting Pages to Redis

    Pages will be connected to Redis and subscribed to Pages-specific events

3. State updates via Redis Events

    Whenever a change happens (deployment or settings change), a Redis event
    referencing the changed domain will be created. Upon receiving this event,
    the Pages process performs the internal API request for that domain and
    updates its internal state accordingly.

4. State synchronisation hardening

    Since we're weakening the SSOT-approach to state with this we should also
    think about how to ensure the state is eventually properly synchronised. 

    We could compare the hashes the rails backend and the go DB produce at an
    agreed-upon time, and refetch the state if it does not match, but belated
    events may thwart that approach

    We could regularly refetch the entire state from the API no matter what,
    but the performance implications of that are unknown.

    Or we could poll the data piecewise (every 5 minutes one domain will be
    refetched).
