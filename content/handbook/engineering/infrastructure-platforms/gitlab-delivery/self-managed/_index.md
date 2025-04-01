---
title: "GitLab Delivery: Self managed"
description: "The primary user persona for self managed is all the system administrator, including gitlab.com and dedicated, responsible for managing one or more GitLab instances. The team goals are to make it as easy as possible to deploy, scale, upgrade, and fine tune a GitLab instance on a range of on-prem and cloud platforms."
---

## Overview

Self managed team is focused on installation and upgrade mechanisms to ensure smooth deployments. This includes system integration, scripting, templating, and related configuration management tooling.

In addition to product deliverables, we review a large number of MR's authored outside the team. These include dependency and security updates along with configuration controls and other bundled components like PostgreSQL, Consul, Patroni.

## Team members

The following people are members of the team:

{{< team-by-manager-slug manager="plu8" team="Self managed" >}}

## Primary Projects

[Omnibus GitLab](https://gitlab.com/gitlab-org/omnibus-gitlab) - This project creates platform-specific, self-contained GitLab packages and images for self-managed consumption in cloud environments and on-premisis hosting.

[Cloud Native GitLab](https://gitlab.com/gitlab-org/build/CNG) provides cloud native containers to deploy GitLab. These containers may be deployed and managed via Helm using [GitLab Charts](https://gitlab.com/gitlab-org/charts/gitlab) or [GitLab Chart-based Operator](https://gitlab.com/gitlab-org/cloud-native/gitlab-operator) or [GitLab Operator](https://gitlab.com/gitlab-org/cloud-native/operator) on Kubernetes, OpenShift, and Kubernetes compatible container platforms.

## All Projects

| Name | Location | Description |
| -------- | -------- | -------- |
| Omnibus GitLab | [gitlab-org/omnibus-gitlab](https://gitlab.com/gitlab-org/omnibus-gitlab) | Build Omnibus packages with HA support for LTS versions of all major Linux operating systems such as Ubuntu, Debian, CentOS/RHEL, OpenSUSE, SLES |
| Docker All in one GitLab image | [gitlab-org/omnibus-gitlab/docker](https://gitlab.com/gitlab-org/omnibus-gitlab/tree/master/docker) | Build Docker images for GitLab CE/EE based on the omnibus-gitlab package |
| GitLab Helm Chart | [gitlab-org/charts/gitlab](https://gitlab.com/gitlab-org/charts/gitlab) | Cloud Native GitLab Helm Charts |
| Docker images for GitLab Helm Chart | [gitlab-org/build/CNG](https://gitlab.com/gitlab-org/build/CNG) | Individual images used by GitLab Helm Charts |
| Chart-based GitLab Operator | [gitlab-org/cloud-native/gitlab-operator](https://gitlab.com/gitlab-org/cloud-native/gitlab-operator) | GitLab Operator creates and manages GitLab instances in a container platform such as OpenShift or Kubernetes. It will run an any environment that provides native Kubernetes resources. |
| GitLab Operator | [gitlab-org/cloud-native/operator](https://gitlab.com/gitlab-org/cloud-native/operator) | (In Development) A significant rewrite of the existing Chart-based Operator, aimed at improving user experience and native Kubernetes integration. |
| Kubernetes Helm Charts index | [charts/charts.gitlab.io](https://gitlab.com/charts/charts.gitlab.io) | Helm charts repository index |
| AWS images | [AWS marketplace](https://aws.amazon.com/marketplace/pp/B071RFCJZK?qid=1493819387811&sr=0-1&ref_=srh_res_product_title) | AWS image based on the omnibus-gitlab package |
| Reference Architecture Tester | [gitlab-org/distribution/reference-architecture-tester](https://gitlab.com/gitlab-org/distribution/reference-architecture-tester) | Spins up reference architecture based GitLab deployments using [GET](https://gitlab.com/gitlab-org/gitlab-environment-toolkit) and runs QA against them |
| Omnibus GitLab Builder | [GitLab Omnibus Builder](https://gitlab.com/gitlab-org/gitlab-omnibus-builder) | Create environment containing build dependencies for the omnibus-gitlab package |
| Licenses of bundled dependencies | [Licenses page on GL Pages](https://gitlab-org.gitlab.io/omnibus-gitlab/licenses.html)  | Webpage listing the bundled dependencies in each package along with their license. |

## Working with the community

The install and upgrade process is one of the first features that all system administrators experience when working with GitLab.
As a result, the projects managed by the self managed team have a high level of engagement by the user-base. The GitLab
community is made up of more than just code contributors; users logging issues and feature requests are constantly pushing
us forward and helping create a better experience.

We strive for the following in our public projects:

1. Uphold our [Community Code of Conduct](https://about.gitlab.com/community/contribute/code-of-conduct/).
1. Enable [GitLab's mission that everyone can contribute.](/handbook/company/mission/#mission).
1. Show our work in [public](#public-by-default).
1. [Recognize and thank](/handbook/marketing/developer-relations/contributor-success/community-contributors-workflows/#recognition-for-contributors) contributors for their work.
1. Respect contributors donated time by providing [a timely review turnaround time](/handbook/engineering/workflow/code-review/#review-turnaround-time).

### Working with Open Source communities

The [open core of GitLab](/handbook/company/stewardship) is built on top of thousands of open source
dependencies. These dependencies and their communities are important to the [GitLab strategy](/handbook/company/strategy/#flywheel-with-two-turbos),
and working with these dependencies is an essential part of the projects the team maintains.

We strive to:

1. Consider the impact of our work on the open source communities that we benefit from.
2. Promote the importance of these open source communities within GitLab.
3. Raise issue with any decision that goes against our [stewardship promises](/handbook/company/stewardship/#promises).
4. Find opportunities to [contribute back the changes we make](/handbook/engineering/open-source/#using-forks-in-your-code).

## Public by default

All work carried out by the team is public. Some exceptions apply:

- Work has possible security implications - If during the course of work security concerns are no longer valid, it is expected for this work to become public.
- Work is done with a third party - Only when a third party requests that the work is not public.
- Work has financial implications - Unless financial details can be omitted from the work.
- Work has legal implications - Unless legal details can be omitted from the work.

Some of the team work is carried out on our development server at `dev.gitlab.org`.
[Infrastructure overview document](https://docs.gitlab.com/omnibus/release/#infrastructure) lists the reasons.

Unless your work is related to the security, all other work is carried out in projects on `GitLab.com`.
If you need to submit a sensitive issue, please use confidential issues.

If you are unsure whether something needs to remain private, check with the team Engineering Manager.

## Work Resources

General resources available to developers are listed in the
[Sandbox cloud page](/handbook/company/infrastructure-standards/realms/sandbox/).

In the team specifically, everyone should have access to the
following resources:

- Google projects in [Google Cloud Platform](https://console.cloud.google.com/)
  - `testground`
  - `cloud-native`
  - `omnibus-build-runners`
- AWS build infrastructure
  - Distribution group AWS sandbox account
  - `cloud-native` EKS cluster for CI (requires a maintainer to [grant access](https://stackoverflow.com/questions/59987859/kubectl-error-you-must-be-logged-in-to-the-server-unauthorized/59991446#59991446))
  - [GitLabTop account](https://gitlab-top.signin.aws.amazon.com/console) (To be retired, existing team members only)

If you don't have access to any of these resources, create an
[Access Request](https://gitlab.com/gitlab-com/team-member-epics/access-requests/-/issues) and
assign it to your manager for approval.

## Work/life harmony

Working [all-remote](/handbook/company/culture/all-remote/) and [asynchronous first](/handbook/company/culture/all-remote/asynchronous/)
offer flexibility in how team members approach their workday. Team members must make choices on how best to balance work time with other areas of life.

For new team members, the following resources provide examples on how to focus their time:

- [How team members approach their day](https://gitlab.com/gitlab-org/distribution/team-tasks/-/issues/907)
- Blog post: [A day in life of a remote worker](https://about.gitlab.com/blog/2019/06/18/day-in-the-life-remote-worker/)
- The option of a [non-linear workday](/handbook/company/culture/all-remote/non-linear-workday/)
- GitLab handbook: [Work/life Harmony](/handbook/company/culture/all-remote/people/#worklife-harmony)

The following GitLab Handbook areas are key in maintaining a healthy work/life balance.

- [Family and Friends First, work second](/handbook/values/#family-and-friends-first-work-second)
- [Combating burnout, isolation, and anxiety in the remote workplace](/handbook/company/culture/all-remote/mental-health/)
- [Recognizing Burnout](/handbook/people-group/paid-time-off/#recognizing-burnout)
