---
title: "Current Organization"
owning-stage: "~devops::tenant scale"
group: Organizations
toc_hide: true
---

We will ensure that the current organization id is defined on every request.

The organization will be determined in the following order of precedence:

1. Header field. Specifically for browser based API requests
1. Path params. E.g. /groups/abc-group, /-/organizations/my-organization
1. Session variable storing current organization id. More discussion below.
1. The Organization the current user belongs to. I.e. `current_user.organization`
1. The default organization (ID = 1).

The session variable will assist to disambiguate on pages such as `/explore` and will reduce the roadmap to dog fooding.
We don't consider session variable usage a long term solution because it will break browser tab usage, and HTTP GET requests won't be idempotent breaking bookmarks and sharing of links.
Features that depend on the session variable will be considered incomplete until they are scoped appropriately.

We will default to the Default Organization as a last resort.
We anticipate this to be needed for unauthenticated requests that access ambiguous end points.
Use of the Default Organization will break Cells compatibility.
