---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Universal Build Toolchain
status: proposed
creation-date: "2025-02-06"
authors: [ "@dmakovey" ]
coaches: [ "@denisra" ]
dris: [ "@mbruemmer", "@denisra" ]
owning-stage: "~devops::systems"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

## Summary

GitLab supports packages on multiple hardware architectures such as `x86_64`
and `arm64`. Today the Build team maintains a toolchain per each supported
distribution method and hardware architecture. This approach does not scale.

The Build team wants to reduce maintenance burden, eliminate specific classes of
failure, and improve confidence in what we ship through simplification. The
Universal Build Toolchain allows GitLab to use one toolchain per supported
hardware architecture. This eliminates significant toil and insulates Gitlab
from known unknown issues related to the Linux Kernel and the core libraries
that underpin every GitLab component.

## Motivation

GitLab maintains toolchains per each supported:

- Distribution method.
    - Omnibus GitLab
    - Cloud Native GitLab
    - GitLab Development Kit
- Linux Distribution.
    - Enterprise Linux
    - Debian
    - Ubuntu
    - OpenSUSE
    - SUSE Enterprise Linux
    - AmazonLinux 2023
    - AmazonLinux 2
- Linux Distribution version.
- Hardware Architecture.
    - `x86_64` / `amd64`
    - `arm64`

Each pipeline created by this combination produces similar if not equivalent
results. This wastes considerable amounts of runner time in addition to the high
toil burden required to maintain so many variants. This method also hides
potential problems from feature teams who may build with a newer toolchain than
supported in GitLab's own production environment or customer environments.

### Goals

The Universal Build Toolchain will allow GitLab to build each component with one
and only one builder per each supported hardware architecture.

Success will be measured when:

- Omnibus GitLab only had one build/toolchain image per each hardware architecture.
- Cloud Native GitLab uses the same build/toolchain as Omnibus GitLab for
  supported hardware architectures.

Side effects:

- Reduced maintenance toil enables time to package components for GDK for parity
  with production builds.
- Lowers validation time because there is one and only one build to check per
  each hardware architecture.

### Non-Goals

<!--
Listing non-goals helps to focus discussion and make progress. This section is
optional.

- What is out of scope for this document?
-->

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

Build an insulated toolchain that is independent of OS and only tied to
"OS platform-architecture" pair ("linux-arm64", "linux-amd64", etc.)


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

To accomplish set Goals we will require several components to be in place:

1. Infrastructure capable of building Universal Build Toolchain insulated from underlying OS.
   * From experimentation we have established that insufficiently insulated
     build infrastructure may "leak" system calls to underlying OS altering
     build behaviours and undermining system tests etc.

2. Tools enabling assembly of reproducible and flexible Build Toolchains.
   * We can take inspiration from current source-built toolchains like:
     * FreeBSD `world`
     * FreeBSD `ports`
     * Gentoo Linux `ebuild`/`portage`
   * Implementation can borrow heavily from experience and expertise of Linux
     From Scratch project. It too has to bootstrap "alien" toolchain within the
     currently running OS that may not necessarily share all the traits of
     target toolchain.
3. Present tools need to be adjusted to accept outputs produced by Universal
   Build Toolchain.
   * At present our tooling assumes full control over build thus will need to be
     adjusted to accept "external" binary artifacts.

## Alternative Solutions

<!--
It might be a good idea to include a list of alternative solutions or paths considered, although it is not required. Include pros and cons for
each alternative solution/path.

"Do nothing" and its pros and cons could be included in the list too.
-->

Alternatively we can continue on current path. However as math above shows that
path is not very sustainable as our efforts grow in a non-linear fashion with
addition of platforms and architectures into supported platforms and
architectures matrix.
