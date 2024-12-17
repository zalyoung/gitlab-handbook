---
title: GitLab Dedicated Hosted Runners
category: GitLab Dedicated
description: "GitLab Dedicated Support - Hosted Runners"
---
## Hosted runners

[Hosted runners for GitLab Dedicated](https://docs.gitlab.com/ee/administration/dedicated/hosted_runners.html) are a new product offered to our Dedicated Customers.
Currently in beta, but will be generally available Q2-2026

## Who is using Hosted runners

To identify if a customer is using Hosted runners, use the Switchboard app. More information can be found in the [Switchboard workflow](dedicated_switchboard.md).

On the **Overview** tab look for **Additional services > Available hosted runners**, only if customer has hosted runners configured this section will be visible.

## Viewing Logs

Runners logs are available through the tenant OpenSearch login. See  Working with logs [has been moved](dedicated_logs.md)

To view only runners logs use the filter: `fluentd_tag: -fleeting-logs`. The full value is `cloudwatch.<name>-fleeting-logs`.  Where <name> is the value of the name attribute in the [Runner Model](https://gitlab-com.gitlab.io/gl-infra/gitlab-dedicated/runner-model-schema/).

Only `gitlab-runner` and `systemd` are send to OpenSearch. For job logs reach out to the customer.

## Monitoring

Hosted Runners monitoring can be don through Grafahan, details on how to access it see [GitLab Dedicated Observability and Monitoring (Grafana)](dedicated_instance_health)

Once in Grafahan go to **Dashboards** and search the **Hosted Runner(s) Overview** dashboard. This dashboard has pots on different runner metrics.
The dashboard is available for all customer but only populated if Hosted Runners are being used by the customer.

## Architecture

GitLab Hosted Runners are created on `ec2` AWS instance.

## Useful References

[Dedicated team Hosted Runner Model](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/runner-model-schema/-/blob/main/docs/model-examples.md#searching-logs-in-opensearch)
[Dedicated team Hosted Runner technical document](https://gitlab-com.gitlab.io/gl-infra/gitlab-dedicated/team/engineering/projects/dedicated_hosted_runners/index.html)
