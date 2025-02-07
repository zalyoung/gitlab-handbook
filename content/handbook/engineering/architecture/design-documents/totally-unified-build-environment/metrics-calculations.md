---
title: "Totally Unified Build Environment - Metrics Calculations"
status: ongoing
creation-date: "2025-02-06"
authors: [ "@rmarshall" ]
coach: [ ]
approvers: [ "@deriamis", "@balasankarc", "@WarheadsSE", "@denisra" ]
owning-stage: "~devops::systems"
participating-stages: []
toc_hide: true
---

## Container size reduction calculation

The Totally Unified Build Environment will eliminate all build images from the
[Gitlab Build Images](ttps://gitlab.com/gitlab-org/gitlab-build-images) repository. The
script below generaets a comma separated value formatted file with all image sizes.

```shell
glab api --paginate "projects/${GITLAB_BUILD_IMAGES_PROJECT_ID}/registry/repositories" > gitlab-build-image-container-repositories.json

while read -r REGISTRY_ID; do
    export NO_COLOR="meow"
    export NO_PROMPT="1"
    glab api "registry/repositories/${REGISTRY_ID}?tags=true&tags_count=true&size=true" >> gitlab-build-image-container-sizes.json
done < <(cat gitlab-build-image-container-repositories.json |jq '.[] | .id')

cat gitlab-build-image-container-sizes.json | jq -r 'select(.name != "") | [.name, .size, .id] | join(",")' > gitlab-build-images-sizes.csv
```

## Container runtime duration calculation

Gather data about pipeline durations with the script below.

```shell
glab api --paginate "projects/${GITLAB_BUILD_IMAGES_PROJECT_ID}/pipelines" > gitlab-build-images-pipelines.json

while read -r PIPELINE_ID; do
    export NO_COLOR="meow"
    export NO_PROMPT="1"
    glab api "projects/${GITLAB_BUILD_IMAGES_PROJECT_ID}/pipelines/${PIPELINE_ID}" >> gitlab-build-images-pipeline-data.json
done < <(cat gitlab-build-images-pipelines.json | jq -r '.[] | .id')

cat gitlab-build-images-pipeline-data.json | jq -r 'select((.duration != null) and (.duration != 0)) | [.duration, .started_at] | join(",")' > gitlab-build-image-pipeline-durations-and-start-times.csv
```

This is a view of the pipeline durations in `gitlab-build-images` for June, 2024.

|Metric                     |Duration in Seconds  |Duration in Minutes|Total Pipelines|
|---------------------------|---------------------|-------------------|---------------|
| Geometric Mean            | 462                 | 8                 | 118           |
| Arithmetic Mean           | 1,869               | 31                | 118           |
| ST Deviation (Population) | 3,304               | 55                | 118           |
| Variance                  | 10,915,662          | 181,928           | 118           |
| Max Duration              | 20,501              | 342               | 118           |

The positive variance and large standard deviation show how lopsided the
values are due to full container rebuilds. The Totally Unified Build
Environment eliminates these duplicate builds in favor of the ones used to
release in production and reduces both the variation and standard deviation
in this project.

## Labor cost calculations

Runtime update validation operates in two distinct phases. The first phase
prepares the build contains for usage by all teams.  The second phase is the
validation work performed across teams and managed by Build.

### Validation process start up

The current process requires updates to five projects to start validation:

- GitLab build images.
- GitLab Runner.
- Omnibus GitLab Builder.
- Cloud Native GitLab.

Assume:

- A standard knowledge worker week is only thirty-two productive hours.
- A given engineer only allocates twenty percent of time.
- With five projects, four merge requests require an author and two
  reviewers each.
- Major updates happen twice per year per runtime.
- Patch releases happen 6 times per year per runtime.

The Totally Unified Build Environment eliminates all startup time for a build
dependency update. This translates into this calculation:

```text
(4 authors + 10 reviewers) = 14 engineers
32 productive hours per engineer at 20 percent = 6.4 hours per engineer
14 engineers * 6.4 hours per engineer = 89.6 engineering hours per update
(2 major releases + 6 minor releases) * 89.6 hours = 716.8 engineering hours per year
```

This translates to 22.4 engineering weeks added back for higher value tasks.

### Validation process duration

A Build engineer may spend roughly 24-36 hours to create, track, and
manage a single release. This includes any `do-it-yourself` issues and
co-ordination across multiple teams.

For an average patch release, it takes about one full week with a dozen
engineers allocated at ten percent to bring all projects on board and ready
to start validation.

For a major release, this could be as long as two full weeks with a dozen
engineers allocated at twenty-five percent. This timeframe fluctuates with
the impact of breaking changes.

Assumptions:

- Updates touch a dozen projects across GitLab.
- Each project requires three engineers, an author plus two reviewers.
- A standard knowledge worker week is only thirty-two productive hours.

| Update Type   | Calculation                                                                                              |
|---------------|----------------------------------------------------------------------------------------------------------|
| Major release | ((12 projects x 3 engineers) x (32 hours x .25)) = (36 engineers) x (8 hours) = 288.0 engineering hours  |
| Patch release | ((12 projects x 3 engineers) x (32 hours x .1)) = (36 engineers) x (3.2 hours) = 115.2 engineering hours |

Part of the percentage cost falls into these categories:

- Recognition of the task to do
- Scope the change process
- Fit the work into the current plan
- Disruption costs (late changes, priority shifts)

The disruption costs are harder to quantify and are multiplicative across
each engineer involved. [The Agile Couch](https://theagilecouch.com/2021/05/25/the-real-costs-of-context-switching/)
posits that an additional task incurs a twenty percent loss in productivity
that may be counted as opportunity loss. The Build team supports
runtimes for Go, Rust, Ruby, NodeJS, and Python in addition to other major
shared build dependencies.

| Labels                         | Patch Release | Major Release |
|--------------------------------|---------------|-------------|
| Total / Year / Runtime         | 6             | 2           |
| # Engineers / Project          | 3             | 3           |
| # Projects                     | 12            | 12          |
| Hours Available                | 32            | 32          |
| Time Allocation                | 10.00%        | 25.00%      |
| Total Runtimes                 | 5             | 5           |
| Work Estimate (Hours)          | 3,456         | 2,880       |
| Productivity Cost (Hours/Year) | 691           | 576         |
| Productivity Cost (Weeks/Year) | 22            | 18          |

The Build team does not feel this full impact in time as sometimes updates
are skipped. For those misses, the cost would be quantified in los of good
will, customer exposure for both self-managed and SaaS, and potential
impacts to GitLab's certifications.
