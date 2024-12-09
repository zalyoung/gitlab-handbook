---
title: "Static Analysis Group Reaction Rotation"
---

## Reaction Rotation

Each milestone, two engineers in the team are assigned the role of Reaction Rotation, one as Primary and the other as Secondary. The assignments are in the [rotation schedule](https://gitlab.com/groups/gitlab-org/-/epics/15743#rotation-schedule).

The Secondary role is to step-in when the Primary is unavailable or over capacity. In such instances, the Secondary assumes the same responsibilities as the Primary, but otherwise they work on tasks planned for the milestone.

### Responsibilities

The Reaction Rotation role has these responsibilities:

- Perform [SAST Analyzer Vulnerability Management](#sast-analyzer-vulnerability-management)
- Respond to [Requests for Help](#requests-for-help)
- Answer [Slack Questions](#slack-questions)
- At the end of rotation update the membership for [`@gitlab-org/secure/static-analysis/reaction-rotation`](https://gitlab.com/groups/gitlab-org/secure/static-analysis/reaction-rotation/-/group_members?with_inherited_permissions=exclude) by removing the current engineers, and adding the next ones.

The Primary engineer can solicit help from the other engineers in the team. For example, when a task is not in their area of expertise, and they have already spent significant time (i.e. hours) without much progress; or when they're unable to keep-up with the volume of tasks.

Assistance should initially come from the Secondary engineer as to minimize disruption to milestone deliverables but all engineers should take into consideration that they may be pulled in to assist on a rotation task.

#### SAST Analyzer Vulnerability Management

The vulnerabilities for analyzers owned by Static Analysis need to be triaged and addressed.

1. Go to the [list of vulnerabilities for SAST/IaC (sorted by SLO)](https://gitlab.com/gitlab-org/gitlab/-/issues/?sort=label_priority_desc&state=opened&label_name%5B%5D=group%3A%3Astatic%20analysis&label_name%5B%5D=bug%3A%3Avulnerability&not%5Blabel_name%5D%5B%5D=Vulnerability%3A%3AVendor%20Package%3A%3AFix%20Unavailable&not%5Blabel_name%5D%5B%5D=Vulnerability%3A%3AVendor%20Package%3A%3AWill%20Not%20Be%20Fixed&not%5Blabel_name%5D%5B%5D=Vulnerability%3A%3AVendor%20Base%20Container%3A%3AFix%20Unavailable&not%5Blabel_name%5D%5B%5D=Vulnerability%3A%3AVendor%20Base%20Container%3A%3AWill%20Not%20Be%20Fixed&first_page_size=100)
1. In decreasing order of severity, assign yourself to the issue.
1. Work on the issue:
   1. fix the bug; or
   1. determine whether it needs to remain open, and handle the SLO exception process.

#### Requests for Help

Issues are created in the [section-sec-request-for-help](https://gitlab.com/gitlab-com/sec-sub-department/section-sec-request-for-help) project. During Reaction Rotation, the assigned engineer must review the [open issues](https://gitlab.com/gitlab-com/sec-sub-department/section-sec-request-for-help/-/issues?first_page_size=20&label_name%5B%5D=Help%20group%3A%3Astatic%20analysis&sort=created_date&state=opened) and engage with each issue.

If a request for help highlights a bug or feature request, create an issue in the public tracker, link to it in the request for help issue, and close the latter.

#### Slack Questions

Check the [Static Analysis Slack Channel](https://gitlab.enterprise.slack.com/archives/CLA54H7PY) and respond to any questions asked or delegate/ping a person that may know the answer. As with [Requests for Help](#requests-for-help), if the question concerns a bug or feature request, create an issue.
