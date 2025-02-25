---
title: Knowledge Lifecycle
description:
---

## How to contribute

### Submitting a KB article

1. Pick the appropriate template in the [`/kb-documentation/templates`](https://gitlab.com/gitlab-com/support/support-pages/-/tree/master/kb-documentation/templates)
   directory:
   - [`break-fix.md`](https://gitlab.com/gitlab-com/support/support-pages/-/blob/master/kb-documentation/templates/break-fix.md): Issues encountered by users with one or more specific resolution steps.
   - [`how-to.md`](https://gitlab.com/gitlab-com/support/support-pages/-/blob/master/kb-documentation/templates/how-to.md): Steps to do a specific task. Does not need to be an issue.
   - [`question-answer.md`](https://gitlab.com/gitlab-com/support/support-pages/-/blob/master/kb-documentation/templates/question-answer.md): Simple article answering a question.
1. Duplicate the template, placing the new file in the appropriate directory:
   - [`/knowledge-base/all_instances`](https://gitlab.com/gitlab-com/support/support-pages/-/tree/master/knowledge-base/all_instances):
     This is where the majority of knowledge base articles will live.
   - [`/knowledge-base/global_only`](https://gitlab.com/gitlab-com/support/support-pages/-/tree/master/knowledge-base/global_only):
     Typically for content specific to GitLab.com.
   - [`/knowledge-base/us_government_only`](https://gitlab.com/gitlab-com/support/support-pages/-/tree/master/knowledge-base/us_government_only):
     For content specific to our US Government product offerings.
1. Fill out the template with the content you'd like to contribute.
   - Focus more on the technical content.
   - Follow the [style and content guide](./kb-style-guide.md) as closely as you can.
   - Consider [using Duo](#using-ai-to-generate-content) as a first pass.
1. Create the merge request using the `Knowledge Base Article` template.
1. Assign reviewers:
   - If timeliness is important, assign a Staff Support Engineer or Support Manager for review.
   - Otherwise, the template will assign the KB editors: currently `@irisb` or `@weimeng-gtlb`.

### Reviewing a KB article

- Make suggestions and apply them yourself.
- It's more important to capture the knowledge than to capture it with the right style and formatting.

### Publishing a KB article

Publishing an article should be done by the person who merges a KB MR. After the KB article is merged:

1. Submit a request using the [Support Super Form](https://support-super-form-gitlab-com-support-support-op-651f22e90ce6d7.gitlab.io/), selecting `Create a Zendesk article` for the field "What is this request concerning?".
1. After successful submission, the Support Super Form will create an issue and post URLs to
   the published KB article. The sync may take 5 to 10 minutes to complete.

### Getting Help

Questions can be asked in the dedicated [#spt_knowledge-base](https://gitlab.enterprise.slack.com/archives/C07QDCG4AGH) Slack channel.

### Using AI to generate content

- You **must use Duo** for any customer related ([Red](../../security/data-classification-standard.md#red)) data. Claude is only approved for [Orange data](../../security/data-classification-standard.md#orange) at this time.
- Duo can help quickly generate a first pass of an article. **Always** review generated data by Duo for technical accuracy. You are still the SME of the article and original customer issue.
- You must be directly on the page of the article template, i.e. [break-fix.md](https://gitlab.com/gitlab-com/support/support-pages/-/blob/master/kb-documentation/templates/break-fix.md). If the request is made in another location, Duo may make up random sections in the article.
- Duo will not immediatly provide the output in plain text even if asked in the original prompt. Requesting "raw markdown" may work, but there is [an issue](https://gitlab.com/gitlab-org/gitlab/-/issues/482485) when code blocks are included.
- Examples:
  - [GitLab Unfiltered](https://www.youtube.com/watch?v=4z6Xnh3B-wU) video(requires authentication) demonstration creating an article by copying ticket data.
  - [GitLab issue](https://gitlab.com/gitlab-com/support/support-pages/-/issues/7) demonstrating text prompts and output.
