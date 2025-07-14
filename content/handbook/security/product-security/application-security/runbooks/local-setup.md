---
title: "AppSec Engineer's Local Setup"
---

When evaluating security issues or MRs, it can be useful to have a way to reproduce issues, dig in to root causes, look for further impacts. This can also be a great way to get familiar with GitLab during your first few weeks of onboarding. Here are some handy tips & tricks.

## Get a version of GitLab to play with

Many AppSec engineers will opt to install GitLab locally using GDK. [Here's how to install GDK](https://gitlab.com/gitlab-org/gitlab-development-kit/-/blob/main/doc/index.md#one-line-installation) and [how to use it](https://gitlab.com/gitlab-org/gitlab-development-kit/-/blob/main/doc/howto/index.md). The UX team have a great summary of [other ways to play with & test GitLab](/handbook/product/ux/how-we-work/#preview-test-and-contribute).

### Step through execution chains

If you want to see the code executed as part of a web or API request, an interactive debugger may be a useful tool. Here's how to [configure Pry & Thin](https://gitlab.com/gitlab-org/gitlab-development-kit/-/blob/main/doc/howto/pry.md#using-thin)

A typical workflow might be to find the `Controller` action which kicks off the request (methods like `create` or `update` are good bets), add in `binding.pry`, save the file, then perform that request in a browser. The execution will stop and in a terminal you can inspect the current state using IRB, type `step` to go in_to_ a method, `next` to go to the next statement, and `continue` to let the request run to the next break point and/or completion.

Watching logs can be helpful: `tail -f gitlab/log/development.log`.

## Local setup for Duo (LSP and AI Gateway with VS Code)

### GDK, AI Gateway and Duo Workflow setup
1. Ensure you have a working [GDK](https://gitlab.com/gitlab-org/gitlab-development-kit) instance.
1. Ensure you have [gcloud CLI](https://cloud.google.com/sdk/docs/install) installed.
1. Get a [Self-Managed Ultimate license](https://handbook.gitlab.com/handbook/support/internal-support/#gitlab-plan-or-license-for-team-members) and register the license in your GDK.
1. Ensure you have Anthropic API access. You can verify this in Okta by searching for a tile titled "Anthropic Console - Corporate". If you do not have Anthropic API access, open an AR issue. Example [here](https://gitlab.com/gitlab-com/team-member-epics/access-requests/-/issues/36898).
1. Ensure you have a Fireworks API key. You can find this in the Security 1Password vault. Search for "Fireworks development key".
1. Ensure you have access to GCP. Go to the Google Cloud console. Toward the left of the top navigation bar, select the project picker and then select ALL. You should see `ai-enablement-dev-69497ba7` in the list. If you do not have access, complete the [GCP access request](https://gitlab.com/gitlab-com/gl-security/corp/infra/issue-tracker/-/issues/new?issuable_template=gcp_group_account_iam_update_request) template.
1. Follow the [AI Gateway setup instructions](https://gitlab.com/gitlab-org/gitlab-development-kit/-/blob/main/doc/howto/gitlab_ai_gateway.md#set-up-the-ai-gateway).
1. Confirm that the service is running with `gdk status gitlab-ai-gateway` / `gdk tail gitlab-ai-gateway`.
1. Set up [Duo Workflow](https://gitlab.com/gitlab-org/gitlab-development-kit/-/blob/main/doc/howto/duo_workflow.md?ref_type=heads#set-up-duo-workflow).

### VS Code and LSP
1. Install [VS Code](https://code.visualstudio.com/).
1. Familiarize yourself with [GitLab Workflow](https://marketplace.visualstudio.com/items?itemName=GitLab.gitlab-workflow), the official VS Code extension for GitLab.
1. Setup up your [VS Code extension development environment](https://gitlab.com/gitlab-org/gitlab-vscode-extension/-/blob/main/CONTRIBUTING.md?ref_type=heads#configuring-development-environment). This is where the code for GitLab Workflow lives.
1. Clone the [gitlab-lsp project](https://gitlab.com/gitlab-org/editor-extensions/gitlab-lsp) in the same path as your VS Code extension project.
1. Follow the docs to [link the VS Code extension to the Language Server](https://gitlab.com/gitlab-org/gitlab-vscode-extension/-/blob/main/docs/developer/language-server.md?ref_type=heads).


## Install a testing proxy

Your role might not require you to do "penetration testing", but having access to a testing proxy that lets you intercept and manipulate requests can help with reproducing HackerOne issues.

The AppSec team have a multi-user license for [Burp Suite Professional](https://portswigger.net/burp/pro). Ask in #sec-appsec about getting a license, and ([download the latest stable version here](https://portswigger.net/burp/releases)). You can also use [OWASP ZAP](https://www.zaproxy.org/) which is free and open source.

These tools can easily cause damage to websites or eat up your CPU with active scans. In OWASP Zap, use "Safe" mode to prevent any potentially malicious requests. In Burp Suite, disable any live "audit" scans.

## Browser Profiles

When testing requires using multiple users, an Incognito / Private tab is an easy option. You can also create and use [un-signed-in Chrome Profiles](https://support.google.com/chrome/answer/2364824) or [Firefox Multi-Account Containers](https://support.mozilla.org/en-US/kb/containers) to provide "session sandboxes", which will persist beyond window closure (unlike Incognito tabs) and you can colour code them to help with visual distinction.

## Mocking Servers / tunnels

Making your local machine accessible from the internet is [not permitted](/handbook/security/corporate/systems/#other-servicesdevices), which precludes tools like `ngrok` or `localtunnel`. Use GitLab's [Sandbox Cloud](/handbook/company/infrastructure-standards/realms/sandbox) to host mock servers instead. Refer to [Secure Cloud testing environments](/handbook/support/workflows/test_env/#securing-cloud-testing-environments) for advice on how to secure your Sandbox Cloud test environments.
