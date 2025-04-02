---
title: "Iteration 0"
description: "Learn about the first step of a GitLab PS engagement with a customer."
---

Iteration 0 starts with our internal EM>PS Transition meeting and goes through the Planning and Design Sessions with the Customer

[Guidelines for PSDM management](../_index.md#guidelines-for-psdm)

## EM>PS Transition

During this phase, the Delivery team works to gather context on the account (business drivers, etc), and validate the SOW & next steps

We use the Scheduling Intake, and Scoping issues a guide for this initial meeting. Both of which, are attached to the Customer Epic

The output of this meeting is to ensure the Delivery team is prepared, and we have a plan heading into Stakeholder Planning, Kickoff, and P&D sessions with our customers

### Meeting prep & facilitation guidance

The PM works to setup this intial transition meeting with the Engagement Manager, Technical resource(s) assigned, Account Managers, and Customer Success Managers (if assigned)

Please reference [Iteration 0 Fundamentals](../iteration-0-fundamentals/_index.md) as we prepare for the transition meeting and work through Customer Kickoff and P&D. It is valuable to reference our [Delivery Kits](https://gitlab.com/gitlab-org/professional-services-automation/delivery-kits) to gather prerequisite data we will be sharing in our Stakeholder Planning & Kickoff review with the Customer

A reminder to [think big in discovery](../discovery/_index.md) and consider [team alignment for production readiness](../iteration-0-fundamentals/_index.md#engagement-planning). Goal is to head into the Initial Planning and Design meetings with our customers confidently and well prepared

The Delivery team can use the Schedule Intake issue or [this template](https://docs.google.com/document/d/1bpyhc-a1z573EsyIQtUE-7HS_QauDVmQsHP25PD9i1A/edit) to facilitate the meeting

For larger/complex programs with multiple stakeholders, please work to fill out [this RACI](https://docs.google.com/spreadsheets/d/1nb_sEI-M3IwNgkYQA2uKAo9IDijstPtUGCtLsHlwrtI/edit?gid=1394419027#gid=1394419027) as an output of this meeting

## Stakeholder Planning Meeting

During this meeting, the PM on the GitLab & Customer side meet to review the high level scope, confirm resourcers on their end, gather any onboarding material that is still missing, and start to action dependancies needed begin our work. This is an opportunity to meet each other and begin to build trust. Additionally, this is an opportunity to review how we plan to manage the project within GitLab, our expected project velocity, and action items we will need to begin our owrk. We will take this information to our Customer kickoff and review it with the broader project teams. Please use the [Stakeholder Planning](https://docs.google.com/presentation/d/1vVJQrJeGG-yLAeso_iKkb80H5kE7wStyBAj1sj45sY4/edit#slide=id.g923452f41b_1_5) Meeting template to facilitate this meeting

1. Project Stakeholders
1. Project Objectives
1. Expectations around Project velocity
1. Review Project Prerequisites
1. Kickoff Prep
1. Onboarding validations
1. Next Steps

## Customer Kickoff

Before we enter Project Kickoff, the goal is to confidently be on the same understanding of Project expectations as the Customer. This is why we have spent so much effort gathering the initial information from both the account team & the Customer. Now its time to validate and hit the ground running

* The template for our Kickoff deck can be found [here.](https://docs.google.com/presentation/d/1Sva2u7NGxUTmDxQNBpqmFm_ep9HHlU86WyhON-To5lU/edit#slide=id.g3427bc5c553_0_243)
* Our SteerCO template can be found [here](https://docs.google.com/presentation/d/1TDKOJeuzR1uy18umu6ovy30l_A986pOEatFn_7eiNbQ/edit#slide=id.g2e563e08cf5_0_1)

output: prepared & scheduled Discovery & Planning sessions, and [Iteration Cadences](../iteration-scheduling/_index.md) are confirmed by the Customer

## Prepare Support for Issues

To better support our engagement, we can proactively prepare the Support team by providing key project information in advance. This process enables us to pre-populate support tickets with relevant notes when a customer opens them during the engagement. Throughout the engagement, product issues, bugs, or unexpected functionality may occur. Additionally, there could be corruption or environment issues on the customer’s side that were not initially scoped into the engagement, requiring involvement from Support or Product teams. By ensuring that pertinent data is readily available, we can streamline collaboration and resolve issues more efficiently as they arise. While this process is critical for any infrastructure-related project, such as implementations, it can also be valuable for other engagements where support issues may occur

### Getting Access to ZenDesk Ticket System

If you do not have ZenDesk light (Read-Only) open an [Access Request](https://gitlab.com/gitlab-com/team-member-epics/access-requests/-/issues/new?issuable_template=Individual_Bulk_Access_Request) requesting one.

### Creating a ZenDesk Note for Support

1. Find the relevant org `.yaml` find in the [Repository](https://gitlab.com/gitlab-com/support/zendesk-global/organizations/-/tree/master/organizations) by [Searching](https://gitlab.com/search?search=&nav_source=navbar&project_id=27675679&group_id=78867384&search_code=true&repository_ref=master) for the Customer Name (It will be a hash, followed by the name in Salesforce)
![image](/images/customer-success/professional-services-engineering/professional-services-delivery-methodology/iteration-0/Zen-search.png)

1. Create a new Merge Request by Selecting the YAML from Search. Then `Edit > Open in Web IDE`
![image](/images/customer-success/professional-services-engineering/professional-services-delivery-methodology/iteration-0/edit-yaml.png)

1. Add the block below after notes starting with a pipe "|" (this Character indicates a multi line entry). The fields should be spaced 1 tab from notes
Include the details below and anything else that would be helpful for support to know when engaging the customer. If notes content already exists append this to it to include both

   ```yaml
   ---
   id: 27946339528
   name: 5a1f9965 Test Account
   notes: |
      PS Project in Progress
      Project Manager:
      Slack Channels:
      Engineers:
      Start Date:
      Anticipated End Date:
      Summary of Engagement:
      Support should know:
      Collaboration Project RAID(Issue) Board Link:
   ```

1. Commit your changes by clicking the Source Control Button (noted with 1 change) > The drop down arrow > Create new branch and commit
![image](/images/customer-success/professional-services-engineering/professional-services-delivery-methodology/iteration-0/newmr.jpg)

1. Hit Enter to accept the default branch name (Should by a combination with your user name)

1. Select the Create MR Button on the bottom right of the Web IDE

1. Ask a Support Leader to review and merge your MR by sharing a link to your MR in [#support_leadership](https://gitlab.enterprise.slack.com/archives/C01F9S37AKT) on Slack

1. At the close of the project repeat this step, but remove the contents added after notes
