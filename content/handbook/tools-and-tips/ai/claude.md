---
title: "Claude.ai Tips"
---

Learn how to use [Claude.ai](https://claude.ai/) to infuse AI into your workflows, tools, and processes to greater efficiencies. You can use Claude to write content, create outlines and documents, summarize content, generate database migrations and SQL statements, recommend refactorings, and more.

## Access

Open [claude.ai](https://claude.ai/) and use your team member email address for SSO login. You can also use the Claude tile in [Okta](/handbook/it/okta/). Review the [usage guidelines and FAQs](https://internal.gitlab.com/handbook/company/ai-at-gitlab/#usage-guidelines-and-faqs) (internal).

## Resources

- [AI at GitLab initiative](https://internal.gitlab.com/handbook/company/ai-at-gitlab/) (internal)
- [Claude.ai support articles collection](https://support.anthropic.com/en/collections/4078531-claude-ai)

## Tips

> **Note** Only document public use cases and tips with Claude.ai, and keep everything else SAFE in the [internal handbook](https://internal.gitlab.com/handbook/company/ai-at-gitlab/).

Claude.ai can answer many different questions and topics. Be creative, curious, and explore, and iterate on the best chat prompts. Since [GitLab Duo Chat](gitlab-duo.md) also uses [Anthropic Claude as one of the LLMs](https://docs.gitlab.com/ee/user/gitlab_duo_chat/), you can test and repurpose similar chat prompts.

1. Join the [#ai-at-gitlab Slack channel](https://gitlab.enterprise.slack.com/archives/C085M5071LG)
1. Download [Claude for Desktop](https://claude.ai/download)
1. CLI and API access
   - An Anthropic API key is required. Create an [Access Request](/handbook/it/end-user-services/onboarding-access-requests/access-requests/) for Anthropic Console - Corp in the [tech_stack.yml](https://gitlab.com/gitlab-com/www-gitlab-com/-/blob/master/data/tech_stack.yml)
   - Learn about the [Anthropic SDK](https://docs.anthropic.com/en/docs/initial-setup#install-the-sdk) and community projects for CLIs: [anthropic-cli](https://github.com/dvcrn/anthropic-cli)
1. [How up-to-date is Claude's training data?](https://support.anthropic.com/en/articles/8114494-how-up-to-date-is-claude-s-training-data)

## Use cases

### Analyze data

Download data from the internet or other sources, and analyze it with Claude.

#### Download data

Download the data sets into a file to later upload them into Claude Chat. If it is a website, ask Claude how to download it. You can refine the prompt and ask for JSON, REST API data, CSV, PDF, etc.

```markdown
I want to download a Google sheet for further analysis. Please show how to fetch the raw CSV content.

I want to analyze this website. Please share how to download the data as a PDF or JSON file.

I want to analyze a GitLab epic. Show how to download the data from this URL: https://gitlab.com/groups/gitlab-com/marketing/developer-relations/-/epics/513 and create a Python script.

I want to fetch this forum thread and the replies into a raw text file. https://forum.gitlab.com/t/refreshing-a-fork/32469 Please show me a simple Python script.
```

If Claude generated a script, you can ask how to run it on macOS/Linux in a follow up conversation.

```markdown
Show me how to run the provided Python script on macOS. Please add further instructions like virtual environment setup etc.
```

#### Analyze generic data sets

Use downloaded files and attach them into the Claude chat prompt to ask analysis questions. Examples matching the [downloaded data examples](#download-data):

```markdown
Please summarize the attached CSV file, and provide an overview summary, and detailed analysis, no more than 100 words. Show me sample rows.

Provide a sentiment analysis from the attached content.

Summarize the learnings and group them by importance.

Break down the data into visual insights, for example analyze a time-series for time, cost, count etc.
```

#### Hacker News sentiment analysis

Requires two steps:

1. Download the raw Hacker News thread data. Ask Claude how to achieve that, it may come up with a Python script that downloads a JSON data file.

   ```markdown
   How can I download the raw content of a Hacker News thread, for example https://news.ycombinator.com/item?id=42453341
   ```

2. Upload the data file into the Claude Chat prompt, and ask Claude to analyze the sentiments.

   ```markdown
   Please summarize the attached Hacker News discussion, and provide insights into

   1. Competitors and how they are received
   2. General sentiment analysis
   ```

### Editing and writing

Edit the handbook, create blog posts, or work on GitLab documentation.

#### Refine writing style

Ask Claude to refine the writing style, language, or complexity. You can provide a context file to refine the writing style based on a given context file.

```markdown
Please rewrite the following paragraph in more modern writing style.
...
```

When working on the GitLab documentation, first [download](#download-data) the [development style guide](https://docs.gitlab.com/ee/development/documentation/styleguide/), and then upload it as context into the Chat prompt. Then ask to improve specific copied text based on the style guide.

#### Embedding a YouTube video into Markdown

There is a trick in the Markdown language to embed a video with its image thumbnail as preview image, and link to the video directly. Ask Claude to generate a Markdown snippet for this task.

```markdown
Use this YouTube URL and embed it into Markdown with a preview image https://www.youtube.com/watch?v=pwlDmLQMMPo
```

Expected result:

```markdown
[![Video Title](https://img.youtube.com/vi/VIDEO_ID/0.jpg)](https://www.youtube.com/watch?v=VIDEO_ID)

[![Video Title](https://img.youtube.com/vi/pwlDmLQMMPo/0.jpg)](https://www.youtube.com/watch?v=pwlDmLQMMPo)
```

### Development

There are many use cases for AI in development. If you are using an IDE, consider using [GitLab Duo](gitlab-duo.md) with Chat, Code Suggestions and specific slash command actions instead.

#### Explain an error

Copy-paste a terminal output, CI/CD job log error, or an IDE error output, and ask Claude to explain the issue. You can add the prefix `Explain this error:` followed by a new line to set the right expectations.

```markdown
Explain this error: ...
```

#### Visualize code

Paste a code snippet and ask Claude to visualize the code flow, function calls, etc. for better debugging insights.

```markdown
Please visualize the following source code. Show different variants that help understand the execution and function calls for debugging better.
```

You can refine the prompt to include a specific format or framework, for example Mermaid charts, PlantUML, ASCIIArt, etc.

```markdown
Render as ASCIIArt.
```

Examples:

1. You can use the `server.py` code from this [Duo Python workshop repository](https://gitlab.com/gitlab-da/use-cases/ai/ai-workshops/gitlab-duo-workshop-best-practices-advanced-use-cases-2024-10-01/-/merge_requests/1/diffs#diff-content-37f78d9e69dff05b443a39c32175987bb0cbdccd).
1. Learn and explain a COBOL program ([project](https://gitlab.com/gitlab-da/use-cases/ai/ai-workflows/gitlab-duo-challenges/code-challenges/challenge-explain-refactor-cobol-program), [recording](https://www.youtube.com/watch?v=pwlDmLQMMPo))

> Note: The same prompts work with [GitLab Duo](gitlab-duo.md) in an IDE.

### Code modernization

Upload a code snippet into the Claude Chat prompt, and ask Claude to explain the code snippet, and how to rewrite it in a modern language.

```markdown
Explain what this code snippet does, and how to write it in a modern language.

...
```
