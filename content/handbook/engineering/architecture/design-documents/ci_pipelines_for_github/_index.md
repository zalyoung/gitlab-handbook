---
title: Gitlab CI for GitHub SCM
status: proposed
creation-date: "2024-11-26"
authors: [ "@mfangitlab" ]
coaches: [ "@allison.browne" ]
dris: [ "@rutshah", "@carolinesimpson" ]
owning-stage: "~devops::verify"
participating-stages: []
toc_hide: true
---

{{< design-document-header >}}

## Summary

Customers using Github Source Code Management want to integrate with Gitlab's CI solutions to run pipelines and leverage our security features. They do not want to mirror the source code on Gitlab and want instantaneous pipelines for their pushes.

## Motivation

Our current approach with Github <-> Gitlab integration is with mirroring at a minimum 5 minute interval. This is too slow for feedback, uses long lived personal access tokens, and requires a copy of GitHub's source code on GitLab.

With an adequate solution, we can sell our product to GitHub users that want Gitlab CI/CD.

There are similar tools in the market. [Buildkite, CircleCi, TeamCity, Jenkins already do all of this](https://gitlab.com/gitlab-org/gitlab/-/issues/460503#note_2115425859).

### Goals

As an initial MVC we want to support

1. Near instant pipeline creation upon Github pushes
2. Correct user management systems. Either through direct user mapping, or service accounts.
3. Runners will directly pull from GitHub and is the only place that will interact with the source code.

### Non-Goals

Items that are out of scope include

1. Github Enterprise
2. Gitlab Self-Managed
3. Gitlab Security Scans, and execution policies
4. Different actions on GitHub side that might want/require CI such as
    1. Forks
    2. Tags
    3. Branch name changes, [etc](https://gitlab.com/gitlab-org/gitlab/-/issues/493378#future-iterations)

## Proposal

![Architecture](images/GithubGitlabWorkflow.png)

Github will communicate with Gitlab via our GithubApp.
Gitlab will then trigger sidekiq jobs to create runners which will pull from Github directly.
Gitlab will then use Github's API to update the commit with the pipeline status.

Unfortunately there's nuances to this diagram regarding user management and access tokens that we'll explore below.

## Design and implementation details

The steps here will be in accordance with the diagram above

1. User on Github initiates a push to a branch
2. Github will automatically trigger a webhook via our GithubApp. This'll send a `push` payload to Gitlab
    1. [Gitlab Webhook Push Payload](https://docs.github.com/en/webhooks/webhook-events-and-payloads#push)
3. Gitlab will receive the push payload.
4. Gitlab will use Installation Access Tokens (IAT) to exchange for a short lived token (1hr max)
    1. [Github docs for IAT](https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/authenticating-as-a-github-app-installation)
5. Gitlab will use the webhook details for which email did the push. And try to run a pipeline with that user on Gitlab's side. If the user does not exist, the pipeline will be run via a bot user.
6. Rails will pass the necessary params including the IAT to the runner. It will also update the pipeline on Github side to "running" via Github API and IAT.
7. The runner will directly call GitHub with the IAT to fetch and pull the repository for that branch
8. When the pipeline finishes, runner will update Gitlab as normal
9. Gitlab will use the IAT to post a commit on Github with the pipeline's sha. Notifying them the commit has a finished pipeline.
    1. [Github commit status API](https://docs.github.com/en/rest/commits/statuses?apiVersion=2022-11-28#create-a-commit-status)

**Step 5 expanded:**

There are many ways this authorization could play out. More details in [Corresponding Implementation Issue](https://gitlab.com/gitlab-org/gitlab/-/issues/505056).

The current idea is to use [service accounts](https://docs.gitlab.com/ee/user/profile/service_accounts.html). Have the customer create a service account they want to use and assign it to a project with the permission set or [custom role](https://docs.gitlab.com/ee/user/custom_roles.html). Then we'll have a UI allowing them to select which service account they want to use for these Github webhook actions.

## Alternative Solutions

For Step 4.

Another option is for the Github App to use Oauth Access Tokens. This'll require each user on Github's side to explicity authenticate with the GithubApp.

There is extra work involved here as the user needs to be created on Gitlab's side. Additionally, we'll need to support the ability to refresh user tokens. This doesn't seem to be needed currently, as this integration won't need to update Github as a specific user.

[Authenticating GithubApp as a User](https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/authenticating-with-a-github-app-on-behalf-of-a-user)

For Step 5.

We can enforce 1:1 user mapping on Github <-> Gitlab. Currently this is product's preferred approach. This allows us to make sure the product is properly licensed with the correct number of seats.

The downside is that users that do not have a Gitlab account mapping will not be able to run pipelines.

Additionally, as a pipelines' owner will be scoped to `email` and will need to be confirmed users, customers will not have the option of making service accounts or bot accounts to run pipelines

## Questions for Reviewers

1. This'll be for security - but do we need additional terms and conditions depending on how we run & keep Github code?
    1. As the job logs will be kept on Gitlab side
2. There's `composite identity` thrown around here, would it be applicable in this case?
    1. I assume not as identities are more straightforward here without Oauth
