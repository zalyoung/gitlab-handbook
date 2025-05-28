---
title: "GitLab Fundamentals - Hands-On Lab: Collaboration and Code Review"
description: "This Hands-On Guide walks you through collaborating on changes and creating code reviews."
---

> Estimated time to complete: 30 minutes

## Objectives

In this lab, we will explore the process of creating and merging a merge request

## Task A. Creating a merge request

In the last lab, you created a new branch called **test-commit**. In this section, we will create a merge request to merge the changes from this branch into our main branch.

1. Navigate to your `Cool App QA` project.

1. In the left sidebar, select **Code > Branches**.

1. In the **test-commit** row, select **New**.

1. In the **Title** field, enter the title **Merging new file to main**.

1. Check the box **Mark as draft**. This will mark the Merge Request as a draft, and prevent it from being merged until the Draft status is removed.

1. In **Description**, enter any description you would like. 

1. In **Assignees**, select **Assign to me**.

1. Leave all other options as default and select **Create merge request**.

After selecting **Create merge request**, you will be redirected to the merge request page. Let's explore this page in more detail.

## Task B. Exploring the merge request

On the main merge request page, you will four tabs available:

* **Overview**, which shows an overview of the merge request, including approvals, merge request status, **Activity**, and a comment area to add comments to a merge request.

* **Commits**, which shows all of the commits that are part of the current merge request.

* **Pipelines**, which shows any CI/CD pipelines associated with a merge request.

* **Changes**, which shows a differential of the changes associated with the merge request.

Return to the **Overview** tab. In this tab, there are a few important details to note:

1. In the right sidebar, you will see details about your merge request. The merge request is currently assigned to you, meaning you are the one currently working on the merge request contents.

* The **Reviewers** section shows any reviewers that have been assigned to a merge request. Currently this is empty, since approval is optional. 

* **Labels** allows you to add organizational labels to a merge request to keep track of it in context of other related work.

* **Milestone** allows you to associate a milestone to a merge request

* **Time Tracking** lets you track time against a merge request.

* **Participants** shows everyone who has commented or committed for a merge request. 

In the center of the screen, you will see a message stating **Merge blocked**. In this section, you can see any issues preventing your code from being merged into main. Anything from failed pipelines to security scan results can block a merge request, depending on your configuration. Currently, the reason to request is blocked is stated below: "Merge request must not be a draft". Let's fix this issue.

1. Click **Mark as ready** in the **Merge blocked** block. If you do not see the **Mark as ready** option, click on the arrow to the right of the **Merge blocked** block to expand it.

1. Select **Merge**.

1. Once the merge completes, in the left sidebar, select **Code > Repository**. 

You will now see your new file in the **main** branch of your code repository.

## Lab Guide Complete

You have completed this lab exercise. You can view the other [lab guides for this course](/handbook/customer-success/professional-services-engineering/education-services/ilt-labs/gitlabfundamentalshandson).

## Suggestions?

If you'd like to suggest changes to the lab, please submit them via merge request.
