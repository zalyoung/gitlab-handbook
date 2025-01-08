
# Developer Vulnerability Management Setup Guide

## Requirements

### Set up GDK

To fully run Vulnerability Management on your local machine, you must have set up the [GDK](https://gitlab.com/gitlab-org/gitlab-development-kit/-/blob/main/doc/index.md). 

### Setup Runner

To display the Vulnerability Reports, you need to set up the runner. Follow these steps:

1. Navigate to `http://gdk.test:3000/gitlab-org/security-reports` 
2. On the left sidebar, click on the `Search or go to...` button and select `Admin Area`.
3. In the Admin Area, on the left sidebar, select `CI/CD` > `Runners`.
4. Select `New instance runner` > `Run untagged jobs` > `Create Runner`
5. Choose your Operating system and follow the instructions of `Step 1`
6. Ensure that Docker is running on your machine.
7. Open your terminal, run `gdk start`. Once `gdk` is running, run the command `gitlab-runner run`
8. Return to your browser, and click on `View runners`. Your runner should be shown in the list of runners, and show as `Online`.
9. Navigate back to the `Security Reports` project at `http://gdk.test:3000/gitlab-org/security-reports` 
10. On the left sidebar click on `Build` > `Pipelines`. The pipeline should now be active. 

For additional details or troubleshooting, consult the offical [runner setup guide](https://gitlab.com/gitlab-org/gitlab-development-kit/blob/main/doc/howto/runner.md#set-up-a-runner).

### Ensure EE License

To display Vulnerability Reports and the Vulnerability Management tool in GitLab, you need an Enterprise Edition [(EE) license](https://gitlab.com/gitlab-org/gitlab-development-kit/blob/main/doc/index.md#use-gitlab-enterprise-features). This license enables features exclusive to the EE tier. To generate an EE development license, follow these steps: 

1. Request an EE developer license. Follow the steps in [the handbook](https://handbook.gitlab.com/handbook/engineering/developer-onboarding/#working-on-gitlab-ee-developer-licenses).
2. Once you've succesfully obtained the license, add it to your local environment. Follow the steps in [the handbook](https://docs.gitlab.com/ee/administration/license_file.html#add-license-in-the-admin-area) under **Add license in the Admin area**.

## Resources and Examples

### Repositories

To easily populate vulnerabilities, we recommend the [**Security Reports** project](https://gitlab.com/gitlab-examples/security/security-reports.git) . You can add it to your local environment by following these steps:

1. Go to `http://gdk.test:3000/` in your browser
2. Click on `New Project` > `Import Project` > `Repository by URL`
3. In the `Git repository URL` field, enter `https://gitlab.com/gitlab-examples/security/security-reports.git`
4. Under `Project Url`, add a namespace, (e.g. `gitlab-org`).
5. For `Project slug` enter `security-reports`
6. Click  `Create project`
