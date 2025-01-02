---
title: Hosted runners for GitLab Dedicated
category: GitLab Dedicated
description: "GitLab Dedicated Support - Hosted Runners"
---
## Hosted runners

[Hosted Runners for GitLab Dedicated](https://docs.gitlab.com/ee/administration/dedicated/hosted_runners.html) is a product first offered to GitLab Dedicated customers
for beta testing in Q4 FY25, with a general availability target of Q2 FY26.

## Who is using Hosted Runners?

To identify if a customer is using Hosted Runners, use Switchboard.

1. Log in to Switchboard -- all Support Engineers can [access Switchboard](dedicated_switchboard.md#accessing-switchboard)
1. Click **Manage** next to the tenant that you're interested in
1. Look for **Hosted runners** at the top (If you do not see **Hosted runners**, that tenant isn't using Hosted runners for GitLab Dedicated)

## Viewing Logs

Logs from a hosted runner for GitLab Dedicated are available via Opensearch, along with the logs from the GitLab application. See [GitLab Dedicated Logs](dedicated_logs.html) to learn more.

To view only runner logs use the filter: `fluentd_tag: -fleeting-logs`. The full value is `cloudwatch.<name>-fleeting-logs`, where `<name>` is the value of the name attribute in the [Runner Model](https://gitlab-com.gitlab.io/gl-infra/gitlab-dedicated/runner-model-schema/). (Click **CommonProperties**.)

Only `gitlab-runner` and `systemd` are sent to OpenSearch. For job logs reach out to the customer.

## Monitoring

Monitoring Hosted Runners is done in Grafana. Details on how to access Grafana are available in [GitLab Dedicated Observability and Monitoring (Grafana)](dedicated_instance_health).

Once in Grafana, go to **Dashboards** and search the **Hosted Runner(s) Overview** dashboard. This dashboard has plots on different runner metrics.
The dashboard is available for all tenants but is only populated if Hosted Runners are being used by the customer.

## Architecture

GitLab Hosted Runners are created on `ec2` AWS instances.

## Useful References

- [Dedicated team Hosted Runner Model](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/runner-model-schema/-/blob/main/docs/model-examples.md)
- [Dedicated team Hosted Runner technical document](https://gitlab-com.gitlab.io/gl-infra/gitlab-dedicated/team/engineering/projects/dedicated_hosted_runners/index.html)
