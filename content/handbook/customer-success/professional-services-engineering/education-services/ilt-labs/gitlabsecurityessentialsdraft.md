---
title: "GitLab Security Essentials - Hands-On Lab: SAST and Secret Detection"
description: "This Hands-On Guide walks you through the process of enabling and using SAST and secret detection in your projects"
---

# Objective

In this lab, you will implement SAST and Secret Detection in your GitLab project. By the end of this lab, you will be able to:

1. Add the SAST component to any CI/CD process.

1. Add the Secret Detection component to any CI/CD process.

1. Configure the SAST and Secret Detection component to match your project requirements.

## Task A. Setting up your project

To start, you will need a project to use for implementing your security scanners. For this purpose, we have created a template that contains some vulnerable code. To create a project based on the template, use the following steps:

1. Navigate to your ILT group.

1. Select **New project**.

1. Select **Create from template**.

1. Select the **Instance** tab.

1. Select **Use template** next to the **Security Essentials Labs** template.

1. For **Project name**, input `Security Labs`. 

1. Select **Create project**. 

## Task B. Setting up the SAST scanner

Your company has a Python project which contains some simple API code. As a member of the team, you want to ensure that the code commit to the project is as secure as possible. To start the process of securing your code, you want to add static code analysis to your project. To accomplish this task, complete the following tasks in your project:

1. Create a `.gitlab-ci.yml` file. 

1. Add a `test` stage to your CI/CD file.

1. Add the `ilt.gitlabtraining.cloud/components/sast/sast@main` component to your CI/CD file. 

1. Commit your changes to the main branch. 

After completing these tasks, you can verify that security scans are now running on your project:

1. In the left sidebar, select **Build > Pipelines**. 

1. Select the most recent pipeline by clicking the pipeline **Status**.

1. Select the **semgrep-sast** job.

1. Review the output of the job.

If the SAST job completes successfully, you should now be able to view a security report for your repository.

1. In the left sidebar, select **Secure > Vulnerability report**. 

Review the vulnerabilities you see in this section. 

## Task C. Getting more details with advanced SAST

Your team has found the current SAST scans helpful, but they would like to get more depth and detection. You've decided it would be ideal to experiment with the advanced SAST scanner in your project. To accomplish this, complete the following tasks:

1. Open your existing `.gitlab-ci.yml` file.

1. Add the `run_advanced_sast` input to your `ilt.gitlabtraining.cloud/components/sast/sast@main` component. Make sure it is set to `true`. 

1. Commit your changes to the `main` branch.

After completing these tasks, you can verify that security scans are now running on your project:

1. In the left sidebar, select **Build > Pipelines**. 

1. Select the most recent pipeline by clicking the pipeline **Status**.

1. Select the **gitlab-advanced-sast** job.

1. Review the output of the job.

If the SAST job completes successfully, you should now be able to view a security report for your repository.

1. In the left sidebar, select **Secure > Vulnerability report**. 

Review the vulnerabilities you see in this section. 

## Task D. Detecting secrets in your repository

Your team is currently using Flask with Python to deploy a web application. In Flask, you can provide various app configurations which contain potentially sensitive data. You've noticed that people are accidentally committing these secrets to the repository instead of using environment files. To help detect these cases, your team wants to enable secrete detection scanning. To accomplish this, complete the following tasks:

1. Open your existing `.gitlab-ci.yml` file.

1. Add the `ilt.gitlabtraining.cloud/components/secret-detection/secret-detection@main` component. 

1. Commit your changes to the main branch.

After completing these tasks, you can verify that security scans are now running on your project:

1. In the left sidebar, select **Build > Pipelines**. 

1. Select the most recent pipeline by clicking the pipeline **Status**.

1. Select the **secret_detection** job.

1. Review the output of the job.

If the SAST job completes successfully, you should now be able to view a security report for your repository.

1. In the left sidebar, select **Secure > Vulnerability report**. 

Review the vulnerabilities you see in this section. 

## Lab Solutions

### Task B.

Your `.gitlab-ci.yml` file will look similar to this after adding your SAST job:

```yml
stages:
    - test

include:
    - component: ilt.gitlabtraining.cloud/components/sast/sast@main
```

### Task C.

Your `.gitlab-ci.yml` file will look similar to this after adding your advanced SAST job:

```yml
stages:
    - test

include:
    - component: ilt.gitlabtraining.cloud/components/sast/sast@main
      inputs:
        run_advanced_sast: true
```

### Task D.

Your `.gitlab-ci.yml` file will look similar to this after adding your secret detection job:

```yml
stages:
    - test

include:
    - component: ilt.gitlabtraining.cloud/components/sast/sast@main
      inputs:
        run_advanced_sast: true
    - component: ilt.gitlabtraining.cloud/components/secret-detection/secret-detection@main

```
