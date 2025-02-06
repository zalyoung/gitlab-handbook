---
title: "GitLab with Git Fundamentals - Hands-On Lab: Project Management with Issues and Boards"
description: "This Hands-On Guide walks you through the process of working with issues in GitLab."
---

> Estimated time to complete: 30 minutes

## Objectives

The goal of this lab is to get an overview of the different plan features available in GitLab, including issues and epics.

## Task A. Creating issues in a project

To start, let's learn the basics of creating issues in GitLab. 

1. Navigate to your **Cool App QA** project. 

1. In the left sidebar, select **Plan > Issues**. 

1. Select **New issue**.

1. In the title, enter `First issue`.

1. Enter any description you like.

1. In **Assignees**, select **Assign to me**.

1. Select **Create issue**.

By following this process, you created an issue related to your **Cool App QA** project. Let's discuss some of the details related to your issue. In the center, you will see your issue description, as well as activity for the issue and an area to add comments and discussions. Every issue can have child items, which are smaller tasks related to the issue. Issues can also be linked to other issues to show relationships between issues. 

In the right sidebar, you will see metadata related to your issue. The **Assignee** is the set of people currently working on the issue. If the issue is associated with an epic, milestone, or iteration, these details will display here. Labels can be added to an issue to help organize issues into similar categories or types. Weight defines the amount of work associated with an issue. A due date can be set on an issue for when it should be completed by. Time tracking lets you track time taken to complete an issue. Health status lets you set a status for how the issue is progressing.

Often, we use issues to represent smaller pieces of work that may be completed in a single iteration or sprint. For larger sets of work, we use the concept of an epic.

## Task B. Defining an epic

An epic is created at a group level and defines larger sets of work on a project. To create an epic:

1. Navigate to your **QA** group.

1. In the left sidebar, select **Plan > Epics**. 

1. Select **New epic**.

1. For the title, enter `My first epic`.

1. Enter any description you like and select **Create epic**.

1. Select `My first epic`. 

In this view, you will see details on your epic. Similar to issues, epics can contain child items and linked items, as well as activity related to the epic. In the right sidebar, there is metadata for the epic, including labs, health status, parent, and time tracking.

## Task C. Defining a milestones

A milestone represents a set of work being completed over a fixed time period. A milestone can contain both epics and issues. To create a milestone:

1. Navigate to your `QA` group.

1. In the left sidebar, select **Plan > Milestones**. 

1. Select **New milestone**.

1. In the title, enter `My first milestone`. 

1. Enter any **Start Date** and **Due Date** you would like.

1. Input any **Description**, then select **Create milestone**.

Next, we need to assign issues to the milestone.

1. In the left sidebar, select **Plan > Issues**.

1. Select `First issue`. 

1. In the right sidebar, select **Edit** next to **Milestone**.

1. Select `My first milestone` from the resulting dropdown.

1. Select `My first milestone` in the right sidebar to be redirected back to the milestone.

You will now see all issues related to the milestone, along with burndown and burnup charts for the milestone dates provided.

## Task D. Issue boards

To help with viewing issues and epics in a singular place, you can utilize issue and epic boards. To start:

1. Navigate to the `QA` group.

1. In the left sidebar, select **Plan > Issue boards**.

    > In this view, you will see all your issues associated with their statuses.

1. In the left sidebar, select **Plan > Epic boards**.

    > In this view, you will see all your epics associated with their statuses. 

It is possible to further customize issue boards to display different sets of information depending on your requirements. For more details on issue boards, check out the [documentation](https://docs.gitlab.com/ee/user/project/issue_board.html).

## Lab Guide Complete

You have completed this lab exercise. You can view the other [lab guides for this course](/handbook/customer-success/professional-services-engineering/education-services/gitbasicshandson).

## Suggestions?

If you'd like to suggest changes to the lab, please submit them via merge request.
