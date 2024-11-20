---
title: "Demo Architect Offerings"
description: "This guide will outline all of the offerings from the Demo Architect team"
---

## Demo Architect Offerings

### Term Definitions

Before we jump into all of the offerings we need to first cover definitions because how GitLab references workshops, labs etc. may not be the same as where you worked before:

- Workshop: this most often refers to a large online (or sometimes in person) event put on by the Field Marketing team. Goal attendance for these events would be around 250 students with a full GitLab staff MCing and helping with questions. Realistically they are more like a webinar with hands-on exercises as the instructor does not directly interact with any of the students.
- Lab: Also called hands-on exercise, workshop etc. These are smaller, more personal events that fit into what you would traditionally call a workshop. The goal of these is to sell personalized content to a customer through an interactive hands-on activity that we have planned out.
- Demos: whenever this doc mentions demos it is talking about ready to go projects/scripts/videos that you can then use in your own calls. If there is no hands-on component that falls into the Demo category.
- Lunch & Learns: Primarily a term used by the CSE/CSM group to describe demos they give to a larger crowd. Will typically cover a topic like CICD in a short time frame with no hands-on portion. Almost all of the content here can be converted to this format.
- Cohorts: Term for a session put on by the CSE team that is halfway between a lab and a workshop. The content is typically a workshop focusing only on the important stuff, but also is in a setting where the students can ask questions live.

### Workshops

Workshops are meant to be offered in 3 hour sessions (with a few exceptions) generally in partnership with the FFM team. This content often doesn't get very technical as workshops are open to the public resulting in many different skill sets, so we want to make sure everyone can still learn something from the events. If you are not currently partnered with the FMM team, you most likely are looking for a Lab instead.

The content in this section is typically updated at least 1 month after each release, with smaller updates provided before and after a workshop is ran.

