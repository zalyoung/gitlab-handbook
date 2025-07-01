---
title: Database Framework Group
---

## Vision

Developing solutions for scalability, application performance, data growth and
developer enablement especially where it concerns interactions with the
database.

## Mission

Focusing on the database, our mission is to provide solutions that allow us to
scale to our customer's demands.  To provide tooling to proactively identify
performance bottlenecks to inform developers early in the development lifecycle.
To increase the number of database maintainers and provide database best
practices to the community contributors and development teams within GitLab.

## Team Members

The following people are permanent members of the Database Team:

{{< team-by-departments "Database BE Team" >}}

## Stable Counterparts

The following members of other functional teams are our stable counterparts:

| **Name**                                                 | **Role** |
| -------------------------------------------------------- | -------- |
| [Sampath Ranasinghe](/handbook/company/team#sranasinghe) | [Senior Product Manager, Geo and Database](/job-families/product/product-manager) |
| [Ben Prescott](/handbook/company/team#ben-prescott) | [Staff Support Engineer](/job-families/engineering/support-engineer/) |

### Stable Counterparts to other teams

The Database Group is often called upon to provide consulting to other groups.
To more efficiently support these requests we have created this [stable counterparts table](stable.html).

## Meetings

Whenever possible, we prefer to communicate asynchronously using issues, merge
requests, and Slack. However, face-to-face meetings are useful to establish
personal connection and to address items that would be more efficiently
discussed synchronously such as blockers.

- Database Group Sync every Tuesday at 13:00 UTC and Thursday at 21:00 UTC
  - Typically we talk about infradev issues or triage, then team members are given
    an opportunity to discuss blockers or concerns. Then we close by talking about
    something fun.
- Database Staff Planning every Wednesday at 21:00 UTC
  - Limited group discusses current and up coming high level epics to sync on planning
    and backlog prioritization.

## Work

We follow the GitLab [engineering workflow](/handbook/engineering/workflow/)
guidelines.  To bring an issue to our attention please create an issue in the
relevant project.  Add the `~"group::database"` label along with any other
relevant labels.  If it is an urgent issue, please reach out to the Product
Manager or Engineering Manager listed in the [Stable Counterparts](/handbook/engineering/infrastructure-platforms/data-access/database-framework/)
section above.

### What we do

The team is responsible for the PostgreSQL application interactions to enable
high performance queries while offering features to support scalability and
strengthen availability.  PostgreSQL is the heart of Rails application, and
there is no shortage of work to make GitLab more performant, scalable, and
highly available from database perspective.  Some of the current priorities
include implementing partitioning to improve query performance and creating
tooling to enable development teams to implement their own partitioning
strategies more easily.  We are working on tools that will help developers
"shift left" in their migration testing prior to deployment.  We are always
looking for ways to continuously care for the performance of our databsae and
improve our developer documentation.  For more in-depth details of what we are
working on please review our [Roadmap](#roadmap) section below.

In order to follow what the database group is currently working on, we recommend
watching our [group's kickoff presentations for new milestones](https://www.youtube.com/playlist?list=PL05JrBw4t0KqP3MYrcoQHrqPUqn_jJZSN)
and [the respective milestone planning issues](https://gitlab.com/gitlab-org/database-team/team-tasks/-/issues?scope=all&state=all&search=database+group+planning).

## Planning

We do high level project planning on our [roadmap board](https://gitlab.com/groups/gitlab-org/-/epic_boards/2066534).
given the often pressing and interruptive nature of our team's work, we typically
plan only "Current", "Next", and "Eventually".

In progress work is tracked on our [team status epic](https://gitlab.com/groups/gitlab-org/data-access/dbf/-/epics/1)
which pulls status updates from the linked epics to the summary table in the
description.

### Project Lifecycle

Projects go through a few different phases throughout their development.

#### 1. Problem Validation

New epics are created with the [database frameworks project template](https://gitlab.com/gitlab-org/database-team/team-tasks/-/raw/master/Epic%20Templates/New%20Project.md)

During problem Validation, the team and manager will review a proposed epic, ask questions, and flesh out details. Once it's agreed that that it's
a problem we both want to solve, and agree on the priority, we'll apply the `~"workflow::planning breakdown"` and `~Roadmap`, and the label for when we think we want to do the project (`~"roadmap::next" or ~"roadmap::later") labels and move to the next phase.

#### 2. Planning Breakdown

During planning breakdown, assigned members of the team look at the proposed exit criteria, and the current state of the application and
determine the path we want to take in order to get to there. Typically, we'll consider several proposed solutions and then decide on one. This may happen either async in an issue, or synchronously in a recorded meeting with stakeholders.

Once the high level phases are determined, and the project is ready to be started, we'll apply `~"workflow::ready for development"`.

#### 3. Project Execution

Once a project is actually started, we apply the `~"workflow::in dev"`, to the project at a high level, as well as to the issues it contains as we go.

Each week, the epic status summary bot will ask for updates on the epic and summarize them in the team status epic.

#### 4. Verification

Once a project is complete, we have a final phase where we monitor the results and create follow up items to plan for a future iteration. These may be
bugs, or they could be improvements. We may have a milestone or two of `~"workflow::verification"` after the main items are completed.

- Work discovered in this phase may not be completed right away, but scheduled in one of our "Misc Buckets" down the line
- Bugs might be tackled right away if they're bad
- Consider a second project to tackle follow up items if there's another major iteration to do

### Project Roles

Each project will have 1-n team members assigned to work on it, within those folks there are
a couple of distinct roles, with specific responsibilities.

#### Project DRI

The project DRI is primary point of contact for a given project. If there are questions or issues, they're
the first point of contact while a project is in progress.

##### Responsibilities

- Serve as primary decision maker about the direction a project should go
- Provide a weekly status update every Tuesday on the current status of the project
- Triage project related issues and bugs for priority and severity
- Coordinate the project with assigned project members
- Set up and facilitate any sync meetings the project requires

**Note**: If a DRI is on PTO, their [coverage issue](https://gitlab.com/gitlab-com/engineering-division/pto-coverage) should designate
someone who will cover these responsibilities during that time period.

#### Project Member

A project member will be assigned to the epic, and complete portions of the work.

##### Responsibilities

- Complete issues in the project, coordinated with the [Project DRI](#project-dri)
- Attend any project sync meetings as necessary to coordinate and complete the work
- Serve as a backup DRI if the project DRI is unavailable

#### Project Mentor

We may sometimes assign project mentors as needed. Unlike members or DRIs, Mentors typically don't work
on the actual changes, but instead are available as guides during the design phase, and ongoing helping
the DRI complete their duties.

##### Responsibilities

- Assist the DRI with their responsibilities
- Optionally attend any sync meetings the project requires

### Issue Weights

The database group is experimenting with using expected merge request count as
an issue weight. Before each milestone starts, we'll ping each assigned issue
without a weight and ask folks to add weights to them.

We decided to use merge request count as an issue weight for a few reasons:

- The process encourages folks to consider ahead how an issue could be broken
  down more and enumerate it in advance
- It's easy to describe and learn, making it easier for the team to come to a
  shared understanding
- Merge request rate is one of the main ways our team is measured

#### Process for weighting Issues

1. With an emphasis towards smaller more iterative changes rather than large
   changes that may take longer to review and merge, consider how many merge
requests could this be broken into.
1. Add a comment enumerating the expected merge requests. For example:

   > Just one merge request to documentation
   >
   > One to gitlab for database changes, one for new functionality, one for
   > documentation changes, and one to omnibus

1. Add the count as a weight. For example, if you think there could be one to
   gitlab for database changes, one for new functionality, one for documentation
changes, and one to omnibus - you would assign `/weight 4`

## Triage rotation

We have a fairly simple triage rotation. Each week one team member is dedicated
to triaging incoming issues for the database group. This allows for the rest of
the team to focus on their current priorities with fewer interruptions. Each
week, a bot will file an issue that gets automatically assigned to next team
member in the rotation. We order the triage rotation by alpha-order based on
first name to keep it very simple. If a team member is on PTO the week they are
assigned, the issue will be re-assigned to the next person.

Issues needing triage can come in through many different paths. Some common
areas to monitor while on triage:

- Newer issues (< 7 days old) with the `~database` label that are not assigned
  to a group. [Example search](https://gitlab.com/groups/gitlab-org/-/issues?label_name%5B%5D=database&scope=all&sort=created_date&state=opened&utf8=%E2%9C%93)
- Newer issues that were assigned `~group::database` but do not have a
  throughput label or `~database::triage` labels. [Example search](https://gitlab.com/dashboard/issues?scope=all&state=opened&label_name[]=group%3A%3Adatabase&not[label_name][]=type%3A%3Abug&not[label_name][]=type%3A%3Afeature&not[label_name][]=type%3A%3Amaintenance&not[label_name][]=type%3A%3Aignore)
- Newer issues that were assigned `~database::triage` and have not previously
  been reviewed
- When we get pinged on the #g_database slack channel for assistance

When the triage team member discovers an issue requiring team attention some of
the possible outcomes are:

- Directly address the issue if it is a simple fix
- Direct to our customer support counterparts as appropriate
- Add the `~database::triage` label and review during team sync meeting
- Add a milestone and ping the manager, or label the issue
  `~workflow::scheduling`
- Close as duplicate and link to the duplicate issue

## Boards

[Database by Milestone](https://gitlab.com/groups/gitlab-org/-/boards/1318796?&label_name%5B%5D=group%3A%3Adatabase)
The Milestone board gives us a "big picture" view of issues planned in each
milestone.

[Database: Build · Boards · GitLab.org · GitLab](https://gitlab.com/groups/gitlab-org/-/boards/1324138) The build board
gives you an overview of the current state of work for `group::database`. These
issues have already gone through validation and are on the [Product Development Build Track](/handbook/product-development/product-development-flow/#build-track). Issues are added
to this board by adding the current active milestone and `group::database`
labels. Issues in the `workflow::ready for development` column are ordered in
priority order (top down). Team members use this column to select the next item
to work on.

### Roadmap

The Database Group
[roadmap board](https://gitlab.com/groups/gitlab-org/-/epic_boards/2066534)
gives a view of what is currently in flight as well as projects that have been
prioritized for the next 3+ months.

## Documentation

We document our insights, road maps and other relevant material in this section.

1. [Database Lexicon - terms and definitions relating to our Database](doc/lexicon.html)
1. [Database Strategy: Guidance for proposed database changes](doc/strategy.html)
1. [On table partitioning](doc/partitioning.html) (February 2020)
1. [Postgres: Sharding with foreign data wrappers and partitioning](doc/fdw-sharding.html)
1. [Sharding GitLab by top-level namespace](doc/root-namespace-sharding.html)
1. [Sharding with CitusDB](doc/citus.html) (April 2020)
1. [Table partitioning: Issue group search as an example](doc/issue-group-search-partitioning.html) (March 2020)
1. [Working with the GitLab.com database for developers](doc/gitlab-com-database.html)
1. [Database schema proposals for Container Registry](doc/container-registry.html) (September 2020)
1. [Workload analysis for GitLab.com](doc/workload-analysis.html) (October 2020)
1. [Multi-database Background migrations](doc/multidb-bg-migrations.html)
   (October 2021)

### Performance Indicators (Internal)

1. [Enablement::Database - Performance Indicators Dashboard](https://10az.online.tableau.com/#/site/gitlab/workbooks/2326872/views)
1. Average Query Apdex for GitLab.com
   - Master
     - [Target: 100ms - Tolerable 250ms](https://tinyurl.com/64e6acku)
     - [Target: 50ms - Tolerable 100ms](https://tinyurl.com/4mjw5azv)
   - Replicas
     - [Target: 100ms - Tolerable 250ms](https://tinyurl.com/yde68e2k)
     - [Target: 50ms - Tolerable 100ms](https://tinyurl.com/42wc7n2z)

### Common Links

- Slack Channel
  [#g_database](https://gitlab.slack.com/app_redirect?channel=g_database) -
Official Business
- Slack Channel
  [#db-lounge](https://gitlab.slack.com/app_redirect?channel=db-lounge) - Team Chat
- [Database Epics](https://gitlab.com/groups/gitlab-org/-/epics?scope=all&utf8=%E2%9C%93&state=opened&label_name[]=group%3A%3Adatabase)
- [Database Subgroup](https://gitlab.com/gitlab-org/database-team) - Issues and
  templates related to team processes.
- [Product Development Timeline](/handbook/engineering/workflow/#product-development-timeline)
- [YouTube: Database Team Playlist](https://www.youtube.com/watch?v=BqwsRDpknfg&list=PL05JrBw4t0KoxfN-uO2YfvQUabp2kdUYT)
- [YouTube: Database Office Hours Playlist](https://www.youtube.com/watch?v=p3ful2h8H-c&list=PL05JrBw4t0Kp-kqXeiF7fF7cFYaKtdqXM)
