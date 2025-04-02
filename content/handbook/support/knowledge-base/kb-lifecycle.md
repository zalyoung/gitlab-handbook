---
title: Knowledge Lifecycle
description:
---

This page describes our process to create an article and publish it to our public Zendesk pages.

High level overview:

1. Topic in need of an article is identified through a customer issue, found vulnerability, etc.
1. Article created following a [template](https://gitlab.com/gitlab-com/support/support-pages/-/tree/master/kb-documentation/templates).
1. MR reviewed for style and technical accuracy (when necessary).
1. Article is merged and manually published to Zendesk by a preset group of approvers.

## Creating a KB article

NOTE: If the content of the article is time sensitive for information to be released, i.e. related to a vulnerability announcement, do not push the article to the repo or create an MR. [STM-6710](https://gitlab.com/gitlab-com/support/support-team-meta/-/issues/6710).

1. Pick the appropriate template in the [`/kb-documentation/templates`](https://gitlab.com/gitlab-com/support/support-pages/-/tree/master/kb-documentation/templates)
   directory:
   - [`break-fix.md`](https://gitlab.com/gitlab-com/support/support-pages/-/blob/master/kb-documentation/templates/break-fix.md): Issues encountered by users with one or more specific resolution steps.
   - [`how-to.md`](https://gitlab.com/gitlab-com/support/support-pages/-/blob/master/kb-documentation/templates/how-to.md): Steps to do a specific task. Does not need to be an issue.
   - [`question-answer.md`](https://gitlab.com/gitlab-com/support/support-pages/-/blob/master/kb-documentation/templates/question-answer.md): Simple article answering a question.
1. Copy the contents of the template into a new file in the appropriate directory:
   - [`/knowledge-base/all_instances`](https://gitlab.com/gitlab-com/support/support-pages/-/tree/master/knowledge-base/all_instances):
     This is where the majority of knowledge base articles will live. Articles will be pushed to the US Government and standard support space.
   - [`/knowledge-base/global_only`](https://gitlab.com/gitlab-com/support/support-pages/-/tree/master/knowledge-base/global_only):
     Typically for content specific to GitLab.com or other offerings not available to US Government environments.
   - [`/knowledge-base/us_government_only`](https://gitlab.com/gitlab-com/support/support-pages/-/tree/master/knowledge-base/us_government_only):
     For content specific to our US Government product offerings.
1. Fill out the relevant content in the template.
   - Remove unused headings.
   - Follow the [style and content guide](./kb-style-guide.md) as closely as you can.
   - Consider [using Duo](#using-ai-to-generate-content) as a first pass.
1. Create a merge request using the `Knowledge Base Article` template from the drop-down in the Description section.
1. The MR template will automatically assign style editors who will review and publish the article. Assign any relevant reviewers for technical / content accuracy as necessary  
   - For emergency articles: Assign a Staff Support Engineer or Support Manager for review.

### Reviewing a KB article

- For rapid reviewers in Emergency situations, prioritize the content of the article, rather than the style and formatting. 
    - Once merged @mention content reviewers to update style later.
- Consider the information from a customer's perspective.
  - Is the information clear enough that the most junior admin could diagnose?
  - Is it clear where relevant logs and messages can be found?
  - Does the solution provide all steps to perform a fix or workaround?
  - Are we using any terms or abbreviations that need definitions?
  - Has any customer related data been removed such as IPs, hostnames, or URLs in log snippets? 
- Make suggestions and apply them yourself.
- It's more important to capture the knowledge than to capture it with the right style and formatting.

### Publishing a KB article

Publishing an article should be done by the person who merges the KB to the master branch. After the KB article is merged:

1. Submit a request using the [Support Super Form](https://support-super-form-gitlab-com-support-support-op-651f22e90ce6d7.gitlab.io/), 
  - Select `Create a Zendesk article` for the field "What is this request concerning?".
  - Use the link from the master branch for the article.
1. After successful submission, the Support Super Form will create an issue and post URLs to
   the published KB article. The sync may take 5 to 10 minutes to complete.

### Getting Help

Questions can be asked in the dedicated [#spt_knowledge-base](https://gitlab.enterprise.slack.com/archives/C07QDCG4AGH) Slack channel.

Tag @irs, @weimeng or @Kirsty Allen for higher visibility if necessary. 

### Using AI to generate content

- You **must use Duo** for any customer related ([Red](../../security/data-classification-standard.md#red)) data. Claude is only approved for [Orange data](../../security/data-classification-standard.md#orange) at this time.
- Duo can help quickly generate a first pass of an article. **Always** review generated data by Duo for technical accuracy. You are still the SME of the article and original customer issue.
- You must be directly on the page of the article template, i.e. [break-fix.md](https://gitlab.com/gitlab-com/support/support-pages/-/blob/master/kb-documentation/templates/break-fix.md). If the request is made in another location, Duo may make up random sections in the article.
- Duo will not immediatly provide the output in plain text even if asked in the original prompt. Requesting "raw markdown" may work, but there is [an issue](https://gitlab.com/gitlab-org/gitlab/-/issues/482485) when code blocks are included.
- Examples:
  - [GitLab Unfiltered](https://www.youtube.com/watch?v=4z6Xnh3B-wU) video(requires authentication) demonstration creating an article by copying ticket data.
  - [GitLab issue](https://gitlab.com/gitlab-com/support/support-pages/-/issues/7) demonstrating text prompts and output.