Our current list of "out of the box" available workshops are listed [here](https://gitlab.com/gitlab-learn-labs/sample-projects/tanuki-racing/-/tree/main/Courses?ref_type=heads) with their slide counterparts stored [here](https://drive.google.com/drive/folders/1L_kd6QudSWcvAKDM-h6oPvvC6LiNj_ER)

**Please note** the Demo Architecture team supports custom workshops as well. If you have a unique ask please reach out in our [slack channel](https://gitlab.enterprise.slack.com/archives/C05E9EG6M5W) or message a team member directly. Different workshop examples can be seen [here](https://gitlab.com/gitlab-learn-labs/sample-projects)

#### Workshops Feedback/Survey Process

The goal is to set up a repeatable process for gathering feedback from workshop attendees while the experience is still fresh in their minds. We'll include a survey slide with a QR code, and the link will be shared in the chat just before the webinar wraps up. It will take less than 2 minutes to complete.

This is our first iteration, with plans to eventually automate the process. Over time, this feedback will help us identify areas for improvement, develop new materials, and refine how we deliver our workshops — ensuring we consistently provide valuable experiences for our attendees.

Follow the **How to steps** below to copy and generate your unique feedback QR code.

- [How to Steps](https://gitlab.com/gitlab-com/customer-success/demo-engineering/workshop-resources/-/blob/main/Workshop%20Survey/Survey-steps.md?ref_type=heads)

- [Survey Templates](https://drive.google.com/drive/folders/1s_d5Klh9qzBO2uF8wYvJKh-6LzjT3aDy)

### Labs/hands-on Content

The goal of labs is to provide SA/CSM/CSEs with the ability to put on hands-on demos for a customer to land a sale without them having to go through all of the work to set it up.  These have had tremendous success being the key to landing a first order or getting a customer to see the value in Ultimate. They are often a great replacement for a trial as well because we can do a hands-on exercise into a short trial to ensure they actually test out the functionality we want them to.  Because of this the content often needs to be customised so there is no set template like the workshops or cs demos. Instead we often use those as a starting point for the final result we are trying to show. To request a lab you first need to fill out the customer workshop request form via [Demo Architect Portal](https://cloud.gitlabdap.com/) then one of the Demo Architects will get connected with you to go over content and start the process. Below are some examples of past labs we have ran:

- Interactive Security Lab: The goal of this lab was to give the attendees a real life experience using GitLab to solve security problems. It was a small in person event, so we created an insecure project with many issues that were then assigned to various attendees. There was a short intro to GitLab + Security, followed by 2 hours of hands-on group work where the students collaborated to secure the project with their assigned issues. This was then followed by a retro and wrap up which really drove the value home.

- Customer Lab Series: There was a customer that was partially using GitLab premium but still primarily a BitBucket account. A team of SAs + CSMs came together and gave a series of 20+ labs that walked through how to migrate off of BitBucket and onto GitLab followed by an in depth look at GitLab's Ultimate security features. This led to a huge up sell in both licenses and Ultimate.

- 0 to Hero Labs: This series of Labs has been running in the public sector where an SA will schedule an onsite visit and plan a day of labs. Morning is a PM and GitLab basics session to get everyone familiar with the product, followed by an afternoon session that is either hands-on/off and highlights all the best practices with GitLab Security. This has been a fantastic pipe generator specifically when you get people in the room that have never heard of GitLab mixed with existing customers. Because the sessions are so long there is plenty of time for discussion allowing people to discuss the true value of the product in their field.

## Data Seeder

Historically prepping for many different types of demos have been difficult espcially if they require pre-configurations such as plan data to work. The [Data Seeder](https://data-seeder-6ea8f7.gitlab.io/) project has solved for this allowing up to seed any type of data into GitLab itself. You can either take advantage of pre-configured content like Tanuki Racing Studios that allows for type/content changing to fit any vertical, or write your own seed files to create a repeatable demo. To use this project fill out the seeder request form [here](https://cloud.gitlabdap.com/)

## AWS Working Groups

If you ever need a shared cluster for a hands on demo or want a deployment target without setting up the cluster yourself we offer a Learn Labs group pre-configured with an attached AWS cluster. This cluster is created through a terraform script you can also demo and has auto-cleanup built in. To request please fill out a customer workshop request [here]([here](https://cloud.gitlabdap.com/)) and mention this ask in the notes.

## Shared CS Demos

These demos are meant for anyone in the CS org to use when they get asked a question like "Hey can you show us how child pipelines work?" and instead of going out and re-inventing the wheel you have a catalogue of ready to go applications that cover the topic. The idea is that anyone can contribute, and it is up to the contributor to keep the content up to date and provide a decent script or recording to help you present the topic. Watch the CS & SA slack channels at the start of the month as well when we will announce the project of the month. Learn how to request access to this group [here](https://gitlab.com/gitlab-com/customer-success/demo-engineering/demo-systems-initial-set-up/-/blob/main/README.md?ref_type=heads#demo-systems-initial-set-up)

### Shared CS Infrastructure

[Shared CS Infrastructure](https://gitlab.com/gitlab-learn-labs/webinars/demo-engineering-shared-infra)

CS team members are constantly spending time re-inventing the wheel and spinning up infrastructure that their teammates have already done. The goal with this shared infrastructure is to eliminate that time waste allowing CS team members to focus on the integrations themselves instead of just how to get it to work. To get access you just have to fill out an access form for each project. Also feel free to fill out an enhancement form if you notice that the application is missing something you were hoping to show off (like a grafana plugin). Don't see a project you were hoping to use? Just create an issue on the [Dev Issue Board](https://gitlab.com/gitlab-learn-labs/webinars/dev-issue-board/-/issues) and one of the SAs will pick up the task. Please note that there are two different types of infra, the first being applications that are easy to spin up without a high cost. Others like Snyk, Auth0 etc we will instead provide readmes on how to use their free cloud tiers or work around to give the demo but there are no plans to spin these up ourselves.

- Grafana
- Hashicorp Vault
- JFrog Artifactory
- Jenkins
- Remote Development Host
- Terraform GCP GKE
- Azure
- Jira

### Live Talk/Keynote Resources

[Live Talk/Keynote Resources](https://gitlab.com/gitlab-learn-labs/webinars/live-presentation-talk-tracks)

This group is full of slide decks and talk track you can take advantage of to give keynotes or public talks at various conferences. Often times these come with recordings as well so you can see what has worked for other employees in the past. These are not meant to be demo recordings, but rather talks around concepts and values of the GitLab product.
