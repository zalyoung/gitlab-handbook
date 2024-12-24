---
title: GitLab Dedicated Hosted Runners
category: GitLab Dedicated
description: "GitLab Dedicated Support - Hosted Runners"
---
## Hosted runners

[Hosted Runners for GitLab Dedicated](https://docs.gitlab.com/ee/administration/dedicated/hosted_runners.html) is a new product offered to our Dedicated Customers.
Currently in beta, but will be generally available Q2-2026

## Who is using Hosted runners

To identify if a customer is using Hosted Runners, use the Switchboard app. More information can be found in the [Switchboard workflow](dedicated_switchboard.md).

On the **Overview** tab look for **Additional services > Available hosted runners**. This section will be visible only if customer has hosted runners configured.

## Viewing Logs

Runners logs are available through the tenant OpenSearch login. See [GitLab Dedicated Logs](dedicated_logs.md) to learn more.

To view only runner logs use the filter: `fluentd_tag: -fleeting-logs`. The full value is `cloudwatch.<name>-fleeting-logs`, where `<name>` is the value of the name attribute in the [Runner Model](https://gitlab-com.gitlab.io/gl-infra/gitlab-dedicated/runner-model-schema/).

Only `gitlab-runner` and `systemd` are send to OpenSearch. For job logs reach out to the customer.

## Monitoring

Hosted Runners monitoring can be done through Grafana. Details on how to access Grafana can be seen in [GitLab Dedicated Observability and Monitoring (Grafana)](dedicated_instance_health).

Once in Grafana go to **Dashboards** and search the **Hosted Runner(s) Overview** dashboard. This dashboard has pots on different runner metrics.
The dashboard is available for all customers but isonly populated if Hosted Runners are being used by the customer.

## Architecture

GitLab Hosted Runners are created on `ec2` AWS instances.

## Useful References

[Dedicated team Hosted Runner Model](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/runner-model-schema/-/blob/main/docs/model-examples.md#searching-logs-in-opensearch)
[Dedicated team Hosted Runner technical document](https://gitlab-com.gitlab.io/gl-infra/gitlab-dedicated/team/engineering/projects/dedicated_hosted_runners/index.html)
