---
title: Complex SPDX Expression Evaluation
status: proposed
creation-date: "2025-01-06"
authors: [ "@hacks4oats" ]
coaches: []
dris: [ "@johncrowley", "@tkopel" ]
owning-stage: "~devops::secure"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!--
Before you start:

- Copy this file to a sub-directory and call it `_index.md` for it to appear in
  the design documents list.
- Remove comment blocks for sections you've filled in.
  When your document ready for review, all of these comment blocks should be
  removed.

To get started with a document you can use this template to inform you about
what you may want to document in it at the beginning. This content will change
/ evolve as you move forward with the proposal.  You are not constrained by the
content in this template. If you have a good idea about what should be in your
document, you can ignore the template, but if you don't know yet what should
be in it, this template might be handy.

- **Fill out this file as best you can.** At minimum, you should fill in the
  "Summary", and "Motivation" sections.  These can be brief and may be a copy
  of issue or epic descriptions if the initiative is already on Product's
  roadmap.
- **Create a MR for this document.** Assign it to an Architecture Evolution
  Coach (i.e. a Principal+ engineer).
- **Merge early and iterate.** Avoid getting hung up on specific details and
  instead aim to get the goals of the document clarified and merged quickly.
  The best way to do this is to just start with the high-level sections and fill
  out details incrementally in subsequent MRs.

Just because a document is merged does not mean it is complete or approved.
Any document is a working document and subject to change at any time.

When editing documents, aim for tightly-scoped, single-topic MRs to keep
discussions focused. If you disagree with what is already in a document, open a
new MR with suggested changes.

If there are new details that belong in the document, edit the document. Once
a feature has become "implemented", major changes should get new blueprints.

The canonical place for the latest set of instructions (and the likely source
of this file) is
[content/handbook/engineering/architecture/design-documents/_template.md](https://gitlab.com/gitlab-com/content-sites/handbook/-/blob/main/content/handbook/engineering/architecture/design-documents/_template.md).

Document statuses you can use:

- "proposed"
- "accepted"
- "ongoing"
- "implemented"
- "postponed"
- "rejected"

-->

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

## Summary

SPDX license expressions provide a clear, standardized, and machine-readable way
to document the software licenses associated with code, ensuring compliance with
licensing obligations. Standardized expressions help users manage legal risks,
meet licensing requirements, and easily share software components for reuse.
Expressions can be simple, for example an expression composed of singular SPDX
license identifier, or complex, like when more than one expressions are combined
using boolean operators.

## Motivation

Projects are increasingly adopting licensing models that make use of complex
license expressions. For example, a project might require both Apache-2.0 and
MIT licenses, or it might let users choose _between_ Apache-2.0 or MIT licenses.
Unfortunately, there's no way to express this with singular license expressions,
so project's that depend on packages that utilize complex license expressions
are left with a dependency list that only mentions an _unknown_ license. This
results in a user experience where it's impossible to quickly view the licensing
options of a dependency, and also presents a problem when a user tries to craft
a license approval policy to fit such an expression. Supporting complex
expressions will improve the development workflow for projects that work with
dependencies that use complex licensing models.

### Goals

- Support for simple license identifiers, and the `AND` and `OR` boolean
  operators.
- Populate dependency list with license _expressions_ and not just license
  identifiers. For example, a dependency with a `Apache-2.0 AND MIT` license
  will show up as such in the dependency list.
- Enforce license approval policies on projects that use expressions. For
  example, if a license approval policy only approves of `Apache-2.0`, and a
  proposed dependency has a `Apache-2.0 AND MIT` license, the dependency should
  not pass the approval policy. On the other hand, if the approval has acceptance
  for both licenses, it _should_ pass.
- Performance should be acceptable for groups with many projects, and projects
  with many dependencies.

### Non-Goals

- The first iteration will not include for the following:
  - `WITH` operator
  - `+` operator
  - References using `AdditionRef-`, `DocumentRef-` or `LicenseRef-`

## Proposal

At a high level, license expressions will propagate from the Package Metadata
Database (PMDB). These expressions will surface in the dependency list at both
the project and group level, and will also be used when evaluating the approval
status of a dependency's license.

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

### Compiler

To support the license approval policy use case, license expressions will need
to be evaluated by license approval policies that run in the context of a merge
request. In the past, projects with large sets of dependencies have experienced
performance related issues, so we must take this into account. The proposed
solution for this is to compile the license expressions into bytecode, and store
the bytecode for repeated evaluations.

### Evaluation

We'll create a basic virtual machine that will evaluate the bytecode in a
SideKiq worker. This saves us the overhead of tokenizing and parsing the tokens,
leaving us with only the last step of evaluation.

### Storage

The monolith's database will no longer rely on an enum to identify the license used
by a project. Instead it will add an additional column that stores the original
license expression, and its equivalent bytecode.

## Alternative Solutions

<!--
It might be a good idea to include a list of alternative solutions or paths considered, although it is not required. Include pros and cons for
each alternative solution/path.

"Do nothing" and its pros and cons could be included in the list too.
-->

