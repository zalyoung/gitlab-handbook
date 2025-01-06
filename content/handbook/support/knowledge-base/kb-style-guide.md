---
title: Knowledge Base Style Guide
description: Guidelines for writing Support knowledge base articles
---

This document outlines the standards for GitLab Support's Knowledge Base documentation. These articles help address a specific customer issue in the moment and allow them to self-solve or receive quicker solutions when Support is required.

## The Knowledge Base voice

The voice in KB articles should be concise, direct and precise. Since many users will use these articles during a stressful situation, it is important that we make the information as clear and simple as possible.

## Formatting

Follow the [Documentation Style Guide](https://docs.gitlab.com/ee/development/documentation/styleguide) and use the [recommended word list](https://docs.gitlab.com/ee/development/documentation/styleguide/word_list.html). The important thing is that we have clear information for the customer following a standard template that, over time, users will be accustomed to navigating.

### Title

This is the title once added to Zendesk. This heading must be changed to properly integrate with the deployment.

The title should clearly summarize the customer / reader issue.

Only capitalize the first word and proper nouns.

Include error snippets if relevant.

In general you should cover:

- Break/fix: The symptoms customers will see when they encounter an issue
- How-to: How to complete a specific task
- Q&A: The question a customer may have

Examples:

- Break/fix: [504 Gateway timeouts and performance degradation after losing PostgreSQL nodes](https://support.gitlab.com/hc/en-us/articles/16783619814044-504-Gateway-timeouts-and-performance-degradation-after-losing-PostgreSQL-nodes)
- How-to: [How to update the Primary email address of multiple users](https://support.gitlab.com/hc/en-us/articles/16784431039132-How-to-update-the-Primary-email-address-of-multiple-users-LDAP-and-SAML)
- Q&A: What are the required steps to upgrade my environment?

### Description

This section describes the symptoms, task or situation that would need a solution. At the moment, we believe the first 140 characters will be indexed for SEO.

- Write for the issue encountered, not theoretical situations. Add unconfirmed situations as an additional note if necessary.
- Entries should be listed in order of significance from top to bottom.
- Include as much relevant context as possible. Every small symptom is an extra data point to help the customer self-diagnose.
- Include the exact error / message a user would encounter.
- Error messages should be put in block quotes.
- Use bullet points for multiple items.

### Environment

The environment quickly highlights what custom configs, installation types, or versions are relevant to the KB.

- Use bullet points when possible
- Impacted offerings - aligns with the Offering section of Docs pages
- Impacted versions - highlights affected versions. Use [earlier](https://docs.gitlab.com/ee/development/documentation/styleguide/word_list.html#earlier) and [later](https://docs.gitlab.com/ee/development/documentation/styleguide/word_list.html#later) when talking about version numbers. This can be excluded if all known / supported versions are affected; be as specific as possible:
  - 16.1 to 16.3
  - 16.5 and earlier
  - 17.1 and later
  - 17.x

### Solution and/or Workaround

The solution section clearly lists the steps a user must follow to resolve the issue. You can preface the steps with a high-level summary. If there is a solution and a workaround, add the workaround as a level 3 (###) sub-heading.

1. Change the title of this section to best fit its content: Solution or Workaround
1. Describe steps needed to resolve or work around the issue. Steps should be as concise as possible:

   1. Connect to database: `sudo gitlab-psql connect`
   1. Run:

   ```sql

  --- comment: explain what complicated command does if not obvious
  <complicated command>
  
   ```

- For different environments, list commands as sub-bullets
  - Linux: `<command>`
  - macOS: `<command>`
- Use ordered lists for tasks that must be completed sequentially. Use "1" for all items to allow for steps to be added or removed in the future.
- Use bullet points for unordered steps.
- Link to pre-existing documentation when possible.

### Cause

This section describes _what_ caused the issue to happen and _why_ it was introduced, if known.

The Cause does not immediately diagnose or solve the issue, which is why it is a separate section and listed after the Description and Solution.

It is better to say we don't know the cause if it is under investigation.

Link to docs, blog posts, issues and other relevant materials inline as necessary.

### Additional Information

Optional

Provides context to any of the above sections. While information should be concise and clear, we can dive deeper into information or steps such as:

- Specific locations of logs / errors mentioned in the description
- Alternative commands to find information in the solution
- Related feature requests worth upvoting

### Related Links

Optional

Add links to relevant feature requests, bug issues, etc. as necessary.
Follow the format used for [Related topics](https://docs.gitlab.com/ee/development/documentation/topic_types/index.html#related-topics)

## Integrate pre-existing documentation when possible

We should strive to re-use existing documentation when possible. If steps to a solution already exist within our documentation or another KB, link to that section and provide additional steps and context to the KB as necessary. Any newly found steps to a pre-existing solution should be merged into that solution and referenced in the new article.

Examples:

- [Update to Solution to link to a doc rather than duplicating information](https://gitlab.com/gitlab-com/support/support-pages/-/merge_requests/98/diffs?diff_id=1210778953&start_sha=a6936a6ac8d26199db694ad1e44198368edc7efd)
- [Discussion on whether to update steps in the KB or in Docs](https://gitlab.com/gitlab-com/support/support-pages/-/merge_requests/98#note_2245546605)
