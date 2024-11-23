---
title: "GitLab Runner Technical Vision"
status: proposed
creation-date: "2024-11-05"
authors: [ "@josephburnett", "@ajwalker" ]
coach: 
approvers: [ ]
owning-stage: "~devops::verify"
participating-stages: [ ]
toc_hide: true
---

{{< design-document-header >}}

This document is a technical vision, not a product or feature
roadmap. It describes how to decompose the GitLab Runner problem space
in such a way that it can be reassembled into the products and
features we have, the ones we want, and the ones we haven’t thought of
yet.

> "Design is to take things apart in such a way that they can be put
> back together" - Rich Hickey
> https://www.infoq.com/presentations/Design-Composition-Performance
> (3:10)

# Objective #

The composition and abstractions of this architecture are designed to
solve several long-standing difficulties in the GitLab Runner. They
will allow faster feature development by allowing external teams to
"solve their own problems" with plugins and steps independent of the
core runner team. Decomposition along orthogonal dimensions of
responsibility instead of "executors" will allow for more simple
components with higher test coverage and overall higher reliability.
Consistent use of fewer abstractions will allow easier understanding
of the codebase and less repeated work.

# Problems #

## Codebase ##

GitLab Runner's codebase hasn't aged too well and has been extended in
multiple directions with compromises being made to add new features.

There are very large `common` and `helper` packages, for example,
which almost everything ties into.

Challenges:

- The poor separation of concerns leads to easy leaky abstractions,
  furthering the difficulty in rectifying the problem.
- As well as being less than ideal from a development and maintenance
  perspective, it means we currently have some restrictions. For
  example, the `gitlab-runner-helper` binary should be lightweight,
  but because it imports `common`, that pulls in an entire world of
  dependencies.
- GitLab Runner can't target `AIX` today due to incompatible
  dependencies, but the helper binary could be supported with an
  improved separation of concerns.

## Abstract Shell ##

GitLab Runner converts jobs into multiple target scripts that execute
within the job environment. These scripts perform predefined tasks,
such as fetching Git sources or extracting caches, as well as
executing user-provided scripts (`before_script`, `script`, and
`after_script` from the CI/CD config).

GitLab Runner has built-in support for `powershell`, `pwsh`, and
`bash`/POSIX shells, and it employs an abstract shell implementation
to convert target scripts accordingly.

Challenges:

- The GitLab Runner manager generates the target script, but jobs
  often execute in remote environments. This can lead to scripts that
  are unfit for the target environment. A common problem is with path
  names.
- Shell behaviour can vary based on the version, OS settings, and
  script execution method (via a file or stdin). Addressing one edge
  case often introduces another, resulting in a constant game of
  whack-a-mole.
- Limited shell support presents challenges, as maintaining and
  implementing the full feature set for the current supported shells
  is already a maintenance burden. The removal of the `cmd` shell,
  though still widely used, was due to difficulties in maintenance and
  feature implementation.
- Feature set deviation: Adding new features that rely on the abstract
  shell is often difficult to achieve consistently across all
  supported shells at once.

## Executors ##

GitLab Runner's executors handle the logic required to run a job on a
target platform.

Challenges:

- Different executors demand unique approaches to address the same
  issues, such as script execution and logging, often resulting in
  significant compromises and leaky abstractions.
- Executors focus solely on individual jobs. For instance, with Docker
  and Kubernetes executors, a new connection is established for each
  job. This approach is unsuitable for longer-lived routines needed
  for functions like garbage collection.
- In-built executors cannot be ported to the "custom executor" due to
  the limitations of custom executor abstractions and the tight
  coupling between executors and the rest of the code base within the
  existing architecture.
- For Docker and Kubernetes, a "helper" container facilitates
  predefined scripts. However, several problems emerge from the helper
  being outside the environment where user scripts are executed,
  typically involving ownership and file permissions.
- Feature set deviation: Some executors have features others lack. For
  example, web terminal support is something that needs
  re-implementing for each executor, so not all executors support it.

