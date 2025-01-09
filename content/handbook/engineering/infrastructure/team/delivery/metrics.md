---
title: "Delivery Team Metrics"
description: "The Delivery Team enables GitLab Engineering to deliver features in a safe, scalable and efficient fashion to both GitLab.com and self-managed customers."
---

## Metrics

[Delivery team](../_index.md) uses Mean Time To Production (MTTP) as an indicator of our speed capabilities
to deploy application changes into production.

- [Performance Indicator](../../performance-indicators/#mean-time-to-production-mttp)
- **Target: 12 hours.**

{{< tableau height="600px" toolbar="hidden" src="https://us-west-2b.online.tableau.com/t/gitlabpublic/views/InfrastructureKPIs/MTTP" >}}
{{< /tableau >}}

MTTP measures the elapsed time (in hours) from merging a change in gitlab-org/gitlab project master
branch, to deploying that change to GitLab.com.

## MTTP breakdown

The Delivery team is maintaining a [dashboard](https://gitlab-com.gitlab.io/gl-infra/software-delivery/delivery_dashboard/) breaking down MTTP into individual stages of an MR's path from merge to production (see the chart below. If it doesn't load, please log in to the [internal pages site](https://gitlab-com.gitlab.io/gl-infra/software-delivery/delivery_dashboard/))

<figure class="video_container">
<iframe src="https://gitlab-com.gitlab.io/gl-infra/software-delivery/delivery_dashboard/mttp.html" style="height:520px;width:100%;"></iframe>
</figure>

MTTP breaks down to:

- `time_to_merge`: The MR has been reviewed and is added to the merge train. A pipeline for merged results is running. At the end of this stage, the MR is merged.
- `master_pipeline_time`: The MR has been merged, the `master` branch pipeline is running. Afterwards the MR is valid to be picked up by the deployment pipeline.
- `time_to_auto_deploy_pick`: The MR is waiting to be included in an auto-deploy branch. This stage also contains delays due to production change locks, because we are not deploying and thus MRs wait longer until deployment.
- `time_to_build_finished`: A package is being built which includes the MR.
- `time_to_staging-canary`: The package containing the MR is being deployed to [staging canary](https://handbook.gitlab.com/handbook/engineering/infrastructure/environments/#staging-canary) and [staging ref](https://handbook.gitlab.com/handbook/engineering/infrastructure/environments/#staging-ref). QA smoke tests have run successfully.
- `time_to_canary`: The package containing the MR is being deployed to [canary](https://handbook.gitlab.com/handbook/engineering/infrastructure/environments/#production-canary).
- `promotion_delay`: As we are doing continuous delivery, deployments have to be manually promoted for production deployment. This stage measures the delay introduced by this manual promotion. The package containing the MR is now going to be deployed into production.
- `time_to_staging`: The package containing the MR is being deployed to the [staging environment](https://handbook.gitlab.com/handbook/engineering/infrastructure/environments/#staging)
- `time_to_prod`: At the end of this stage, the package containing the MR has been successfully deployed to the [production environment](https://handbook.gitlab.com/handbook/engineering/infrastructure/environments/#production)

To measure the MTTP subcomponents, the following metrics are used:

- [Deployment SLO](#deployment-slo)

These allows to decide whether we need to focus on speed or safety would have the
biggest impact on further reducing MTTP.

### Deployment SLO

- **Target: 8 hours.**
- [Dashboard](https://dashboards.gitlab.net/d/delivery-deployment_slo/delivery-deployment-slo?orgId=1&refresh=5m)

Deployment SLO measures the deployment frequency and duration by tracking
the percentage of deployment pipelines that complete within the target duration.
Deployment duration is measured as the elapsed time between a starting on staging canary (`gstg-cny`)
through the completion of the deployment on Production (`gprd`).
Visit the [Releases page](/handbook/engineering/releases/) for an
end-to-end overview of the various environments and [deployment process](/handbook/engineering/releases/#gitlabcom-deployments-process).

![Deployment SLO apdex](https://gitlab.com/api/v4/projects/430285/jobs/artifacts/master/raw/deployment-slo-apdex.png?job=refresh-delivery-slo-apdex-graph)

Next: Include [Deployment SLO metric as part of our release process](https://gitlab.com/groups/gitlab-com/gl-infra/-/epics/533)

### Release Manager workload metrics

The [Release Manager workload metrics - internal link](https://docs.google.com/spreadsheets/d/1xENgrQwAQkA3ImtxsnqgQYEGxxevbUeNhXLFRUUKayk/edit#gid=1820673269) track the time needed for Release Management tasks.

Each process is broken down into key parts to help identify where the majority of the effort is spent. Overall times are tracked and an average allows changes over time to been observed.

More details about what is being measured, and how, can be found in [the release docs](https://gitlab.com/gitlab-org/release/docs/-/blob/master/metrics/release_manager_workload.md).
