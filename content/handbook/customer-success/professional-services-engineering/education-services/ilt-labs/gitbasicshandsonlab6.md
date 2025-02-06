---
title: "GitLab with Git Fundamentals - Hands-On Lab: Implementing Security Scanners"
description: "This Hands-On Guide walks you through the process of adding security scanners to your CI/CD process."
---

> Estimated time to complete: 30 minutes

## Objectives

This lab uses SAST, an optional feature in CI/CD pipelines, to identify security vulnerabilities in your code. GitLab's Vulnerability Report then shows any old or new vulnerabilities found with each pipeline run. You can learn more in the [documentation](https://docs.gitlab.com/ee/user/application_security/sast/).

## Task A. Finding the SAST Component

GitLab provides a variety of CI/CD components, which are prebuilt CI/CD configurations you can include in your projects. To view all of the available components on your GitLab instance:

1. In the left sidebar, select **Search or go to**.

1. In the resulting dialog, select **Explore**.

1. In the left sidebar, select **CI/CD Catalog**. This will show you a list of all of the CI/CD catalog items available in your GitLab instance. For this lab, you will be adding SAST to your project. Select the SAST component.

When you select a CI/CD component, you will see a `Readme`, which describes how to use the component, as well as configuration options for the component. For the SAST component, you will see that it can be included using the following code:

```yaml
include:
  - component: ilt.gitlabtraining.cloud/components/sast/sast@<VERSION>
```

Let’s add this to our CI/CD file.

## Task B. Adding the SAST component

1. Navigate to your CI/CD project by clicking on the Tanuki logo in the top left corner of the page, then click on your `Cool App QA` project.

1. In the left sidebar, select **Code > Branches**.

1. Select the `initial-code` branch.

1. Select your `.gitlab-ci.yml` file.

1. Select **Edit > Edit in Pipeline Editor**.

1. At the top of your file, below the image, add the SAST import at version main.

```yaml
include:
  - component: ilt.gitlabtraining.cloud/components/sast/sast@main
```

1. In the stages section of the file, add a stage named `test`, as shown below:

    ```yaml
    stages:
      - build
      - test
    ```

    After making these changes, your file will look like this:

      ```yaml
      include:
        - component: ilt.gitlabtraining.cloud/components/sast/sast@main

      default:
        image: golang

      stages:
        - build
        - test

      build go:
        stage: build
        script:
          - go build
      ```

1. Ensure that your **Branch** is set to `initial-code`. Select **Commit changes**.

1. After committing your changes, in the left sidebar, navigate to the **Build > Pipelines**. 

1. Select the most recent pipeline.

1. You will now see a new job named *semgrep-sast*. This job is the security scan imported using the `include` keyword.

## Lab Guide Complete

You have completed this lab exercise. You can view the other [lab guides for this course](/handbook/customer-success/professional-services-engineering/education-services/ilt-labs/gitbasicshandson).

## Suggestions?

If you'd like to suggest changes to the lab, please submit them via merge request.
