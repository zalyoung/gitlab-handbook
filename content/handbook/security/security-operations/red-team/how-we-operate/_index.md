---
title: "How the Red Team Operates"
---

# How the Red Team operates

- [rules of engagement](rules-of-engagement.md)

## Reporting

All operations end with a final report. We use an issue template which is [shared publicly here](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-public/resources/red-team-issue-templates).

Security risks affect everyone, and it is essential to make our reports approachable and consumable to a broad audience. To achieve this, we make an effort to [use simple language](/handbook/communication/#simple-language). Our goal is to ensure that anyone in the company can understand the reports, even if they don't have a background in security.

After an operation has concluded, if relevant, we will create a short video summarizing the operation, which should not exceed five minutes. We will also schedule synchronous meetings with our Security Incident Response Team (SIRT) to go over the various attack steps of the operation and review detections and alerts.

We will then share the following in `#whats-happening-at-gitlab` and cross-post it in `#security`:

- A very short summary of the operation, including the video overview if there is one
- A link to the final report
- A link to the retrospective issue to solicit questions and feedback
- A disclaimer to keep the information [SAFE](/handbook/legal/safe-framework/#how-do-we-reinforce-safe).
- A tagged list of individual operation participants as well as the Security Incident Response Team (SIRT) as a whole for awareness since not all team members participate in an operation each time.

By doing this, we help foster a culture of security awareness throughout the organization and ensure that everyone can benefit from our work.

## Red Team Maturity Model

We use a custom maturity model to measure our progress and help guide our decisions. This is loosely based on the [Capabilities Maturity Model (CMM)](https://en.wikipedia.org/wiki/Capability_Maturity_Model). Our model contains five stages of maturity, each with very specific behaviors we strive to demonstrate and states we hope to achieve.

We built this using a GitLab issue board, with each maturity level being a list and each item being an issue. We can collaborate inside the issues, discussing our progress and providing links to related issues and merge requests. As we work on specific items, we will add custom labels to indicate an item is in progress, established, or replaced by an item in a latter maturity level.

GitLab team members can view the model [here](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-internal/red-team-maturity-model).

## Red Team Metrics

### Adoption Rate

A successful Red Team program strengthens an organization's security through recommendations that are adopted, (i.e. accepted and ultimately implemented) by the organization. We track the lifecycle of these recommendations through to implementation using GitLab.com, calling this metric our "Adoption Rate."

Recommendations start as GitLab.com issues in the project closest to the team that can address them. We classify recommendations using labels:

- Detections & Alerts (`RTRec::Detection`)
- Security Controls (`RTRec::Control`)
- Processes and Procedures (`RTRec::Process`)

We track what happens after a recommendation is delivered by adding a secondary label to the issue with its current status or final outcome:

- Under review (`RecOutcome::UnderReview`)
- Accepted and actively being worked on (`RecOutcome::InProgress`)
- Accepted but backlogged (`RecOutcome::Backlogged`)
- Accepted but blocked (`RecOutcome::Blocked`)
- Fully adopted and closed (`RecOutcome::Adopted`)
- Partially adopted and closed (`RecOutcome::PartiallyAdopted`)
- Not adopted and closed (`RecOutcome::NotAdopted`)

An outcome label is added to the issue within one week of delivering the recommendation. A scheduled CI pipeline checks issues with classification labels to ensure they have an outcome.

### MITRE ATT&CK Mapping

[MITRE ATT&CK](https://attack.mitre.org) is a framework for classifying and describing cyber attacks. We use ATT&CK extensively, as it helps us to align our operations to realistic threats and to speak a common language across security groups.

We use a combination of GitLab CI pipelines and GitLab Pages to build and host two reporting tools from MITRE:

- [MITRE ATT&CK Flow](https://github.com/center-for-threat-informed-defense/attack-flow)
  - [Our internal automation project](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-internal/automation/ci-attack-flow)
  - [Our internal build](https://flow.gl-redteam.com/)
- [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)
  - [Our internal automation project](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-internal/automation/ci-attack-navigator)
  - [Our internal build](https://navigator.gl-redteam.com/)
  - [Public blog describing the project](https://about.gitlab.com/blog/2023/08/09/gitlab-mitre-attack-navigator/)
