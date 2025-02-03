---
title: "CSM Issue Tracking and OKRs"
description: "Field guide for CSMs on team OKRs"
---

For more information visit GitLabs [Objective and Key Results (OKRs)](/handbook/company/okrs/) page.

---

## Purpose

This page provides an overview of CSM team issue tracking, OKRs, and the OKR process. 

OKRs should provide continuous strategic alignment with the business. Our Big Rocks are our annual OKRs and our quarterly OKRs contribute to them.

GitLab.com (Epics/Issues) is THE best place to track the work we are doing! The goal is a streamlined way to submit ideas, have those prioritized and agreed and then coordinate the team to work on key focus areas to get the job done. We can't work on everything at once, so we aim to empower everyone to submit ideas and collaborate while keeping actual work focused on core priorities. 

Additionally, this process should lead the way in leveraging GitLab features to demonstrate we can eat our own dog food and live a customer's life in our day-to-day duties. The team should have a single process to provide updates on progress and communicate the likelihood of achieving the outcomes below:

- Leadership able to easily track work across teams

- Team-level organization to see progress and where help is needed

- Managers support in 1:1s with an improved view of individual team member's internal work


## Terminology

- **Objective:** The Mission

- **Key Results:** Measures of movement and behavior

- **Initiatives:** Activities that we theorise will move the key results in a direction that brings us closer to achieving the Objective.

## Why is it Important We Do This Now?

- Improved visibility of team workload and priorities

- Streamlined idea submission and review process

- Enhanced ability to track progress and identify bottlenecks

- Better alignment of work with strategic priorities

- Increased transparency and collaboration within the team

- Data-driven decision-making through GitLab's reporting features

## Principles

