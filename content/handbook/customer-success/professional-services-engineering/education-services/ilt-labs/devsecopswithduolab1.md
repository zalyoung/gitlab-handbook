---
title: "GitLab Duo Principles - Hands-On Lab: Getting Started with GitLab Duo"
description: "This Hands-On Guide walks you through using GitLab Duo to answer technical questions."
---

> Estimated time to complete: 10 minutes

## Objectives

GitLab Duo allows you to use AI-assisted features across GitLab. To get started with GitLab Duo, you will need to first generate a lab environment to work in. This lab environment will provide you with all the GitLab Duo features demonstrated in this course.

## Task A. Access your Training Group

1. Navigate to https://cloud.gitlabdap.com/oauth_login in a web browser.

1. You will need a GitLab.com account in order to proceed. If you do not have a GitLab.com account, please follow the instructions on how to create one [here](https://gitlab.com/users/sign_up). If you have a GitLab account, or have just created one, please make sure it is logged in to GitLab.com, and click on the **Sign in with GitLab** button.

1. In the **Workshop Redemption Code:** field, enter the invitation code provided by your instructor.

1. Select **Submit Code**.

1. Now that you have redeemed a group, feel free to either wait 30 seconds and you will be redirected to your set up group, or jump in right away by clicking **Open GitLab Workspace**.

1. Once you are in the group, in the top right corner, click **New project**.

1. Select the **Create blank project** tile.

1. In the **Project name** field, enter `Duo Principles Project`.

   > The project slug will automatically populate. You can change this to a shorter string if desired for your own project. Leave it at the default for this lab.

1. In the **Project URL** field, click the dropdown for the second half of the URL to make sure it's pointing to a **group name** and not a **username**. You should create this project inside a group, not directly in your user's namespace.

1. Under **Visibility Level**, ensure **Private** is selected.

   > Since the parent group above your group is private, all child groups and projects below will be private. You can learn more about project visibility levels in the [documentation](https://docs.gitlab.com/ee/user/public_access.html).

1. Check **Initialize repository with a README**.

1. Select **Create project**.

## Task B. Working with GitLab Duo Chat

1. From your project, click the **GitLab Duo Chat** button in the top right corner.

1. A new chat window will appear on the right side of the screen. Try asking some questions and see how the GitLab Duo responds!

Here are a few demo questions you can ask Duo:

- `How do I move an issue from one project to another?`
- `What is a merged results pipeline?`
- `What is an example of a simple Python function?`

## Lab Guide Complete

You have completed this lab exercise. You can view the other [lab guides for this course](/handbook/customer-success/professional-services-engineering/education-services/devsecopswithduo).

## Suggestions?

If you'd like to suggest changes to the lab, please submit them via merge request.
