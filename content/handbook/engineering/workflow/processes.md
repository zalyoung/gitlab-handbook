---
title: "Default Processes"
---

This is a (incomplete) collection of how-tos to handle some standard problems and situations with the codebase. Feel free to add
any currenly unwritten rules on how to address situations that may reoccur periodically.

## Handling unmaintained dependencies

You've found a package or gem we depend on has not been maintained in a while. If this is a package that is only used in
a single place or few related places, you should open a replacement MR directly. This also applies to transient dependencies.

If the package is used in a wide variety of different places across the codebase, it's better to follow a
more solid review process to make sure the benefits of removing it outweigh the risk of breaking dependencies.

1. Create a **confidential** issue in the project's issue tracker with the title `Unmaintained dependency <dependency name> in <package.json/Gemfile>`.
1. Use the below template for the issue:

    ```md
    The dependency `<package name>` has been discovered as not being maintained.

    Last update: `<n years ago>`
    Latest version: `v.v.v`
    Repository URL: `https://example.com`

    ## Risk / benefit evaluation

    ### Evaluate the risk of removing the package
    [ ] The package has outdated dependencies: `list the dependencies`
    [ ] The package has performance implications
    [ ] The package shows uncompatible design decisions

    ### Alternative packages
    - `name`, `repo url`, pros and cons

    ### Affected areas
    list the categories where this package is used and how

    ### Other considerations
    Note any other considerations that may affect the decision to replace the package
    ```

1. Ping at least one relevant maintainer for feedback 
1. If you haven't found any vulnerabilities, make the issue public.
1. Decide whether to:
    - leave the package in place, or
    - replace it with an alternative package, or 
    - vendor the dependency in the GitLab project, or
    - have GitLab create and maintain a fork
1. If deciding to replace the package, create an MR.
