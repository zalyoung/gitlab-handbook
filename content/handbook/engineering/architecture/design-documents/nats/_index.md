---
title: "NATS"
status: proposed
creation-date: "2025-02-26"
authors: [ "@ankitbhatnagar", "@arun.sori"]
coach: [ "@andrewn" ]
approvers: []
owning-stage: "~group::platform insights"
participating-stages: []
toc_hide: true
---

{{< design-document-header >}}

## Summary

This document proposes design, architecture and a rollout roadmap for adopting & using [NATS](https://docs.nats.io/nats-concepts/overview) to support data messaging & queuing needs at GitLab scale.

From some of our recent initiatives such as building the [Data Insights Platform](https://docs.google.com/document/d/1V3XRXfPquBrI_-ob9Fn2Jdskq7W4-heG6zBjJ66AOx8/edit?usp=sharing) or [Project Siphon](/handbook/engineering/architecture/design-documents/siphon/), it has become evident that we need a scalable & reliable queueing system within our technology stack to be able to ingest & process large amounts of data. Having gone through multiple discussions around this, we have narrowed down our choices to [using NATS](https://docs.nats.io/nats-concepts/what-is-nats) as a solution to these needs.

## Motivation

A primary driver for having a _scalable data queue_ within our tech-stack is building our ability to ingest large amounts of data, especially analytical or monitoring data. While it is totally possible to persist data directly into our databases, it's riddled with scalability challenges. For example, when ingesting data into ClickHouse, the database given its architecture - performs much better when ingesting large batches of data across fewer writes than ingesting a large number of small writes. Some past context around [our experience with this](https://gitlab.com/gitlab-org/opstrace/opstrace/-/issues/2044).

Another key requirement is to be able to _process_ incoming data before it lands within a database. At minimum, we need the ability to perform operations such as:

- dynamically enrich incoming data with metadata from other systems & data catalog,
- ensure ingested data does not contain sensitive information and anonymize, pseudonymize, or redact data as needed,
- batch data outside of main storage while certain (logical) conditions are met,
- fan-out ingested/processed data to multiple destinations, etc.

Having a _data buffer_ available upstream to actual storage also helps alleviate resource pressure downstream by absorbing large spikes in volumes of ingested data which tends to happen quite frequently with the nature of data at play here.

Considering [our forward-looking use-cases](#looking-forward), we'll need such a system to be __consistently available across all our deployment-models__ for GitLab instances, i.e. GitLab.com, Cells, Dedicated or Self-Managed. This would ensure we can consolidate how we deal with any data stream generated across the product. With such a large deployment surface, it's important we reduce any distribution & operational complexities of running such a system while ensuring its reliable, lightweight and capable of delivering performance at GitLab scale.

All things considered, NATS stands out given its minimal footprint, ease of distribution and its ability to both be embeddable within the Product and scale out as a standalone deployment as needed.

### Goals

- Establish scalable & reliable data queueing infrastructure for a few initial adopters: Siphon, Data Insights Platform.
- Provide authenticated & authorized access to all ingested data into NATS.
- Provide necessary documentation to allow developers to interact with NATS.
- Integrate NATS with existing GitLab infrastructure to enable the aforementioned use-cases.

### Non-goals

- Not build a general-purpose event-bus for all our queueing/eventing needs.
- Not cover application-level implementation details using NATS SDKs to interact with NATS.

## Proposal

The main proposal is to __establish NATS as a foundational piece__ within our tech-stack and build out necessary NATS clusters well-integrated with GitLab installation(s).

For this first iteration, we do not expect to have all GitLab services or applications interacting with NATS directly. The only planned usage right now is the following:

- Siphon using NATS to [buffer Postgres replication events](/handbook/engineering/architecture/design-documents/siphon/#main-components) before landing them in ClickHouse.

- Applications sending Snowplow-instrumented events to [Data Insights Platform](https://gitlab.com/groups/gitlab-org/architecture/gitlab-data-analytics/-/epics/12) via [event instrumentation layer](https://gitlab.com/groups/gitlab-org/architecture/gitlab-data-analytics/-/epics/13) which are [dynamically enriched](https://gitlab.com/groups/gitlab-org/architecture/gitlab-data-analytics/-/epics/33) and landed into ClickHouse and AWS S3.

### Looking forward

Once NATS is available, we aim to position NATS as the data queueing backbone for a general-purpose [events-based Data Platform within the Product](https://gitlab.com/groups/gitlab-org/-/epics/14860), additional to the aforementioned Data Insights Platform. Following is a detailed set of use-cases that benefit from the existence of a centralized Data Platform:

| Teams/areas | Use-cases | Expected scale |
|---|---|---|
| Enterprise Data/Infrastructure | Logically replicating data out of Postgres. | ~100GB of new data ingested from Postgres per hour. We'll also need to scale with Cells architecture. |
| Platform Insights | Ingesting & processing large amounts of analytics data in real-time, then persisting it into ClickHouse.| Product Usage Data: 1200 events/sec (100M daily), ~15GB/hour, expected to increase with increase in instrumentation + 2.5x when pursuing [event-level data collection from the customer's domain](https://docs.google.com/document/u/0/d/1x8M4t0ELrPlnNJcSXx4juvavV-Yh_NWCom6zo8AmY9o/edit) (about 300M events daily). |
| Machine Learning | Extracting & processing events/features from GitLab data to create training/test datasets for ML models at scale. |  |
| Security & Compliance | Extracting and actioning upon events, e.g., audit events, from GitLab data in near real-time. | __Audit events saved to database per day__ (excludes streaming only audit events) - ~0.6M records are created per day _(audit event coverage has stalled due to load on Postgres, this is likely to increase if this migrates over to an event pipeline)_ <br><br> __Streaming only audit events generated per day__ (this excludes audit events saved to DB) - ~35M streaming only events are created per day. <br><br> Total estimates would be at __~40M events per day__. See [Kibana dashboard (internal)](https://log.gprd.gitlab.net/app/dashboards#/view/338615b0-1eea-11ee-8afc-c9851e4645c0?_g=\(\)). |
| Product development | [Generic Events Platform](/handbook/engineering/architecture/design-documents/gitlab_events_platform/) to asynchronously process data, events & tasks. Ingesting & processing external data via webhooks as a service. |  |
| Product development | Implementing real-time analytics features on top of an analytical database (ClickHouse). (primarily the Optimize team would be involved,other product teams might also contribute) | Data volume: Similar or less than what we observe with the PostgreSQL databases. Depends on how many tables we replicate (Siphon) to ClickHouse.   Enqueued event count: significantly lower as we’re batching the CDC events into packages. |
| Plan | [JIRA Compete Strategy](https://gitlab.com/groups/gitlab-org/-/epics/364) |  |

### Rejected alternatives

A feasible solution to the aforementioned use-cases is not limited to NATS only, with a few other backends considered throughout our discussions. Some of the backends which were deemed less preferable over NATS were the following:

| System/Technology | Key-takeaways |
|---|---|
| GCP PubSub | Limited availability across our deployment environments, data-transfer across network boundaries is expensive, high operational costs at scale |
| Apache Kafka | [Substantial distribution & operational complexity](#why-not-kafka). |
| RabbitMQ | [Unfamiliar technology](https://www.rabbitmq.com/docs/which-erlang) to our tech-stack, resultant distribution complexity |

A major concern discussed across these backends is the operational, distribution & support overheads around both running them ourselves or expecting them to be available inside non-hosted environments such as Self-Managed. NATS was considered the _least expensive_ across all backends, considering it [ships as a single Go-binary](https://docs.nats.io/running-a-nats-service/introduction/installation) and can be installed in close-proximity to user services/applications with zero external dependencies. When needed, it can be scaled/sharded out across multiple servers/clusters subject to which reference architecture we run it within.

### Components

- One or more [Jetstream-enabled](https://docs.nats.io/nats-concepts/jetstream) NATS servers
- Persistent volumes, preferably SSDs, for each deployed NATS server.
- Decentralized authentication callout server (long-term only) : For authentication/authorisation, we aim to start with leveraging hard-coded roles & credentials within NATS (centralized) but in the long-term, we expect to use a [decentralized server-side auth-callout implementation](https://docs.nats.io/running-a-nats-service/configuration/securing_nats/auth_callout) for authenticating inbound traffic.

### Deployments

With the intention to make NATS available to every GitLab installation, we aim to build necessary support for the following deployment models:

| Deployment type | Proposed topology |
|---|---|
| GDK | Run local to the installation |
| .com | Dedicated cluster |
| Cells | One or more clusters subject to cells-topology |
| Dedicated | Dedicated cluster per instance |
| Self-Managed | Standalone cluster subject to distribution |

### Tenancy

For all deployment-types, we expect a given __NATS cluster to be multi-tenant__, i.e. multiple users/services hosted on the deployment to share the same underlying NATS infrastructure for their messaging needs.

## Rollout roadmap

| Deliverables | Timeline |
|---|---|
| Pre-staging/Testing | FY26Q1 |
| Staging | TBD |
| Production: .com | TBD |
| Gradual rollout to Dedicated | TBD |
| Gradual rollout to Self-managed | TBD |

## Design & Implementation

### Architecture

The following diagram depicts a simple 3-node NATS cluster deployed as a `StatefulSet` with dedicated persistent volumes. A given application can then discover the service:

- using a headless service, or

```text
nats.default.svc.cluster.local
```

- addressing the pods directly

```text
nats-0.nats.default.svc.cluster.local
nats-1.nats.default.svc.cluster.local
nats-2.nats.default.svc.cluster.local
```

![server-setup](/static/images/engineering/architecture/design-documents/nats/server-setup.png)

### Setup

- Setup an N-nodes cluster subject to data volumes & retention.
- Enable data persistence via [NATS Jetstream](https://docs.nats.io/nats-concepts/jetstream).
- Configure [stream replication](https://docs.nats.io/nats-concepts/jetstream/source_and_mirror) for subjects as needed.

### Connectivity

- NATS comes with support for both plaintext and TLS connections; we intend to use TLS-enabled connections to help authenticate all incoming traffic.

- Access to the NATS service will only be available to internal network clients. External clients will not be able to connect to the NATS service.

- External load-balancing is therefore not needed, which is also [highly advised against](https://docs.nats.io/running-a-nats-service/environment#load-balancers). Each NATS server in a given cluster must be reachable individually with all loadbalancing deferred to NATS itself.

- For Cells-based installations, we can leverage the use of [NATS Gateways](https://docs.nats.io/running-a-nats-service/configuration/gateways) to connect clusters should we need to, but we expect each cell to be serviceable in isolation for majority of our applications.

### Topology

- For `GitLab.com`, we intend to setup & run NATS clusters cloud-natively on Kubernetes with the assumption that the following potential overheads can be well-managed:
  - running stateful workloads within Kubernetes.
  - [performance overheads from routing traffic within Kubernetes services](https://docs.nats.io/running-a-nats-service/environment#virtualization-containerization).
  - load-balancing traffic via Kubernetes service-topology.

- From an operational perspective and considering we prefer new services to be built Kubernetes-based, it'll also be trivial for us to use the same configurations for GitLab.com, Dedicated, Cells and Self-Managed going forward.

- If running it cloud-natively does incur overheads, we can resort to running NATS directly on VMs within the same VPC/network-boundaries to leverage better utilisation of the underlying hardware and reduce any operational complexity.

- We have also prototyped both of these deployment models:
  - using Helm chart for cloud native installations, [initial POC](https://gitlab.com/gitlab-org/architecture/gitlab-data-analytics/nats-poc)
  - using Terraform directly on cloud VMs - [initial POC](https://gitlab.com/gitlab-org/architecture/gitlab-data-analytics/nats-terraform)

### Data persistence

- NATS allows all ingested data to be stored in-memory or disk-based.
- We intend to leverage Jetstream to persist all ingested data durably.
- We expect to use SSDs to improve performance.
- We intend to plan disk-sizing based on retention policies for ingested data, possibly overestimating it to begin with, especially while we tune our needs gradually. It is also prudent to ensure we can resize underlying storage trivially when needed.
- We aim to enable compression to reduce storage footprint further.

### Integration with GitLab

- We can add the aforementioned NATS connection string to the instance configuration to be used by services/applications. For example:
  - Add `nats['address'] = 'nats://nats.default.svc.cluster.local:4222'` to `/etc/gitlab/gitlab.rb`, or
  - Override `NATS_URL=nats://nats.default.svc.cluster.local:4222` in `gitlab.yml`.

## Security

### Authentication/Authorization

- NATS has prebuilt support for connections encrypted over TLS.
- It also comes with centralised auth support via JWT/NKEYS.
- We expect to promote the usage of separate principals (users/accounts) across distinct systems, e.g. producers/consumers of a given stream.
- NATS offers grouping of clients and subject space with [`accounts`](https://docs.nats.io/running-a-nats-service/configuration/securing_nats/accounts).

#### Sample authentication/authorization scheme

We take Siphon as an example use case here.

It will cover:

- Creation of accounts to isolate clients
  - Adding users to these accounts with specific permissions for available subjects. Authentication will be achieved via [nkeys](https://docs.nats.io/running-a-nats-service/configuration/securing_nats/auth_intro/nkey_auth).
  - Producers and consumers have their own users and permissions.
- Producer/Consumer nkeys are to be treated with the same security practices as we currently do for our database secrets.

`authorization.conf` ->

```text
listen: 127.0.0.1:4222
jetstream: enabled

producer_permissions = {
  publish = ">"
  subscribe = ">"
}

consumer_permissions = {
  publish = {
    deny = ">"
  }
  subscribe = ">"
}

accounts: {
    siphon: {
        users: [
            {nkey: Uxx, permissions: $producer_permissions},
            {nkey: Uxx, permissions: $consumer_permissions}
        ]
    }
}
```

In the above configuration, producer is allowed to publish and subscribe over all the subject space for `siphon` account while consumer is only allowed to subscribe to available subjects.\
We can also apply further granularity on subject space if desired. [`permissions`](https://docs.nats.io/running-a-nats-service/configuration/securing_nats/authorization#permissions-configuration-map) map allows for such fine-grained control.\
Example use of this configuration:

```go
func TestServerConfiguration(t *testing.T) {
    server, _ := RunServerWithConfig("authorization.conf")
    t.Logf(server.ClientURL())

  // producer_nkey.txt holds the nkey seed
    opt, err := nats.NkeyOptionFromSeed("producer_nkey.txt")
    if err != nil {
        t.Error(err)
        return
    }
    nc, err := nats.Connect(server.ClientURL(), opt)
    if err != nil {
        t.Error(err)
        return
    }
    js, err := nc.JetStream()
    if err != nil {
        t.Error(err)
        return
    }
    _ = js.Streams()
    defer nc.Close()
}
```

### Encryption

- We can enable on-disk encryption for NATS, [more details here](https://docs.nats.io/running-a-nats-service/nats_admin/jetstream_admin/encryption_at_rest).

### Auditing/Logging

- We can ship necessary [NATS logs](https://docs.nats.io/running-a-nats-service/configuration/logging) to our centralised logging infrastructure to enable any auditing/monitoring purposes.

## Operations

### Scalability

NATS is extremely lightweight and can support ingesting & digesting high amounts of messages with sub-millisecond latencies. Given its architecture, it's also optimized for handling backpressure and exercise flow-control subject to traffic volumes.

We ran the following preliminary tests against a single NATS server running on an `e2-medium (2 vCPUs, 4 GB Memory)` VM on GCE with an attached SSD disk-volume. Note, saturation was never reached.

- Writing & reading 100000 * 128B messages without persistence enabled

```text
ankitbhatnagar@nats-server-2:~$ ./nats bench foobar --pub 1 --sub 1 --msgs=100000 --maxbytes 20GB
12:22:30 Starting Core NATS pub/sub benchmark [subject=foobar, multisubject=false, multisubjectmax=100000, msgs=100,000, msgsize=128 B, pubs=1, subs=1, pubsleep=0s, subsleep=0s]
12:22:30 Starting subscriber, expecting 100,000 messages
12:22:30 Starting publisher, publishing 100,000 messages

NATS Pub/Sub stats: 540,996 msgs/sec ~ 66.04 MB/sec
 Pub stats: 286,886 msgs/sec ~ 35.02 MB/sec
 Sub stats: 285,111 msgs/sec ~ 34.80 MB/sec
```

- Writing 1000 * 1MB messages with persistence enabled

```text
ankitbhatnagar@nats-server-2:~$ ./nats bench foobar --pub 1 --size 1048576 --msgs=1000 --js --maxbytes 20GB
12:16:32 Starting JetStream benchmark [subject=foobar, multisubject=false, multisubjectmax=100000, js=true, msgs=1,000, msgsize=1.0 MiB, pubs=1, subs=0, stream=benchstream, maxbytes=20 GiB, storage=file, syncpub=false, pubbatch=100, jstimeout=30s, pull=false, consumerbatch=100, push=false, consumername=natscli-bench, replicas=1, purge=false, pubsleep=0s, subsleep=0s, dedup=false, dedupwindow=2m0s]
12:16:32 Starting publisher, publishing 1,000 messages

Pub stats: 308 msgs/sec ~ 308.18 MB/sec
```

- Writing 1000 * 1MB messages with 2 parallel publishers, persistence enabled

```text
ankitbhatnagar@nats-server-2:~$ ./nats bench foobar --pub 2 --size 1048576 --msgs=1000 --js --maxbytes 20GB
12:16:53 Starting JetStream benchmark [subject=foobar, multisubject=false, multisubjectmax=100000, js=true, msgs=1,000, msgsize=1.0 MiB, pubs=2, subs=0, stream=benchstream, maxbytes=20 GiB, storage=file, syncpub=false, pubbatch=100, jstimeout=30s, pull=false, consumerbatch=100, push=false, consumername=natscli-bench, replicas=1, purge=false, pubsleep=0s, subsleep=0s, dedup=false, dedupwindow=2m0s]
12:16:53 Starting publisher, publishing 500 messages
12:16:53 Starting publisher, publishing 500 messages

Pub stats: 270 msgs/sec ~ 270.46 MB/sec
 [1] 135 msgs/sec ~ 135.24 MB/sec (500 msgs)
 [2] 135 msgs/sec ~ 135.23 MB/sec (500 msgs)
 min 135 | avg 135 | max 135 | stddev 0 msgs
```

- Writing & reading 1000 * 1MB messages across 1 publisher, 1 subscriber with persistence enabled

```text
ankitbhatnagar@nats-server-2:~$ ./nats bench foobar --pub 1 --sub 1 --size 1048576 --msgs=1000 --js --maxbytes 20GB
12:18:52 JetStream ephemeral ordered push consumer mode, subscribers will not acknowledge the consumption of messages
12:18:52 Starting JetStream benchmark [subject=foobar, multisubject=false, multisubjectmax=100000, js=true, msgs=1,000, msgsize=1.0 MiB, pubs=1, subs=1, stream=benchstream, maxbytes=20 GiB, storage=file, syncpub=false, pubbatch=100, jstimeout=30s, pull=false, consumerbatch=100, push=false, consumername=natscli-bench, replicas=1, purge=false, pubsleep=0s, subsleep=0s, dedup=false, dedupwindow=2m0s]
12:18:52 Starting subscriber, expecting 1,000 messages
12:18:52 Starting publisher, publishing 1,000 messages

NATS Pub/Sub stats: 96 msgs/sec ~ 96.81 MB/sec
 Pub stats: 297 msgs/sec ~ 298.00 MB/sec
 Sub stats: 48 msgs/sec ~ 48.41 MB/sec
```

### Cost analysis

- TODO: Gather data wrt. reference architectures

### Monitoring

- Inbuilt monitoring exposed as Prometheus metrics, details [here](https://docs.nats.io/running-a-nats-service/nats_admin/monitoring).

### Failure Scenarios

- In the case of unavailability of NATS, we might experience loss of data especially in scenarios where NATS is where we land incoming data first.

- All ingested data is persisted durably via NATS Jetstream. In the event of unrecoverable messages however, we can rely on an explicit [disaster recovery setup](https://docs.nats.io/running-a-nats-service/nats_admin/jetstream_admin/disaster_recovery) to recover data, which includes:
  - Automatic recovery in case of intact quorum nodes for replicated streams, or
  - Manual recovery from periodic stream backups.

- We do not expect auth failures while we using centralized model with users/accounts setup within NATS beforehand but the introduction of an external auth callout service can add further failure domains to the system. We'll need to guarantee higher or equal SLOs on the auth-server as we intend for NATS as a service.

## Additional Context

### Why not Kafka?

Given our needs to queue/buffer data durably, Apache Kafka comes as an obvious first choice. However, given the operational & distribution complexity around running Kafka especially as we shift focus towards running GitLab as cloud-native deployments, it becomes _less favourable_ for our purposes. Following are some of our past discussions around the challenges Kafka brings:

- [Support for Kafka across deployment-environments is non-existent](https://gitlab.com/gitlab-org/opstrace/opstrace/-/issues/1878#note_1068741634).
- [Kafka can be cost-prohibitive regardless of scale](https://gitlab.com/gitlab-org/distribution/team-tasks/-/issues/1589#note_2060391762).
- [Kafka can be operationally intensive](https://gitlab.com/groups/gitlab-org/-/epics/14860#note_2080961778).

### Key considerations when comparing Kafka with NATS

| Feature | Comparison |
| --- | --- |
| Architecture | Kafka is a larger, distributed event streaming system while NATS is comparatively lightweight & high-performance messaging system. While Kafka is optimized for publish-subscribe usage, NATS allows all publish-subscribe, request-reply and data queueing patterns of usage. |
| Operations | Kafka requires Zookeeper/KRaft for coordination across partitions/topics/brokers while NATS ships as a single-binary with no external dependencies. Extending Kafka clusters warrants rebalancing partitions across brokers while NATS allows horizontally adding nodes more seamlessly. Kafka also warrants running it on a [JVM](https://en.wikipedia.org/wiki/Java_virtual_machine) while NATS can run natively on the given host. |
| Deployments | While Kafka can run cloud-natively within Kubernetes, it is comparatively more resource-intensive and comes with larger support overheads as compared to NATS with fewer components to operate. |
| Availability & Distribution | Ensuring Kafka is available across all our deployment-environments is challenging work, especially on smaller reference architectures given Kafka's cost-prohibitive nature even at small cluster-topologies. NATS on the other hand can be run with minimal overhead, be deployed in close proximity to GitLab installations with much smaller distribution effort. |
