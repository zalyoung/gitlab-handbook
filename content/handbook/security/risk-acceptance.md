---
title: Security Division Risk Acceptance Procedure
---

## Purpose

This procedure establishes a standardized risk acceptance process across all Security Division programs for risks that will be formally accepted rather than remediated or mitigated. This unified approach provides visibility into accepted risks, enables proper oversight, and supports regulatory compliance requirements.

## Scope

This procedure applies to security risk acceptance decisions across the following programs:

- **[Observation Management:](https://gitlab.com/gitlab-com/gl-security/security-assurance/security-compliance-commercial-and-dedicated/observation-management)** Security compliance observations that will be accepted rather than remediated
- **[Penetration Testing:](https://internal.gitlab.com/handbook/security/standards/penetration-testing-standard/)** Findings from penetration testing activities that will be accepted
- **[Third-Party Risk Management (TPRM):](https://handbook.gitlab.com/handbook/security/security-assurance/security-risk/third-party-risk-management/#tprm-security-notice-process)** Security notices documenting vendor security deficiencies that will be accepted
- **[Vulnerability Management:](https://gitlab.com/gitlab-com/gl-security/product-security/vulnerability-management/vulnerability-management-internal/vulnerability-management-tracker/-/issues/new)** Security vulnerabilities that will be permanently accepted

**Note:** This procedure covers only risks that will be `accepted`. Risks designated for remediation or mitigation are handled through separate program-specific workflows.

## Roles and Responsibilities

|Role | Responsibility|
|--|--|
|Risk Acceptance Requestor| Initiates risk acceptance request with proper justification and documentation|
|Program Review Team| Reviews risk acceptance requests, validates risk assessments, and maintains program-specific tracking|
|Security Risk Team| Maintains central risk acceptance register and provides oversight across all programsBusiness/System OwnerAccountable for risk acceptance decision and implementation of compensating controls|
|Department Leadership| Approves risk acceptance within their area of responsibility|
|Security Management| Provides final approval for high-risk acceptances and exceptions to this procedure|

### Program Review Team Assignments

|Source Program| Review Team| Primary Responsibility|
|--| --| --|
|Observation Management| Security Compliance Team| Review and validate observation risk acceptances|
|Penetration Testing| Security Compliance Team| Review and validate penetration test finding acceptances|
|TPRM Security Notices| Security Risk Team| Review and validate vendor security deficiency acceptances|
|Vulnerability Management| Vulnerability Management Team| Review and validate vulnerability risk acceptances|

## Risk Acceptance Categories

All risks processed through this procedure fall into one of these acceptance categories:

### 1. Accept with Compensating Controls (risktreat::accept-compensated)

- **Definition:** Risk is accepted with specific compensating controls in place to reduce exposure
- **Requirements:** Documented compensating controls and monitoring plan. Examples include:
  1. Alternative controls effectively mitigate risk exposure
  1. Defense-in-depth measures eliminate practical attack vectors
  1. Monitoring and detection provide adequate coverage

### 2. Accept as Low Risk (risktreat::accept-low)

- **Definition:** Risk is accepted due to very low impact and/or likelihood
- **Requirements:** Risk assessment justifying low risk determination. Examples include:
  1. Extremely low likelihood of exploitation
  1. Minimal impact if exploited
  1. Existing controls provide adequate protection

### 3. Accept Due to Constraints (risktreat::accept-constrained)

- **Definition:** Risk is accepted due to technical, operational, or business constraints that prevent remediation
- **Requirements:** Detailed constraint documentation and alternative control assessment. Examples include:
  1. Required fix would cause system instability or unavailability
  1. No viable technical solution exists
  1. Technology end-of-life with no upgrade path
  1. Critical business process would be severely disrupted
  1. Customer contractual obligations prevent modification
  1. Cost of remediation significantly exceeds risk value

### 4. Accept False Positive (risktreat::accept-false-positive)

- **Definition:** Reported risk is determined to be a false positive but cannot be eliminated from scanning/detection
- **Requirements:** Technical validation of false positive determination. Examples include:
  1. Alternative controls effectively mitigate risk exposure
  1. Defense-in-depth measures eliminate practical attack vectors
  1. Monitoring and detection provide adequate coverage
  1. Network segmentation isolates risk impact

## Risk Acceptance Process

### Step 1: Risk Acceptance Request Initiation

Who: Risk Acceptance Requestor (Business Owner, System Owner, or designated representative)

1. Complete risk acceptance request using appropriate issue template:

- Observation Management Risk Acceptance
- Penetration Testing Risk Acceptance
- TPRM Security Notice Risk Acceptance
- Vulnerability Risk Acceptance

1. Provide the following information:

- Risk Description: Detailed description of the security risk or finding
- Risk Rating: Current risk severity (Critical/High/Medium/Low)
- Acceptance Justification: Clear explanation of why acceptance is appropriate
- Acceptance Category: Select appropriate category from above
- Link assoicated issues: All relevent issues are linked
- Compensating Controls: Existing or planned controls that mitigate risk exposure (if applicable)
- Business Impact: Potential impact if risk is exploited
- Review Schedule: Proposed periodic review frequency

### Step 2: Program Review Team Review

Who: Appropriate Program Review Team member (see Program Review Team Assignments above)

1. Validate risk assessment and risk rating
1. Review acceptance justification for appropriateness
1. Assess proposed compensating controls for effectiveness (if applicable)
1. Determine appropriate approval level based on risk severity
1. Add recommendations and final risk acceptance category assignment
1. Relates the risk acceptance to relevant StORM risk(s)

#### Approval Authority Matrix

| Risk Severity| Program Review Team| Department Management| Director/VP| CISO|
|--|--|--|--| --|
| Low| :checkmark: Approve| - | -| -|
|Medium| Review and recommend| :checkmark: Approve| -| -|
|High| Review and recommend| Review | :checkmark: Approve| -|
|Critical| Review and recommend| Review | :checkmark: Approve| Notify|

### Step 3: Review and Approval

Who: Appropriate management level per approval matrix

1. Acknowledge understanding of accepted risk and potential impact
1. Confirm implementation of any required compensating controls
1. Accept accountability for ongoing risk monitoring and periodic review
1. Provide formal approval within designated authority level

### Step 4: Risk Acceptance Documentation

Who: Program Review Team

1. Apply appropriate risk acceptance labels
1. Set mandatory review dates based on risk level
1. Close original finding with acceptance documentation

#### Mandatory Review Schedule

For each periodic review, the risk acceptance must be repeated.

| Risk Level| Review Frequency| Review Team|
|--| --|--|
|Low and Medium| Annual| Program Review Team|
|High| Semi- Annual| Program Review Team + Security Risk Team|
|Critical| Quarterly| Program Review Team + Security Risk Team|

### Step 5: Periodic Review

Who: Program Review Team

1. Evaluate if original risk conditions still exist
1. Assess whether risk severity has changed
1. Review any changes to threat landscape or business environment
1. Confirm acceptance justification remains valid
1. Evaluate if remediation options have become available
1. Assess if risk severity has changed
1. Follow approval process based on the approval matrix

### Contact Information

For questions regarding this procedure, contact:

- Security Compliance Team (Observations & Penetration Testing): `@gitlab-com/gl-security/security-assurance/security-compliance-team`
- Security Risk Team (TPRM & Central Registry): `@gitlab-com/gl-security/security-assurance/security-risk-team`
- Vulnerability Management Team (Vulnerabilities): `@gitlab-com/gl-security/product-security/vulnerability-management`
- Slack Channel: `#security-discuss`
  - Security Compliance: `@sec-compliance-team`
  - Security Risk: `@security-risk`
  - Vulnerability Management: `@vulnerability-management`

## References

- [Observation Management Procedure](/handbook/security/security-assurance/observation-management-procedure/)
- [Penetration Testing Standard (internal only)](https://internal.gitlab.com/handbook/security/standards/penetration-testing-standard/)
- [Vulnerability Management](/handbook/security/product-security/vulnerability-management/)
- [Third-Party Risk Management Security Notices](/handbook/security/security-assurance/security-risk/third-party-risk-management/#tprm-security-notice-process)
