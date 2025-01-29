---
title: "Purple Teaming at GitLab"
no_list: true
---

The terms "Red Team" and "Blue Team" are used to describe the roles of attackers and defenders during planned security exercises. At GitLab, where collaboration and transparency are two of our [core values](/handbook/values/), we like to join forces and conduct what is commonly referred to as "Purple Teaming".

GitLab team members can contribute, comment, view, or interact with us on Slack in the `#purple-team-ops` channel where we discuss ongoing purple-team operations.

## Goals of Purple Teaming

Purple Team operations help GitLab to better understand our organization's ability to detect and respond to real-world attacks. Given this deeper understanding, we can continue to strengthen these defenses based on the hands-on experience gained during *emulated* attacks, as opposed to the real thing.

At a high level, the goals of an operation generally fall into one of the following categories:

- To gauge the effectiveness of existing defensive capabilities (*Is our SIEM capable of detecting a compromised admin account?*)
- To practice and refine our procedures for responding to a breach (*Do our runbooks make sense? Can anything be automated?*)
- To understand our ability to detect and respond to a specific type of threat (*What would happen if we were targeted by a ransomware operator?*)

## Purple Team Operations

### Flash Operations

These are very short (1-2 weeks) and start with the identification of a relevant threat. Generally we'll schedule a call or relevant

### Longer-term collaborations

e.g. [Atomic Testing](atomic-testing.md)

## Purple Team Resources

### Tools

- [Vectr](https://vectr.io/): A free, closed-source Purple Team planning and reporting tool.
- [MITRE CALDERA](https://caldera.mitre.org/): A free, open-source adversary emulation and automation tool.
- [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/): A web application to visualize and manipulate matrices of attacker tactics and techniques.

### Training

- [Red Team Development and Operations](https://redteam.guide/): An excellent book by Joe Vest and James Tubberville.
- [Purple Teaming Execution Framework](https://github.com/scythe-io/purple-team-exercise-framework): Another great resource, this one by Scythe.
- [MITRE ATT&CK: Getting Started](https://attack.mitre.org/resources/getting-started/): A collection of resources realted to the ATT&CK framework, which is used as the foundation for much of our work.
