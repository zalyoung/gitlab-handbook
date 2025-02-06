---
title: "GitLab with Git Fundamentals - Hands-On Lab: Organizing your work in GitLab"
description: "This Hands-On Guide walks you through the basics of organizing and structuring your work in GitLab."
---

> Estimated time to complete: 30 minutes

## Objectives

In this lab, we will explore how we can organize work in GitLab, using groups, sub-groups, and projects.

## Task A. Viewing a group structure

To start, in the left sidebar, select **Groups**.

1. In the **Groups** section, select the dropdown arrow on the left of **Training Users**. 

1. Below **Training users**, you should now see a group with a name like **Session <string of characters and numbers**.

1. Click the dropdown arrow next to the **Session** group. You should now see a group named **My Test Group - <string of characters and numbers>**. Click this group to access it.

This navigation shows an example of groups and subgroups. In the ILT GitLab instance, the **Training Users** group is a top-level group. This means that it is not part of any other groups in the instance. The **Training Users** group contains a set of subgroups, which represent classes running in the instance. Each of these subgroups is given a name like **Session <string of characters and numbers>**. Inside of these groups is a set of subgroups, one group for each student in the class. The **My Test Group** subgroup is your own group, which you can organize and modify in any way you like.

## Task B. Creating a Group Structure

To start, make sure you are in the **My Test Group** subgroup. For this task, imagine you are working at a company with two departments: Development, and QA. These departments have the following projects:

- Development: A mobile and desktop version of an application named `Cool App`. Of note, `Cool App` contains many microservices spread over many repositories for both versions.
- QA: Two testing frameworks, one for the mobile version of `Cool App` and one for the desktop version. Both frameworks are monolithic, stored in a single project.

Take some time here to consider a structure for these two teams. After considering options, take a look at the steps below for a possible solution.

1. Since we have two teams, let's create a group for each team. Select **New subgroup**. 

1. In the **Subgroup name**, enter `Development`. Leave all other options as default and select **Create subgroup**.

1. At the top of the page, you will see a set of breadcrumbs which shows your location in the application. Click **My Test Group** to return to your main group.

1. From here, you will now see your `Development` group. Select **New subgroup** to create your group for QA.

1. In the **Subgroup name**, enter `QA`. Leave all other options as default and select **Create subgroup**.

1. Select **My Test Group** from the breadcrumbs again to return to your main group. You will now see two groups: `Development` and `QA`. 

Next, we can structure subgroups for both team's projects. Since the development applications have many projects, it makes sense to create a subgroup for each project type.

1. Select the `Development` group.

1. Select **New subgroup**.

1. In **Subgroup name**, enter the name `Cool App Desktop`. Select **Create subgroup**.

1. In the breadcrumbs, select **Development** to return to the development group.

1. Select **New subgroup**.

1. In **Subgroup name**, enter the name `Cool App Mobile`. Select **Create subgroup**.

1. In the breadcrumbs, select **Development** to return to the development group.

Now in the `Development` group, you will see a `Cool App Desktop` and `Cool App Mobile` subgroups, ready to contain any projects related to both applications.

For the QA team, they have a single project. There are two main options for structuring this team. We can create a group for `Cool App Testing` that will contain the project, or we can just create the project in the subgroup. For simplicity, we will opt to just create the project and repository in the `QA` group, which we will explore in the next lab.

## Lab Guide Complete

You have completed this lab exercise. You can view the other [lab guides for this course](/handbook/customer-success/professional-services-engineering/education-services/ilt-labs/gitbasicshandson).

## Suggestions?

If you'd like to suggest changes to the lab, please submit them via merge request.