## Job micro-managing ##

A job is split into multiple stages: `get_sources`, `restore_cache`,
`download_artifacts`, `user_script`, `after_script`,
`upload_artifacts_on_success` etc.

GitLab Runner communicates with the job's environment, instructing it
to execute each stage's script in an ad hoc manner. It waits for the
script to complete, reads the status code (to determine success or
failure), and then proceeds to initiate the next stage.

Challenges:

- If the job's environment is remote and the connection drops while
  executing a script, Runner cannot resume execution. This issue was
  frequent with the Kubernetes executor, prompting shell scripts to be
  executed in the background, with log output redirected to a file
  read by a separate, resumable process. This adds complexity to the
  executor and is only available for Kubernetes. This intricate change
  led to numerous customer-discovered edge cases and took several
  milestones to address.
- Because Runner controls the execution flow, it cannot crash/exit and
  resume jobs after a restart.

## Configuration ##

Runner's configuration is complex:

- Multiple runner configurations can be defined.
- Several layers:
  - Global configuration
  - Runner configuration
  - Executor configuration
  - Autoscaling configuration

Challenges:

- Numerous configuration options

  Runner supports setting variables in the config file, environment
  variables, and command line inputs. However, the config file is the
  only method that supports all settings. The twelve-factor
  methodology for configuration is arguably poor suited to Runner's
  complex options.
- All executor options are displayed, regardless of the executor being
  configured, making the `--help` command overwhelming.
- No validation.
- No user-provided validation exists for job-provided
  configurations. Ad hoc settings, such as the Kubernetes executor's
  `cpu_limit_overwrite_max_allowed`, allow a job to specify the CPU
  limit, but maintaining these fields is a maintenance burden.
- Although configuration files allow for comments, registering a new
  runner (or anything that triggers a config rewrite) discards the
  comments.

## Job logs ##

A job log combines data from various sources, including the runner
manager, executor, services, user scripts, and more.

Challenges:

- No semantic markup: We only support collapsible sections and ANSI
  colour codes.
- No timestamp support: Timestamps only appear for whole sections,
  which is rarely granular enough to be helpful.
- Interleaved logging from multiple sources can lead to collisions,
  which may impact processes like secret masking.

# Vision #

## Environments ##

GitLab Runner is available for all major operating systems and
architectures. It can run thousands of jobs concurrently in local or
remote environments. It can autoscale remote environments based on
current and future load. It can be adapted to an unbounded number of
environments through a self-service plugin mechanism, such that
autoscaling works out-of-the-box.

The runner operating system and architecture does not need to match
that of the remote environment. GitLab Runner is capable of
discovering and reconnecting to jobs running in remote environments,
without losing job state. It provides observability of the remote
environment capacity and asserts back-pressure in response to resource
constraints (such as insufficient capacity).

## Job Composition ##

Jobs are delivered as gRPC payloads. All jobs are composed of steps
which are executed by an agent (Step Runner) in the job
environment. Steps may be local or remote. Local step versions are
determined by the commit SHA. Remote step versions are determined by a
secure lockfile stored in the repository. The results of a job are
returned over gRPC to GitLab (separately from the logs) and describe
the exact parameters of every step executed. Steps can be written to
be deterministic, allowing step results to be used to reproduce
artifacts, byte-for-byte

Step policy is provided by GitLab and enforced by GitLab Runner and
its agent in the job environment. Policy may constrain available steps
and their versions, insert required steps, and constrain resources
consumed (such as network and disk).

## Delegation ##

Steps can control the execution of sub-steps by sending a “run up”
request which is handled by Step Runner. If the run up request asks
for a separate environment, Step Runner will forward the request back
to GitLab Runner who will provision a separate environment for the
requested steps. Results from the run up request are passed back down
and the originating step can decide what to do with them. E.g. retry,
ignore, pass onward, etc..

