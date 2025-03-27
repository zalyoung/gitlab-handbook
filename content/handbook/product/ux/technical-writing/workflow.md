---
title: "Technical Writing workflows"
---

Technical Writing team workflows work in conjunction with the:

- [Product development flow](/handbook/product-development-flow/).
- [Product designer workflow](/handbook/product/ux/product-designer).
- [Engineering workflow](/handbook/engineering/workflow/).

The process for creating and maintaining GitLab product documentation depends on whether the documentation is:

- [A new feature or feature enhancement](https://docs.gitlab.com/development/documentation/workflow/#documentation-for-a-product-change): Delivered for a specific milestone and associated with specific code changes.
  This documentation has the highest priority.

- [Changes outside a specific milestone](https://docs.gitlab.com/development/documentation/workflow/): Usually not associated with a specific code change, is of lower priority, and
  is open to all GitLab contributors.

Documentation [is required](https://docs.gitlab.com/development/contributing/merge_request_workflow/#definition-of-done)
for a milestone when:

- A new or enhanced feature is shipped that impacts the user or administrator
  experience.
- There are changes to the user interface or API.
- A process, workflow, or previously documented feature is changed.
- A feature is deprecated or removed.

Documentation isn't typically required when a *backend feature* is added or changed.

## UI text

### Planning and authoring

A Product Designer should consult with the Technical Writer for their stage group when planning to add
or change substantial text within the UI, such as a phrase of explanatory microcopy or a link to documentation.

The Technical Writer can offer an initial review of any ideas, plans, or actual text, and can be asked to
draft text when provided with information on the context and goals of the text. Context may include
detail on the scenarios in which the text would appear (for example, to all users viewing the feature
or only under certain conditions), and the information to convey, which typically answers
one or more of the questions:

- What does this do?
- How do I use it?
- Why should I care?

Consider tagging the Technical Writer once in a review request with a message indicating the number of points and/or the areas where reviews are needed. This will help manage the volume of notifications per review round.

### MR Reviews

Once the merge request is created, all changes and additions to text in the UI *must* be reviewed by
the Technical Writer in accordance with [review principles](/handbook/product/ux/technical-writing/#review-principles).

These may include: labels (buttons, menus, column headers, UI sections) or any phrases that may be
displayed within the UI, such as user-assistance microcopy or error messages.

Additional information about composing and reviewing UI text:

- "[Copy That: Helping your Users Succeed with Effective Product Copy](https://www.youtube.com/watch?v=M_Q1RO0ky2c)", a talk by Sarah Day.

## Release posts

The Technical Writer for each [stage group](/handbook/product/categories/#devops-stages)
is a reviewer of their group's [feature blocks](/handbook/marketing/blog/release-posts/#content-reviews) (also known as release post items) authored by the Product Manager.

For each release, a single Technical Writer is also assigned as the [Technical Writing Lead](/handbook/marketing/blog/release-posts/#tw-lead) to perform
the [Structural Check](/handbook/marketing/blog/release-posts/#structural-check) and other duties.

## Monthly documentation releases

When a new GitLab version is released, the Technical Writing team releases [version-specific published documentation](https://gitlab.com/gitlab-org/technical-writing/docs-gitlab-com/-/blob/main/doc/releases.md).

## Documentation feedback and improvements

To make a documentation change that is not associated with a specific code change, the Technical Writing team encourages contributors to [start with an MR](/handbook/communication/) and follow the [documentation update procedures](https://docs.gitlab.com/development/documentation/workflow/).

If you do start with an issue rather than an MR, use the [Documentation template](https://gitlab.com/gitlab-org/gitlab/-/issues/new?issuable_template=Documentation). Labels should include:

- `documentation`
- `type::maintenance`
- `maintenance::refactor`
- `docs-only`
- `Stage name`
- `Group name`

Also include:

- Milestone: `Backlog` until the work is scheduled for a milestone.
- Assignee: `None` until the work is scheduled for a milestone. In the issue description or comments, mention (`@username`) the Technical Writer assigned to the group for awareness.
- Description: starts with `Docs:` or `Docs feedback:`
- A task checklist or next step to deliver an MVC. For more information, see [Issue state](/handbook/product/product-processes/#issue-state).
- Labels:
  - `tw::triaged`
  - (Optional, if the issue is suitable for a community contributor) [`Seeking community contributions`](https://gitlab.com/groups/gitlab-org/-/issues/?sort=created_date&state=opened&label_name%5B%5D=Seeking%20community%20contributions&first_page_size=50), [`quick win`](https://gitlab.com/groups/gitlab-org/-/issues/?sort=created_date&state=opened&label_name%5B%5D=quick%20win&first_page_size=50)

If an issue requires input from the development team before a Technical Writer can start work, it should follow the stage and group's issue lifecycle. For an example of an issue lifecycle, take a look at [Plan Stage Issues](/handbook/engineering/development/dev/plan/#issues).

### Review and triage docs-only backlog issues

Routine review and triage of documentation feedback and improvement issues for your groups helps us spend the [time we have](/handbook/product/ux/technical-writing/#prioritization) on actionable issues that improve the user experience.

#### Prerequisites

- An issue triage board for each group that you are the assigned technical writer for. If you don't have an issue triage board for your group, set one up called `Docs only backlog triage - group name`. See an [example board](https://gitlab.com/gitlab-org/gitlab/-/boards/8944610?not[label_name][]=type%3A%3Afeature&not[label_name][]=type%3A%3Abug&label_name[]=documentation&label_name[]=group%3A%3Aproject%20management) for the `Project Management` group.
  - The filter criteria should include **Label=**`documentation`, **Label=**`group::groupname`, **Label!=**`type::feature`, **Label!=**`type:bug`.
  - In **Edit board**, make sure `Show the Open list` is selected.
  - On the issue board, select **Create list**, and set Label to `tw:triaged`.

To review and triage documentation feedback and improvement issues for your groups:

1. Once a month, on the issue triage boards for your groups, check the **Open** list for new issues.
1. Apply the labels described in [Documentation feedback and improvements](#documentation-feedback-and-improvements).
1. Aim to keep the list of open, untriaged issues at **<10**.
1. Share the triaged list with the group and group PM.

## Stage leads

{{% alert title="Note" color="primary" %}}
This section outlines a process that we experimented with in Q1 and Q2 of FY2025, and rolled out more widely in Q3. This process is subject to change.
{{% /alert %}}

Some Technical Writers are assigned as *stage leads* for a given [DevOps stage](/handbook/product/ux/technical-writing/#stage-leads).

Stage leads might work across an entire stage, or a subset of groups in the stage.
They support other Technical Writers assigned to groups in the stage.

Stage leads:

- Assume the same [responsibilities](/job-families/product/technical-writer/#responsibilities) as Technical Writers, but with a more targeted focus on proactively creating and improving
documentation for their assigned stage.
- Spend approximately 30% of their time on issues and merge requests reviews authored by developers for [new features and enhancements](https://docs.gitlab.com/development/documentation/workflow/#documentation-for-a-product-change) for their assigned groups.
- Spend the remainder of their time:
  - Creating and refining content to address documentation needs and gaps for their assigned **stage**.
    For example, writing tutorials and use case-based content, restructuring existing content, working on the information architecture, and so on.
  - Supporting other writers in the stage to contribute to documentation improvements.
- Create a quarterly planning issue to outline the content gaps and improvements that they aim to address over three milestones, for example, [FY25Q3 Stage lead planning issue: Secure](https://gitlab.com/gitlab-org/technical-writing/team-tasks/-/issues/1067).
- Apply the relevant `tw-lead` [label](https://gitlab.com/groups/gitlab-org/-/labels?utf8=%E2%9C%93&subscribed=&search=tw-lead) to documentation improvement MRs that they drive or provide input on. This label allows us to track the improvements that come out of the stage lead process as one of our performance indicators (PIs).
- Collaborate with other stage leads on documentation improvements.

For [documentation improvements](#documentation-feedback-and-improvements), stage leads are responsible for creating an
issue board to track ongoing and planned documentation enhancements and additions.

## Hackathons

The Technical Writing team takes part in the [GitLab Hackathon](https://about.gitlab.com/community/hackathon/)
and sometimes hosts a docs-only Docs Hackathon.

### Create issues for a Hackathon

We often create documentation issues for a Hackathon. These issues are typically based on results found when you run Vale against the documentation.

1. Run Vale against the full docset. Go to the GitLab repo and run:
   `find doc -name '*.md' | sort | xargs vale --minAlertLevel suggestion --output line > ../results.txt`

1. Create issues. You have a few options:

   - Use a [script](https://gitlab.com/gitlab-org/gitlab-docs/-/blob/main/scripts/create_issues.js) to create one issue for each markdown file listed in the Vale results.
     This script uses the [`Doc cleanup` issue template](https://gitlab.com/gitlab-org/gitlab/-/blob/master/.gitlab/issue_templates/Doc_cleanup.md).
   - Create issues one at a time by using the `Doc cleanup` issue template.
   - Create issues in bulk by using the [Issues API](https://docs.gitlab.com/api/issues/#new-issue).

Ensure that the labels assigned to the issues match those in the `Doc cleanup` issue template.

### Assign an issue to a community contributor

To assign an issue to a community contributor:

1. Remove the `Seeking community contributions` label.
1. Assign the user by typing `/assign @username` in a comment, where `@username` is the contributor's handle.
1. Mention the user in a comment, telling them the issue is now assigned to them.

Try to limit each contributor to no more than three issues at a time. You can assign another issue as soon as they've opened an MR for one of the issues they're already assigned.

### Review Hackathon merge requests

When a community contributor opens a Hackathon merge request:

1. View the related issue. Ensure the user who authored the MR is the same user who asked to be assigned to the issue.
   - If the user is not listed in the issue, and another user has asked to work on the issue, do not merge the MR.
     Ask the MR author to find an issue that has not already been assigned or point them to [this page](https://docs.gitlab.com/development/contributing/).

1. Work to merge the merge request.
1. When you merge, ensure you close the related issue.
