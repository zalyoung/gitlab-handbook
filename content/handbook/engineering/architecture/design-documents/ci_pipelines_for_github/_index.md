---
title: GitLab CI for GitHub SCM
status: proposed
creation-date: "2024-11-26"
authors: [ "@mfanGitLab" ]
coaches: [ "@allison.browne" ]
dris: [ "@rutshah", "@carolinesimpson" ]
owning-stage: "~devops::verify"
participating-stages: []
toc_hide: true
---

{{< design-document-header >}}

## Summary

Some customers using GitHub Source Code Management want to integrate with GitLab's CI solutions to run pipelines and leverage our security features. They do not want to mirror the source code on GitLab and want instantaneous pipelines for their pushes.

## Motivation

Our current approach with GitHub <-> GitLab integration is with mirroring at a minimum 5 minute interval. This is too slow for feedback, uses long lived personal access tokens, and requires a copy of GitHub's source code on GitLab. Additionally, as the entire project and all pipelines are run under the user that initiates the integration; this could lead to permission mismatch.

With an effective solution, we can sell GitLab CI/CD and other Ops features to business that use GitHub source control.

There are similar tools in the market that can be used for GitHub to run CI/CD externally. [Buildkite, CircleCi, TeamCity, Jenkins](https://GitLab.com/GitLab-org/GitLab/-/issues/460503#note_2115425859) are examples where the runner pulls directly from GitHub. And where the pipelines config file can live either on GitHub or in the services.

### Goals

As an initial MVC we want to support

1. A GitHub App (on GitHub's marketplace - this doesn't need to be in MVP, users can install with a direct link)
2. Near instant pipeline creation upon GitHub pushes
3. Correct user management system, through direct user mapping
    1. Each user on GitHub's side should have a billable seat on GitLab
    2. GitLab users should have the least privilege needed to run pipelines
4. Runners are the only place to interact (fetch/pull) with the source code
    1. Customer source code is stored in a GitHub Repo and is never stored in a GitLab repo

### Non-Goals

Items that are out of scope (For MVP) include

1. GitHub Enterprise
    1. Why: This will require extra set-up, licensing, testing, and manual configurations as GitHubApps are different on the Enterprise level
2. GitLab Self-Managed
    1. Why: This should be quite do-able. Assuming we have docs for SM users to set-up. We _should_ get this from the MVP
3. GitLab Security Scans, and execution policies
    1. Why: Similarly to the above, we _should_ get this for free as well. But because of the additional integration and cross team collaboration, if this doesn't work; the time spent might overwhelm the MVP.
4. Different actions on GitHub side that might want/require CI such as
    1. Forks
    2. Tags
    3. Branch name changes, [etc](https://GitLab.com/GitLab-org/GitLab/-/issues/493378#future-iterations)
    4. Why: These are bit more complex as they rely on different webhooks as well as sha configurations

These are do-able, but just to reduce scope and complexity we can iterate on additional features.

## Proposal

![Architecture](images/GitHubGitLabWorkflow.png)

GitHub will communicate with GitLab via our GitHubApp via webhooks.
When runners poll GitLab's api, GitLab will serialize the jobs including the GitHub repo location for the runner to fetch the code from.
GitLab will then use GitHub's API to update the commit with the pipeline status.

Unfortunately there's nuances to this diagram regarding user management and access tokens that we'll explore below.

## Design and implementation details

### Prerequisites

To start off this whole process. The 'admin' of GitHub would start off creating projects in GitLab that would need linking.

We would reuse [CI/CD For External Repositories](https://GitLab.com/projects/new#cicd_for_external_repo), and have a "checkbox" to not mirror the repository (UI pending). During the import we'll save the GitHub repository id. [Issue for discussion](https://gitlab.com/gitlab-org/gitlab/-/issues/509200)

After import, we would automatically enable a new GitLab integration called GitHub SCM for these projects.

Then the customer will use a direct link to install our GitHub App, and choose which repos on GitHub to install it on

### Once everything is set-up properly

The steps here will be in accordance with the diagram above

1. User on GitHub initiates a push to a branch
2. GitHub will automatically trigger a webhook via our GitHubApp. This'll send a `push` payload to GitLab
    1. [GitLab Webhook Push Payload](https://docs.GitHub.com/en/webhooks/webhook-events-and-payloads#push)
3. GitLab will receive the push payload.
4. GitLab will use Installation Access Tokens (IAT) to exchange for a short lived token (1hr max)
    1. [GitHub docs for IAT](https://docs.GitHub.com/en/apps/creating-GitHub-apps/authenticating-with-a-GitHub-app/authenticating-as-a-GitHub-app-installation)
    1. Each GitHub project will come with an Installation ID. GitLab will use a private `.pem` key with this Installation ID to get a short-lived token for that project.
5. GitLab will use the webhook details for which user was the sender. And try to run a pipeline with that user on GitLab's side. If the user does not exist (eg bots), the pipeline will be created but in a failed status. Any maintainer of the project can then retry the pipeline.
    1. The pipeline will be generated by pulling a `.GitLab-ci.yml` file present on GitHub side.
    1. The user is required to create a GitLab account, and then link their GitHub account. The user will be mapped via the user_id generated on GitHub's side.
6. Rails will pass the necessary params including the IAT to the runner. It will also update the pipeline on GitHub side to "running" via GitHub API and IAT.
7. The runner will directly call GitHub with the IAT to fetch and pull the repository for that branch
8. When the pipeline finishes, runner will update GitLab as normal
9. GitLab will use the IAT to post a commit on GitHub with the pipeline's sha. Notifying them the commit has a finished pipeline.
    1. [GitHub commit status API](https://docs.GitHub.com/en/rest/commits/statuses?apiVersion=2022-11-28#create-a-commit-status)

**Step 5 expanded:**

There are many ways this authorization could play out. More details in [Corresponding Implementation Issue](https://GitLab.com/GitLab-org/GitLab/-/issues/505056).

We will enforce a 1:1 user mapping on GitHub <-> GitLab. Currently this is product's preferred approach. This allows us to make sure the product is properly licensed with the correct number of seats.

Each user will need to manually link their GitHub accounts to their GitLab profiles

The downside is that users or bot accounts that do not have a GitLab account mapping will not be able to run pipelines. The workaround is to create a failed pipeline that maintainers can manually run.

**Step 5.1** - As the `GitLab-ci.yml` file is hosted externally on GitHub.com. Only this file will then be pulled in when a webhook is triggered. This'll keep the source code and config file in sync.

There are certain yaml definitions which would not work with this approach. The `includes:` yaml definition would not work, similarly cross-pipeline configs, security scans, pipeline test reports, execution policies would need additional patching to work.

## Alternative Solutions

For Step 4.

Another option is for the GitHub App to use Oauth Access Tokens. This'll require installation user on GitHub's side to explicity authenticate with the GitHubApp.

There is extra work involved here as the user needs to be created on GitLab's side. Additionally, we'll need to support the ability to refresh user tokens. This doesn't seem to be needed currently, as this integration won't need to update GitHub as a specific user.

[Authenticating GitHubApp as a User](https://docs.GitHub.com/en/apps/creating-GitHub-apps/authenticating-with-a-GitHub-app/authenticating-with-a-GitHub-app-on-behalf-of-a-user)

For Step 5.

Another idea is to use [service accounts](https://docs.GitLab.com/ee/user/profile/service_accounts.html). Have the customer create a service account they want to use and assign it to a project with the permission set or [custom role](https://docs.GitLab.com/ee/user/custom_roles.html). Then we'll have a UI allowing them to select which service account they want to use for these GitHub webhook actions.

This'll need composite identities, as cross-project pipelines can exist.

For Step 5-1.

If the `GitLab-ci.yml` is on GitLab.com, this should allow many of the features to work automatically. Although this creates overhead as the source code is not in sync with the pipeline configuration.

To help with this, we could run the `GitLab-ci.yml` file on the pushed branch if it exists, and default to `main` if it doesn't. This will allow for easier `GitLab-ci.yml` testing, even though it could lead to more #master-broken incidents as merge to master conditions would be different.

There is a use-case for this, so maybe we can push this to a post-mvp feature.

## Questions for Reviewers

1. Compliance Question: Do we need additional terms and conditions depending on how we run & keep GitHub code?
    1. As the job logs will be kept on GitLab side
2. Compliance Question/PM: Some customers don't want anything else aside from runner interacting with the source code. This requirement is unclear; does referencing, have snipplets of file/artifact names in the job logs invalidate this reqirement?
