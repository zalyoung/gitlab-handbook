---
title: Setup Guide for Vulnerability Explanation and Resolution
---

## Setup Guide for Vulnerability Explanation and Resolution

Several setup steps are necessary in order to test and develop Vulnerability Explanation (VE) and Vulnerability Resolution (VR) features locally. This guide contains instructions for setting up and configuring the necessary components.

### Setup Runner

To generate vulnerability reports you will need to run a CI pipeline. Follow the instructions below to install and configure the GitLab Runner.

[https://gitlab.com/gitlab-org/gitlab-development-kit/blob/main/doc/howto/runner.md](https://gitlab.com/gitlab-org/gitlab-development-kit/blob/main/doc/howto/runner.md)

Optionally, you can install Docker with Colima. The docs can be found [here](https://gitlab.com/gitlab-org/gitlab-development-kit/-/blob/main/doc/howto/runner.md) or you can follow the steps in [this snippet](https://gitlab.com/-/snippets/2259133).

### Setup Vulnerability Report

The VE and VR features are designed to work on SAST vulnerabilities. Clone one or more of the following projects to use for local testing:

* [https://staging.gitlab.com/govern-team-test/oxeye-rulez](https://staging.gitlab.com/govern-team-test/oxeye-rulez)
* [https://gitlab.com/gitlab-org/security-products/tests/webgoat.net](https://gitlab.com/gitlab-org/security-products/tests/webgoat.net)
* [https://gitlab.com/gitlab-examples/security/security-reports](https://gitlab.com/gitlab-examples/security/security-reports)
* [https://gitlab.com/gitlab-org/govern/threat-insights-demos/verification-projects/cwe-samples](https://gitlab.com/gitlab-org/govern/threat-insights-demos/verification-projects/cwe-samples)

Run the pipeline on the main or master branch for any of the sample projects to generate the vulnerability report. `Build` > `Pipelines` > `Run Pipeline`

Once the pipeline is finished, the Vulnerability Report can be viewed by going to `Secure` > `Vulnerability Report` > Any SAST finding

Examples:

* Vulnerability Report: [https://gitlab.com/gitlab-org/security-products/tests/webgoat.net/-/security/vulnerability_report](https://gitlab.com/gitlab-org/security-products/tests/webgoat.net/-/security/vulnerability_report)
* SAST finding: [https://gitlab.com/gitlab-org/security-products/tests/webgoat.net/-/security/vulnerabilities/105323245](https://gitlab.com/gitlab-org/security-products/tests/webgoat.net/-/security/vulnerabilities/105323245)

### Setup AI

Follow this [instructions here](https://docs.gitlab.com/ee/development/ai_features/) to configure your GDK access to AI features.

For GitLab Team members only:

* An EE license is required, follow the steps [here](https://docs.gitlab.com/ee/development/ai_features/#required-setup-licenses-in-gitlab-rails) to request one.
* Anthropic access is required. Create an access request if necessary ([example](https://gitlab.com/gitlab-com/team-member-epics/access-requests/-/issues/29415)).

#### Duo Access

Once you have AI set up locally, you will need to enable Duo features. Follow the steps below to ensure you have everything correctly configured.

Follow this [instructions here](https://docs.gitlab.com/ee/development/ai_features/#set-up-and-run-gdk) to setup and run GDK.

### Usage

With the configuration in place, you should expect to see the `Explain with AI` button for any SAST vulnerability. For example: [https://gitlab.com/gitlab-org/security-products/tests/webgoat.net/-/security/vulnerabilities/105323245](https://gitlab.com/gitlab-org/security-products/tests/webgoat.net/-/security/vulnerabilities/105323245)

You should expect to see the 'Resolve with AI` button for any SAST vulnerability in the [high confidence CWE list](https://gitlab.com/gitlab-org/gitlab/-/blob/master/ee/app/models/vulnerabilities/finding.rb#L25-69). For example: [https://gitlab.com/gitlab-org/security-products/tests/webgoat.net/-/security/vulnerabilities/114941072](https://gitlab.com/gitlab-org/security-products/tests/webgoat.net/-/security/vulnerabilities/114941072)

If you need assistance, please reach out in [#g_govern_threat_insights_eng_ai](https://gitlab.enterprise.slack.com/archives/C07KSUHD09E)

## Setup Guide for your Local Environment 
Before setting up a runner, you must have set up the [GDK](https://gitlab.com/gitlab-org/gitlab-development-kit/-/blob/main/doc/index.md) for your machine. You should also add the `Security Reports` project to your local environment by following these steps:

### Add Security Reports project
1. Go to `http://gdk.test:3000/` in your browser
2. Click on `New Project` > `Import Project` > `Repository by URL`
3. In the `Git repository URL` field, enter `https://gitlab.com/gitlab-examples/security/security-reports.git`
4. Under `Project Url`, add a namespace, (e.g. `gitlab-org`).
5. For `Project slug` enter `security-reports`
6. Click  `Create project`

### Setup Runner

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

### Generate a EE License
To display Vulnerability Reports in GitLab, you need an Enterprise Edition (EE) license. This license enables features exclusive to the EE tier. To generate an EE development license, follow these steps: 
1. Request an EE developer license here (link)


WIP
1. Go to `http://gdk.test:3000/` and login as the `root` user
2. On the left sidebar, at the bottom, select `Admin`.
3. Select Settings > General.
4. In the `Add License` area, add a license by either uploading the file or entering the key.
Select the Terms of Service checkbox.
Select Add license.