OKRs Should be Inclusive (Segments, regions etc) and lean in to heavily into our [bias towards asynchronous contributions](/handbook/values/#bias-towards-asynchronous-communication).

### Objectives

- Outcome over output

- Inspirational and aspirational

- Avoid overlapping objectives

- Business aligned

### Key Results

- Measurable

- Standard format: `<Verb> <measure> from <x> to <y>`

- Leading and lagging measures

- No more than 3 to 5 Key Results per OKR

## What Impact will this have to GitLab and its Customers?

This will have significant impacts on both GitLab and its customers:

### For GitLab

- Demonstrates the effectiveness of GitLab's own tools for project management

- Improves internal efficiency and productivity of the CS AMER team

- Enhances cross-functional collaboration and transparency

- Provides real-world use cases and feedback for product improvements

- Strengthens the company's "eat our own dog food" philosophy

### For Customers

- Leads to more responsive and efficient customer support

- Provides a relatable example of GitLab usage for project management

- Potentially results in improved features based on internal feedback

- Demonstrates GitLab's commitment to using and improving its own products

## Data Model

- **Issues:** Represents an Idea or Project to be undertaken. An Issue should represent no more than a quarter of duration of an activity. If it is more than a quarter, we should break it down into multiple issues.

- **Labels:** Will be used to track additional reporting attributes and manage workflow state

- **Epic:** Should indicate/tie an Issue back to a Strategic Objective / Pillar for CS

- **Milestone:** Should be the fiscal quarter we are planning to deliver & close the work

## Process

### Issue Board

For an overview of the current CSM OKRs, please see [CSM OKR issue board](https://gitlab.com/gitlab-com/customer-success/okrs/-/boards/5194678?label_name[]=CSM&label_name[]=FY24-Q1)

### Proposing OKRs

### Idea Submission

- Team members create new issues with the "New Ideas" label.

- Use the issue template below for consistent information capture. The template should capture:

  - 30-sec elevator pitch

  - Why is it important we do this now? Is this due to an OKR?

  - What impact will this have to GitLab and its customers?

  - Team member and resource support to get it done?

  - Estimated Effort and ETA

## Ownership and Resourcing

- Once prioritized, projects will be assigned a CS Manager as DRI

- Using a CS Manager as DRI ensures we have visibility across the CS leadership team and can fairly represent the workload in any further resourcing/prioritization discussions

- In addition to the CS Manager, at least one Senior/Staff CSx team member should be assigned to lead the discussion and at least one additional CSx team member to assist with the effort. If at least 2x team members can't be identified to drive the issue to closure, then please realign with the CS Manager to discuss whether this is a current priority or should wait for additional team member availability.

## Review and Prioritization

- Regular management team meetings to review "New Ideas" issues

- Categorize and prioritize issues using the labeling system (this should link to the labeling system section below) 

- Include Mgr CS as DRI

- Identify 2x CSx, at least one Staff/Senior to manage the issue

- Remove the "New Ideas" label after review

## Workload Management

- Use Priority::Top-5 label for immediate action items determined by Mgr CS (This would include when tied back to a Big Rock or OKR)

- Assign high-priority issues to the current sprint/work cycle determined Mgr CS

- Utilize GitLab boards for workflow visualization

## Backlog Management

- Non-priority issues remain in the backlog

- Regular backlog review and reprioritization

- Use milestones for future sprint planning

## Progress Tracking

- Implement time tracking on issues

- Use "At Risk" health status for stalled issues

- Use "On Track" health status for issues progressing as expected

- Use "Needs Review" health status for flagging to management for attention

## Triage Bot Policies

Triage bot utilizes policies to determine what actions to perform on what items. 

Each policy contains rules for the resource set. These rules are contained within an array that detail what to run on and what to actually do. Triage bot fields are:

| Missing Field | Example |
| ------------- | ---- |
| Issue Assignee | @csmname  |
| Priority Label | ~"Priority::Top-5"  |
| Team Label | ~"Team::CSM"   |
| Status/At Risk label  | ~"SP Objective::Status::On Track"   |
| Region label  | ~"CS Region::AMER"   |
| OKR label  | ~"OKR::Yes"  |
| LT Sponsorship label  | ~"CSLT::CS DIR NAME"  |
| Fiscal quarter label  | FY26-Q1  |
| XLT DRI label  | ~"CSXLT::MGR CS NAME"  |

## Completion and Review

When the work is complete, label the issue with CS::Ready to indicate that it is done and needs final review by CS Managers and potentially external stakeholders.

- Prior to tagging CS::Ready, conduct retrospectives and provide summary lessons learnt on the issue. Ensuring we have Lessons Learnt or Objectives Achieved allows us to share & celebrate the work done and completed.

- Post Review, if no other action is required, move completed issues to "Done" on the board.

## Labeling System

- **Region**

  - CS Region::AMER

  - CS Region::EMEA

  - CS Region::APJ

- **Team**

  - Team::CSM

  - Team::CSA

  - Team::CSE

  - Team::RM

- **OKR/non-OKR**

  - OKR::Yes

  - OKR::No

- **Quarter**

  - FYXX-QX

- **Priority**

  - Priority::Top-5

  - Priority::High

  - Priority::Medium

  - Priority::Low

- **Status/At Risk**

  - SP Objective::Status :: On Hold

  - SP Objective::Status :: Concern

  - SP Objective::Status :: On Track

  - SP Objective::Status :: Not Started

  - SP Objective::Status :: Watchpoint

  - SP Objective::Status :: Closed Success 

  - SP Objective::Status :: Closed Not a Priority

- **LT Sponsorship**

  - CSLT:: VP or Dir DRI NAME

- **XLT DRIs**

  - CSXLT:: MGR DRI NAME

## OKR Schedule

The CSM OKR timeline is as follows:

| Quarter Start | Task |
| ------------- | ---- |
| 4 weeks out | VP shares top goals with leadership team for feedback |
| 4 weeks out | Leadership team collaboratively draft goals for next quarter and agree DRIs |
| 4 weeks out | Leadership team review current OKR status |
| 2 weeks out | Leadership team 50 minute draft review meeting. After, OKRs are put into GitLab and links are shared in #csm-updates Slack channel  |
| 2 weeks out | Leadership team discusses with their respective teams and polishes OKRs |
| 1 week out | Closing ceremony and playback of previous OKRs |
| 0  | Update OKRs to be active |

### Additional Resources

[Short tutorial of process](https://drive.google.com/file/d/1eBFqOgBgCJBf-aMPWL2ILyonEj_dYCx3/view)
