---
title: "Single Tenant AI Gateway for Dedicated"
status: proposed
creation-date: "2025-05-26"
authors: [ "@mhamda" ]
coach: ""
approvers: [ "@susie.bee", "@eduardobonet" ]
owning-stage: "~devops::ai-powered"
participating-stages: ["~group::dedicated"]
toc_hide: true
---

{{< engineering/design-document-header >}}

This documetns describes the architecture of co-located GitLab Dedicated and Dedicated AI Gateway

Epic: https://gitlab.com/groups/gitlab-org/-/epics/17542

## Motivation

Dedicated Customers interested in using Duo can only do so by connecting to the multi-tenant AI Gateway and models to use Duo functionality. This approach contradicts the fundamental single-tenant architecture promised by GitLab Dedicated deployments. By deploying an AI Gateway within the same single-tenant environment as the GitLab instance, we can maintain the isolation guarantees that Dedicated customers expect while still providing full Duo capabilities. This change also offers customers greater control over model selection for specific features, enhancing flexibility and customization options for their AI-powered workflows.

## User experience

### Configuring the single tenant AI Gateway

The customer provides credentials for model serving platforms in the form of enviroment variables, depending on the platform they plan on using. There are a few options for authentication:

#### Provider authentication

The AIGW pod can be automatically authenticated to use Cloude provider services depending on the cloud provider. For example, if the cluster is on AWS, the AIGW can be authorized against AWS Bedrock with an [Kubernetes service account](https://docs.aws.amazon.com/eks/latest/userguide/pod-configuration.html) within [their account](https://docs.aws.amazon.com/eks/latest/userguide/cross-account-access.html). The customer would need to 
create within their account a service account with a specific name (for example `gitlab-single-tentant-ai-gateway`). This is the preferred solution there's minimal configuration by customers on GitLab side, and gives them full control over permissions. [Google Cloud](https://cloud.google.com/kubernetes-engine/docs/how-to/service-accounts) provides a simillar options

#### API key authorization

If the customer intends to use a model that is not available within their. Note that this will require the instance network to be allowed to reach the deired API endpoint, which might require firewall configuration. The API key is set as paremeter when defining new models.

### Configuring models

Configuring models is done in the same way as documented in https://docs.gitlab.com/administration/gitlab_duo_self_hosted/configure_duo_features/#configure-the-self-hosted-model.

## Technical Implementation

The first iteration will allow Dedicated customers on AWS access to single-tenant AI Gateway. To achieve this:

1. Add deployment logic to 


## Features and options not supported

1. Deploying with Runway

GitLab hosted AIGW is deployed through Runway, but Runway is currently not available within dedicated

2. Authentication with Environment Variables

Some providers, such as Anthropic, require authorization to be defined as environment variables. This option is currently not supported.


