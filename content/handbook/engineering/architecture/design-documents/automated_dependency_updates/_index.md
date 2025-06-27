---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Automated dependency updates
status: proposed
creation-date: "2025-06-17"
authors: [ "@hacks4oats" ]
coaches: [ "@mbenayoun" ]
dris: [ "@johncrowley", "@nilieskou" ]
owning-stage: "~devops::application security testing"
participating-stages: [ ~"devops::application security testing" ]
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< engineering/design-document-header >}}


## Summary

Automated dependency updates is a feature that will be responsible of keeping
project dependencies up to date. Keeping project dependencies up to date is
widely considered a good practice. Doing this ensures that the latest bug fixes,
performance enhancements, and security patches are applied to project
dependencies. The process of checking for and applying dependency updates is
quite often simple, but time consuming. The Automated Dependency Updates feature
aims to free up user time by automating this often manually done process.

## Motivation

Existing dependency management tools like [Renovate] and [dependabot-core]
can automate the process of checking for updates and can also create merge
requests with the updates found. They however suffer from some limitations:

- Installation can be difficult to scale up[^1]
- Users are required to manage the required access tokens which adds
configuration overhead
- They often run abitrary code which requires additional security controls[^2][^3]
- The dependency updates proposed by the tools lack critical context like if the
updates resolve a vulnerability, and if it resolves a vulnerability what the
severity is.

### Goals

- Automated MR creation for **non-breaking** dependency updates
- Zero or low config feature enablement
- Allow for integration with GitLab Duo

### Non-Goals

- Custom dependency managers like the ones supported by [Renovate]
- Automated MR creation for **breaking** dependency updates

## Proposal

<!--
This is where we get down to the specifics of what the proposal actually is,
but keep it simple!  This should have enough detail that reviewers can
understand exactly what you're proposing, but should not include things like
API designs or implementation. The "Design Details" section below is for the
real nitty-gritty.

You might want to consider including the pros and cons of the proposed solution so that they can be
compared with the pros and cons of alternatives.
-->

Dependency management is inherently a complex problem space. While it's possible
to build a completely greenfield solution, it's a much more efficient option to
use an off the shelf tool that's been heavily used, and proven to work well. To
that effect, we've chosen to use the [dependabot-core] library to power our
automated dependency updates. The following pros and cons were considered while
evaluating this library as an option.

**Pros**:

- Diverse list of supported ecosystems
- Receives frequent contributions from core contributors and the open source community
- Written in a language that's heavily used at GitLab (Ruby)

**Cons**:

- Requires dependencies like interpreters and runtime managers[^4]
- Designed to run as an isolated CI/CD job, and not in the context of something
  like a Sidekiq worker
- Security recommendations require running a dependency proxy for private
  registries
- Only allows indirect dependency updates for projects that have a lock file

Despite some drawbacks, [dependabot-core] provides substantial benefits, and
allows us to delivery a solution that works for a wide percentage of our users.
Therefore, we'll be using [dependabot-core] in our automated dependency updates
feature.

## Design and implementation details

<!--
This section should contain enough information that the specifics of your
change are understandable. This may include API specs (though not always
required) or even code snippets. If there's any ambiguity about HOW your
proposal will be implemented, this is the place to discuss them.

If you are not sure how many implementation details you should include in the
document, the rule of thumb here is to provide enough context for people to
understand the proposal. As you move forward with the implementation, you may
need to add more implementation details to the document, as those may become
valuable context for important technical decisions made along the way. A
document is also a register of such technical decisions. If a technical
decision requires additional context before it can be made, you probably should
document this context in a document. If it is a small technical decision that
can be made in a merge request by an author and a maintainer, you probably do
not need to document it here. The impact a technical decision will have is
another helpful information - if a technical decision is very impactful,
documenting it, along with associated implementation details, is advisable.

If it's helpful to include workflow diagrams or any other related images.
Diagrams authored in GitLab flavored markdown are preferred. In cases where
that is not feasible, images should be placed under `images/` in the same
directory as the `index.md` for the proposal.
-->

## Alternative Solutions

### Bootstrap our own dependency management service

This is a fairly large task that would require us to implement version
resolution for a large amount of package managers over time, but it does have
some advantages.

**Pros**:

- Bump version ranges for projects that **do not** have a lock file
- No need to install dependencies locally

**Cons**:

- Requires a large amount of work to support the same ecosystems of existing
  tools like [Renovate] or [dependabot-core].

[^1]: For example, Renovate requires [global access or an allow list](https://docs.renovatebot.com/getting-started/installing-onboarding/#repository-installation).
[^2]: Renovate may execute [arbitrary code](https://docs.renovatebot.com/security-and-permissions/#execution-of-code),
    and often recommends using an allow list of user commands.
[^3]: dependabot-core may execute [arbitrary code](https://github.com/dependabot/dependabot-core#private-registry-credential-management)
    and requires the user to configure the job to run in isolation from access tokens for added security.
[^4]: For example, Python and PyEnv are required to run
    `dependabot-core/python`.

[Renovate]: https://docs.renovatebot.com/
[dependabot-core]: https://github.com/dependabot/dependabot-core#
[remote registry configuration]: https://docs.gitlab.com/user/packages/package_registry/dependency_proxy/#configure-the-remote-registry
