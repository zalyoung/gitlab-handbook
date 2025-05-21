---
title: Infrastructure Security
description: Infrastructure Security Charter
---

Last Updated: May 20, 2025

## Mission Statement

The Infrastructure Security team ensures that GitLab's cloud infrastructure meets the rigorous expectations of our customers who depend on our software factory platform to power their critical operations. Composed of [Infrastructure Security](/handbook/security/product-security/infrastructure-security), [Data Security](/handbook/security/product-security/data-security), and [Security Logging](/handbook/security/product-security/security-logging), we partner with Engineering and Product to implement robust controls, identify and remediate misconfigurations, and support infrastructure dependencies for peer security teams.  

## Value Proposition

Through implementation of DevSecOps principles we empower teams across GitLab to operate Infrastructure at scale with effective security Observability , risk visibility, consultation support, and implementation support to uphold the trust that is placed upon GitLab with our customer's sensitive information while accelerating velocity.   

## Scope and Responsibilities

### Primary Areas of Ownership

- **Cloud Security Reviews and Consultation**: Review new infrastructure and features to ensure that our Security Policies & Standards are met, consult with engineers to solve challenges securely, build secure defaults and examples.   

- **Infrastructure Security Observability**: Deployment and management of tools to improve security visibility capabilities and detection of security events within our infrastructure (e.g. Wiz, Wiz Runtime Sensor).

- **Misconfiguration Detection and Remediation**: Leveraging our observability tooling we monitor GitLab's cloud environments for misconfigurations, triage them for severity, collaborate with system owners to design and implement remedial activities, and build secure defaults to prevent recurrence.  

- **GitLab Dedicated for Government (FedRAMP)**: Overseeing firewall rules, network appliances, security observability and enforcement tools, and continuous monitoring of infrastructure components.  
- **Security Logging**: Manage the GitLab SIEM by building and operating pipelines to gather, filter, and transport logs that enables Security Operations to protect GitLab and our customers. 

### Shared Responsibilities

*Vulnerability Management:* We interface with the Vulnerability Management team to support shared observability tooling, validate infrastructure vulnerabilities, and remediation of misconfigurations. 

*Secure by design:* SPA is responsible for strategic architectural reviews for large and complex efforts. We focus on reviewing project-level implementation and existing controls for posture alignment.

*Security Response:* We support Security Operations and Application Security on bug bounty and security events that may have an infrastructural component associated. In FY26, we expect to transition this to the PSIRT who will request assistance from us as required.   

*Customer Escalations & Inquiries*: Customer inquiries should be managed by the Field Security team with support from Infrastructure Security as needed.

*Security Assurance:* We partner with Assurance and Engineering teams to triage audit findings, ensure that solutions meet requirement standards, and gather evidence to substantiate our controls.
### Out of Scope

- *Endpoint Security*: End-user system asset management and security, which is owned by CorpSec.


## Contacting Us

### Slack

*  Primary team-wide channel for discussion: `#security-infrasec`
* Sub-team specific channels:
	* Security Logging: `#security-logging`
	* Data Security: `#security-datasec`

### GitLab Mentions

* `@gitlab-com/gl-security/product-security/infrastructure-security` 
* `@gitlab-com/gl-security/product-security/security-logging` 
* `@gitlab-com/gl-security/product-security/data-security` 

In the event of an emergency, GitLab Team Members should page the Security Incident Response Team in any channel using the command `/security`.
## FY26 Strategic Initiatives

* Supporting the GitLab Dedicated for Government (FedRAMP) Environment
* Expanding our Security Observability  coverage
* Contributing towards a Cloud Security Framework for GitLab


## FY26 Metrics

Infrastructure Security is working on rebuilding our metrics to better reflect the impact we have on GitLab. Currently, we're focused on measuring and enhancing our Security Observability Coverage Goal by harmonizing visibility across SKUs.
