---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Poly Repos
status: proposed
creation-date: "2025-04-10"
authors: [ "@stanhu", "@fabiopitino", "@shekharpatnaik" ]
coaches: [ "TBD" ]
dris: [ "@product-manager", "@engineering-manager" ]
owning-stage: "~devops::<stage>"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

{{< design-document-header >}}

This document is a work in progress and outlines a plan to support
workflows that involve multiple repositories. We call this poly repos
for short.

## Summary

## Motivation

Many customers have source code repositories that depend on other repositories. Android developers,
for example, may work with a handful of them, but there are over a thousand repositories involved with building Android. A sample:

- [platform/manifest](https://android.googlesource.com/platform/manifest) - The central repository that defines all other repositories needed for a build.
- [platform/frameworks/base](https://android.googlesource.com/platform/frameworks/base/) - Core Android framework
- [platform/system/core](https://android.googlesource.com/platform/system/core) - Low-level system components
- [platform/bionic](https://android.googlesource.com/platform/bionic) - Android's C library implementation

Currently GitLab only supports merge requests for a single project, but users
should be able to work across projects. Users should be able to:

1. Push changes that span projects.
1. Review these changes together in one place.
1. Ensure CI passes with these changes.
1. Merge when all tests pass.
1. Revert the changes if something goes wrong.

## Definition of terms

- **Change Set** - A group of proposed code changes that span multiple projects.

- **Target Product** - A group of projects that represents the target product for a Change Set. For example, the Android source code
  is one example of a product consisting of hundreds of individual Git repositories.

### Goals

1. Define how to identify projects that make up a target project.
1. Define how merges and reverts will work across multiple projects.
1. Define how to build changes across projects with a centralized pipeline.
1. Discuss how Code Review will work with poly repo changes.

### Non-Goals

## Proposal

## Design and implementation details

### What is a Change Set?

There are two main ways a Change Set could be represented:

- Patch Set: A group of individual Git patches that are applied to different projects.
- Grouped Merge Requests: A group of merge requests that cross project boundaries.

#### Grouped Merge Requests vs. Patch Set

In the GitLab model, merge requests could be grouped together into a logical set and represent the changes needed to be applied together. This has the advantage of working with existing workflows, such as code review, merge request pipelines, etc.

However, there are a number of disadvantages:

- Diffs have to be recomputed on the server every time the target branch changes. If there are many outstanding merge requests across many repositories, this could create a significant amount of load on the server.
- Each change to a project requires creating a new branch for that project. Developers have to name and manage individual branches across many repositories.

Patch sets have a number of advantages:

- They are computed on the client side.
- They force developers to have good commit hygiene, keeping logical changes together.
- Merging and reverting individual patches might be more straightforward than reverting a large merge commit.

#### How are Change Sets created?

There should be a number of ways a Change Set can be created:

1. From the UI
1. Using the API
1. Git push options

#### How are Change Sets tied to a product?

Usually a Change Set will not involve every proejct


#### Can there be multiple products tied to a product?

####
