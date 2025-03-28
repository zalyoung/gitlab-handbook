---
title: "GitLab CI/CD - Hands-On Lab: Working with CI/CD Components"
description: "This Hands-On Guide demonstrates how to add CI/CD components to a pipeline"
---

> Estimated time to complete: 15 minutes

## Objectives

A component is a reusable CI/CD configuration. Many of GitLab’s provided CI/CD features are provided as components. In this lab, you will learn how to create and add a CI/CD component to your GitLab project.

## Task A. Creating a Component

Let's create a component to use in our GitLab project.

1. Navigate to your **My Test Group** by clicking it in the breadcrumb at the top of the page.

1. From your **My Test Group** in GitLab, click the **New project** button.

1. Click the **Create blank project** tile.

1. Name your project `Example Component`.

1. Leave all other values as their default, and click the **Create project** button and wait for GitLab to redirect you to the new project's main page.

Now, we need to set up the infrastructure for the component.

1. In the repository of your Example Component project, click the **+** button, then click the **New Directory** option.

1. For the directory name, type in **templates**. Make sure that it is in lower case.

1. Click the **Commit changes** button, and cmomit it to the main branch.

1. Click on the **templates** folder. Inside the folder, click on the **+** button, then click the **New file** button.

1. Type in **sample-template.yml** as the file name.

1. In the body of the file, copy the following text to create your sample component:

```yaml
spec:
  inputs:
    stage:
      default: test
---
component-job:
  script: echo job 1
  stage: $[[ inputs.stage ]]
```

Here, we are creating a component with an input called *stage*. The stage input has a default value of 'test', which we will override in our other project.

1. Click **Commit changes**, and then click **Commit changes** in the pop-up screen.

Now, we have a component that we can use in our project. You can also publish this component to the CI/CD catalogue with a Release for others to use, but we are instead just going to call it directly from our other project.

## Task B. Adding the SAST component

1. Navigate to your CI/CD project by clicking on the Tanuki logo in the top left corner of the page, then click on your project name.

1. From the project, select your `.gitlab-ci.yml` file.

1. Select **Edit > Edit in Pipeline Editor**.

1. At the top of your file, below the image, add in the custom component we created earlier:

```yaml
include:
  - component: ilt.gitlabtraining.cloud/my-test-group/example-component/templates/sample-template.yml@main
```

The top of the `.gitlab-ci.yml` file should look like this:

```yaml
workflow:
  rules:
    - if: $CI_COMMIT_TAG
      when: never 
    - when: always

default:
  image: golang

include:
  - component: ilt.gitlabtraining.cloud/my-test-group/example-component/templates/sample-template.yml@main
```

1. Select **Commit changes**.

1. After committing your changes, navigate to the pipeline created for your commit. You will now see a new job named *component-job*. This job is the custom job we have imported using the `include` keyword.

1. Let's try overriding the stage to instead run in the deploy stage by adding the following to the `.gitlab-ci.yml` file:

```yaml
  inputs:
    stage: deploy
```

1. Select **Commit changes**, and watch as your *component-job* now runs in the deploy stage.

## Lab Guide Complete

You have completed this lab exercise. You can view the other [lab guides for this course](/handbook/customer-success/professional-services-engineering/education-services/ilt-labs/gitlabcicdhandson).

## Suggestions?

If you wish to make a change to the *Hands-On Guide for GitLab CI/CD*, please submit your changes via Merge Request.