This mechanism allows steps to be encapsulated in a separate
environment while maintaining control of environments in a single
place, GitLab Runner. Permission to access additional environments,
which steps can run in other environments, and additional privileges
are controlled by policy stored in GitLab and delivered with the job
payload.

Steps which are capable of creating their own environment locally,
such as a Docker step, can delegate steps into that environment with a
regular run (down) request. Having full control of the results, they
can decide what to do with them and then incorporate the results in
the overall tree. In this way the final job results capture step
execution across environments.

## Development ##

Job payloads container steps and calling parameters can be downloaded
from any environment and run locally for debugging. Or jobs can be
debugged in-place by inserting breakpoints into steps and connecting
via gRPC to see the execution context and interact with the job
environment. Steps can be unit tested with a built-in testing
framework. They can be published and consumed through public and
private catalogs, as well as within the local repository. Steps can be
marked as deprecated or defective and consumers are automatically
notified.

## Federated Ownership ##

Common aspects of jobs such as checkout, cache and artifacts are
implemented as steps, outside GitLab Runner and its agent. Vertical
integrations such as artifacts can be owned entirely by a single
team. E.g. The team who owns the artifact APIs in GitLab can also own
the steps that upload and download from them. GitLab Runner provides
an environment and injects the job payload. But it doesn’t control
exactly what runs in that payload. Ownership of various aspects of job
execution is federated to specialized teams. E.g. Artifact signing and
secret management are implemented as steps owned by other teams.

## Unified Execution ##

GitLab Runner has one way to execute jobs. All aspects of “executors”
are implemented by means of encapsulation steps (such as Docker) or as
pre/post hooks in the environment plugin mechanism. Runner is
responsible only for dispatching jobs to environments and connecting
to those environments to deliver the job payload and return results.

There is no more “kubernetes” executor, just a Kubernetes plugin
configured with GitLab runner, capable of customizing pods according
to job requirements. There is no more “docker” executor, just a Docker
step which wraps the job payload. There are no more built-in services,
just service steps which the runner prepends to the job payload.

Even pre-existing "scripts" are wrapped and delivered as step payloads
so all CI configuration gain the benefits of a unified steps-based
execution model.

## Management ##

GitLab Runner is supported by tools to setup, configure and maintain
small, medium and large installations. Fleet management tools
implement industry best practices such as blue-green
deployments. These tools are used to operate all runners on GitLab.com
as well as being available for self-hosted customers. Anyone can
contribute to GitLab.com’s runner infrastructure.

Default images for remote job environments are publicly
available. Tools to build private images are also available and work
out-of-the-box. Best practices for GitLab Runner efficiency and
reliability are implemented in the shared tool set.

## Observability ##

Time spans for every job, step and sub-step are exported via
OpenTelemetry and are available as observability data. Likewise
real-world resource consumption (CPU, memory, etc..) is available for
each job. Resource consumption is tracked over time and, when an
environment permits, resource requests are tailored automatically to
the job’s need.

Resource metrics are fetched by GitLab Runner through the
environment-specific plugin for each job. Time spans are returned to
GitLab Runner with step results. Overall capacity and load is
aggregated by the autoscaling component within GitLab Runner. This
metric data is pushed from GitLab Runner to a gRPC endpoint on GitLab
for observability purposes, so it can be proxied the the appropriate
time-series database. Load are also returned to the Job Router for
autoscaling and routing purposes.

## Routing ##

Job routing and autoscaling decisions are made centrally in a simple,
dedicated routing service. Jobs can be routed around outages and
capacity limitations. Created jobs are immediately known to the runner
autoscaling system, even before the jobs are ready for
execution. GitLab can provide policy which affects routing, including
preferred regions, providers and instance types.

Jobs can also be routed according to resource requirements and
available capacity, reported by individual runners. Jobs can also have
a relative priority which will affect queuing behavior.

# Architecture #

Arrows are the flow of data

![Architecture Diagram](tech-arch.drawio.png)
