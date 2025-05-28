---
title: "Application Security"
description: Application Security home page
---
<!-- markdownlint-disable MD052 -->
Last updated: May 27, 2025

## Application Security Mission

**The Product Application Security subdepartment works with GitLab engineers and product teams to anticipate and prevent the introduction of vulnerabilities during design and development, ensuring delivery of high quality software GitLab customers can trust. We also identify, assess, and respond to security vulnerabilities discovered in GitLab products and services that are reported through [Coordinated Vulnerability Disclosure practices](https://about.gitlab.com/security/disclosure/).**

## Value Proposition

The Application Security subdepartment provides operational application of DevSecOps engineering and methodology, as well as data insights and security consultation that enables GitLab engineers to easily deliver high quality secure products and services to customers, while maintaining feature capabilities and velocity to market.

## Scope & Responsibilities

We organize our work into five pillars that emphasize Developer UX in the context of traditional DevSecOps programs. We call this the Secure Developer eXperience, or SDX.

- **SDX: Learn**: security training, governance, policy, documentation, and standards.
- **SDX: Design**: [threat modeling](threat-modeling/_index.md), feature design guidance and consultation, and [design reviews](appsec-reviews.md).
- **SDX: Code**: static analysis, software component analysis and supply chain security, use of approved tools and methodologies in development, deprecation of unsafe functions, etc.
- **SDX: Verify**: dynamic analysis testing, penetration testing, remediation of critical vulnerabilities, and [final security reviews](appsec-reviews.md) prior to release.
- **SDX: Maintain**: establishment of an incident response plan, managing [Coordinated Vulnerability Disclosure](https://about.gitlab.com/security/disclosure/), [bug bounty program administration](https://hackerone.com/gitlab?type=team), and critical product security incident response [release](https://about.gitlab.com/releases/categories/releases/) and post-release operations.

The Application Security sub-department includes two teams, the [*Secure Design & Development Team*](appsec-operations/sdd-services.md) and the [*Product Security Incident Response Team (PSIRT)*](appsec-operations/psirt-services.md).

### Shared Accountabilities & Collaborations

The Application Security team partners with several other teams across the Security Division to deliver end-to-end security solutions that work for GitLab engineers. The following strategic security programs have multiple stakeholders across the Security Division and company.

#### Supply Chain Security

Application Security's accountability is shared by both [SD&D](appsec-operations/sdd-services.md) and [PSIRT](appsec-operations/psirt-services.md). Additional Product Security teams involved in Supply Chain Security include [Security Platforms & Architecture](../security-platforms-architecture/), [Vulnerability Management](vulnerability-management.md), and [Infrastructure Security](../infrastructure-security/).

#### Dogfooding

Application Security's accountability is to use GitLab security products in our work and be participants in providing actionable Customer Zero feedback through the [Security Platforms & Architecture team](../security-platforms-architecture/), who is the Dogfooding DRI for Product Security.

#### Vulnerability Management

The Application Security Team's accountability is shared by both [SD&D](appsec-operations/sdd-services.md) and [PSIRT](appsec-operations/psirt-services.md). The [Vulnerability Management](../vulnerability-management/) is DRI for Vuln Management tooling development and implementation.

#### Secure by design

The Secure Design and Development Team's accountability is feature focused, assessing threats through [Threat Modeling](threat-modeling/_index.md) and [feature design reviews](appsec-reviews.md). (SDX: Design). The [Security Platforms & Architecture team](../security-platforms-architecture/) is DRI for Threat Modeling strategy company-wide, while AppSec is a critical stakeholder in this strategy.

#### Security Response

The [Product Security Incident Response Team's](appsec-operations/psirt-services.md) accountability is to triage and technically assesses critical and exploitable vulnerabilities, determine company and customer risk, and coordinate external communications regarding these issues.  PSIRT has several partners across the company including:

- [Security Operations](../../security-operations/) is DRI for Incident Command and Threat Detection (IOCs, TTPs)
- [Security Research](../../product-security/security-platforms-architecture/security-research/) is a key partner on exploitability and POC development
- [PR and Communications](../../../security/external-security-communications-procedure.md)
- [Legal](../../../legal/)
- [Delivery](../../../engineering/infrastructure-platforms/gitlab-delivery/delivery/)
- [Customer Support](../../../security/customer-support-operations/)

## Out of Scope

- [SBOM production](../../../security/security-assurance/security-compliance/sbom-plan/)
- Container Scanning
- [Customer Escalations regarding security scanner findings](../application-security/responding-customers-scan-review-requests.md)
- [Security Compliance](../../../security/security-assurance/)

## Contacting us

Team members can reach the AppSec team by:

- Finding your Stable Counterpart on the [Product sections, stages, groups, and categories](/handbook/product/categories/) page
- Mentioning `@gitlab-com/gl-security/product-security/appsec` on GitLab
- Submit an issue in the [AppSec Team repository](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/appsec-team/-/issues)
- Asking in `#sec-appsec` or mentioning `@appsec-team` on Slack
- For cross team collaboration improvement opportunities, use [this template for collaboration improvement opportunities](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/appsec-team/-/issues/new?issuable_template=cross-team-collaboration-improvement)

## FY26 Primary Focus Areas

In FY26, our key focus areas are:

**Organizational Upleveling:**

- Establish [Product Security Incident Response Team (PSIRT)](appsec-operations/psirt-services.md)
- Expand [Security Design & Development](appsec-operations/sdd-services.md) team services at scale

**Support [Company](../../../company/strategy.md) and [Division](../../../security/) Priorities:**

- Authorization & Authentication
- AI Security & Safety
- Supply Chain security
- [Security Interlock](../security-platforms-architecture/security-interlock/)

## FY26 Metrics

Application Security is rebuilding our operational business health metrics in FY26. These metrics are in addition to Key Risk Indicators, project-level metrics, or sub-team specific metrics. For many of these, metrics instrumentation and reporting mechanisms are still forthcoming. As the team matures, these metrics will evolve and be shared on this page.

## Learn more about AppSec services and resources

Please see the [Application Security Operations page](handbook/security/product-security/application-security/appsec-operations/appsec-ops-index/)

## Content Review and Updates

This charter will be reviewed quarterly to ensure alignment with company and divisional priorities, the GitLab Security product roadmap, and relevant business and operational changes. Updates may occur more frequently as business operations evolve.

*Next scheduled review: June 30, 2025*
