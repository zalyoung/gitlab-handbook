---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Mature Automated Deployment and Management of Self-Managed GitLab
status: proposed
creation-date: "2024-12-12"
authors: [ "@bwilkerson13", "@grantyoung" ]
coaches: [ "@username" ]
dris: [ "@product-manager", "@engineering-manager" ]
owning-stage: "~devops::platforms"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

## Summary

There is a demonstrated appetite for automating the deployment and management of a GitLab instance, using industry-standard Infrastructure-as-Code (IaC) and Configuration Management (CM) tools. Our solution, GitLab Environment Toolkit (GET), is currently a critical enablement tool in the success of self-managed customers, as well as GitLab's own Dedicated and Cells initiatives.

The next step in this journey is to continue building upon GET, and to enhance the operator experience by complimenting it with additional tools that reduce operational burden and lower the cost-of-ownership of GitLab.

To accomplish this, we need to develop a cohesive user journey around the "operator experience", and then the tools and resources required to incorporate it into the foundations of what we do.

## Motivation

GET and Reference Architectures (RAs) are frequently used tools for enabling customer success, as well as being leveraged internally by major cornerstone projects like GitLab Dedicated and the Cells initiative. They are also the downstream sum of GitLab's performance, and GitLab's operational expertise. They cannot be developed or improved in a vacuum.

In order to make meaningful improvements into the future, we have to build a vision, a strategy, and enable everyone to contribute.

Top-to-bottom incorporation of operational excellence will reduce cost-of-ownership, by better facilitating Day 2 operations, and potential cost-savings through championing elasticity of the product.

(Add some of the motivating Issues here)

### Goals

- Improve the elasticity of GitLab by driving awareness and accountability of GitLab at scale -- large AND small.
- Define and develop an IaC/Config Management strategy, and tooling where appropriate, particularly for self-managed customers.
- Provide tooling that can be extended to enable efficient fleet management of multiple GitLab instances.
- This concept is not a competitor to, and does not supersede, the GitLab Operator (of the Kubernetes variety). It should be a support/value add to, and possibly additional enabler of, its functionality.
- Find a way to distill GitLab's extensive experience at running GitLab into tools, components, and documentation which can be adopted into the workflows of other organizations, and promote/enhance the offerings like this that we already have.

<!--
List the specific goals / opportunities of the document.

- What is it trying to achieve?
- How will we know that this has succeeded?
- What are other less tangible opportunities here?
-->

### Non-Goals

- Fleet Management or Orchestration of multiple GitLab instances
- Management of `.com`.
- This is not related to Deploy capabilities in GitLab software, such as IaC management or CM features

## Proposal

- Continue to use and build on GET.
- Increase our internal usage of GET's existing customization points like Custom Config/Files/Tasks to better dogfood those paths and increase their visibility with implementation examples.
- Define a framework to engage engineering teams in the building and maintenance of Reference Architectures, have the subject matter experts of the code and components of GitLab involved in describing and optimizing what it takes to run those components elastically.
- Define and build components to reduce the operational burden/"Day 2 Operations" task burden of a GitLab instance.

<!--
This is where we get down to the specifics of what the proposal actually is,
but keep it simple!  This should have enough detail that reviewers can
understand exactly what you're proposing, but should not include things like
API designs or implementation. The "Design Details" section below is for the
real nitty-gritty.

You might want to consider including the pros and cons of the proposed solution so that they can be
compared with the pros and cons of alternatives.
-->

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

<!--
It might be a good idea to include a list of alternative solutions or paths considered, although it is not required. Include pros and cons for
each alternative solution/path.

"Do nothing" and its pros and cons could be included in the list too.
-->
