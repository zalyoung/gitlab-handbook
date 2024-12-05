---
title: "GitLab Security Essentials - Hands-On Lab: Dependency and IaC Scanning"
description: "This Hands-On Guide walks you through the process of using dependency scans and IaC scans on your code"
---

### Task A. Add dependencies and IaC

Our initial project has been built and we want to start on the deployment process. There are two areas we want to configure for our project. The first area is dependencies for our application. The second area is infrastructure for our application deployment. Let's set these up in our project. To add dependencies to your Python project, complete the following steps.

1. Navigate to your project.

1. Open the `requirements.txt` file and observe the dependencies in it.

    ```
    requests==2.27.1
    ```

For infrastructure as code, you want to start by deploying an S3 bucket to your environment. To do this, you can set up some terraform files with infrastructure definitions. To do this:

1. Navigate to your project.

1. Select **+ > New file**.

1. In the **Filename**, enter `s3.tf`.

1. Add the following contents to the file:

```yml
resource "aws_s3_bucket_public_access_block" "publicaccess" {
    bucket = aws_s3_bucket_demobucket.id
    block_public_acls = false
    block_public_policy = false
}
```

1. Select **Commit changes**.

This project will also use Docker for deployments. To enable this, we will create a Dockerfile.

1. Navigate to your project.

1. Select **+ > New file**.

1. In the **Filename**, enter `Dockerfile`.

1. Add the following contents to the file:

```yml
FROM python:3.4-alpine
ADD main.py .
```

1. Select **Commit changes**.

### Task B. Add dependency scanning

Now that you have dependencies added to your project, you want to ensure that the dependencies do not contain any security vulnerabilities. To validate this, you can add security scanning to your project.

1. Open your `.gitlab-ci.yml` file.

1. Add the following line to your `include` block:

```yml
  - component: https://ilt.gitlabtraining.cloud/components/dependency-scanning/main@0.5.0
```

1. Select **Commit changes**.

To view the progress of your new pipeline:

1. In the left sidebar, select **Build > Pipelines.**

1. Select your most recent pipeline

1. You should now see a job titled `dependency-scanning`. 

Once this job completes, you will be able to view the results of the security scan:

1. In the left sidebar, select **Secure > Vulnerability report**. 

1. In the **Vulnerability report**, filter for the `gemnasium-python` tool. 

1. Click on each vulnerability to review the findings.

In the results, you will see various vulnerabilities in our version of the requests library. Let's fix these issues in our `requirements.txt` file.

1. When you select a vulnerability in the report, you will see a target version number to fix each issue. The first vulnerability recommends an upgrade to version 2.32.0 or above, the second vulnerability recommends an upgrade to version 2.31.0 or above.

1. From this, we can determine that 2.32.0 will fix all our vulnerabilities. To set this version, edit your existing `requirements.txt` file. Update the `requests` import to:

    ```
    requests==2.32.0
    ```

1. Commit these changes and verify that the vulnerability is no longer detected. 

### Task C. Add IaC scanning

To add infrastructure as code scanning to your project:

1. Open your `.gitlab-ci.yml` file. 

1. In the include section, add the following template:

```yml
include:
  - template: Jobs/SAST-IaC.gitlab-ci.yml
```

1. Select **Commit changes**.

1. Observe the resulting pipeline and wait for it to complete.

1. Navigate to **Secure > Vulnerability Reports**.

1. Review the results of your IaC scan.

## Lab Guide Complete

You have completed this lab exercise. You can view the other [lab guides for this course](/handbook/customer-success/professional-services-engineering/education-services/secessentialshandson).

## Suggestions?

If you'd like to suggest changes to the *GitLab Security Essentials Hands-On Guide*, please submit them via merge request.
