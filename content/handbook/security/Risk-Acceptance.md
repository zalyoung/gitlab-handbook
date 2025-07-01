# Purpose
This procedure establishes a standardized risk acceptance process across all Security Division programs for risks that will be formally accepted rather than remediated or mitigated. This unified approach provides visibility into accepted risks, enables proper oversight, and supports regulatory compliance requirements.

## Scope
This procedure applies to security risk acceptance decisions across the following programs:

- **Observation Management:** Security compliance observations that will be accepted rather than remediated
- **Penetration Testing:** Findings from penetration testing activities that will be accepted
- **Third-Party Risk Management (TPRM):** Security notices documenting vendor security deficiencies that will be accepted
- **Vulnerability Management:** Security vulnerabilities that will be permanently accepted

**Note:** This procedure covers only risks that will be `accepted`. Risks designated for remediation or mitigation are handled through separate program-specific workflows.

## Roles and Responsibilities

|Role | Responsbility|
|--|--|
|Risk Acceptance Requestor| Initiates risk acceptance request with proper justification and documentation|
|Program Review Team| Reviews risk acceptance requests, validates risk assessments, and maintains program-specific tracking
|Security Risk Team| Maintains central risk acceptance register and provides oversight across all programsBusiness/System OwnerAccountable for risk acceptance decision and implementation of compensating controls|
|Department Leadership| Approves risk acceptance within their area of responsibility|
|Security Management| Provides final approval for high-risk acceptances and exceptions to this procedure|

### Program Review Team Assignments:

|Source Program| Review Team| Primary Responsibility|
|--| --| --|
|Observation Management| Security Compliance Team| Review and validate observation risk acceptances|
|Penetration Testing| Security Compliance Team| Review and validate penetration test finding acceptances|
|TPRM Security Notices| Security Risk Team| Review and validate vendor security deficiency acceptances|
|Vulnerability Management| Vulnerability Management Team| Review and validate vulnerability risk acceptances|

## Risk Acceptance Categories
All risks processed through this procedure fall into one of these acceptance categories:

#### 1. Accept with Compensating Controls (risk treatment::accept compensated)

- **Definition:** Risk is accepted with specific compensating controls in place to reduce exposure
- **Duration:** Permanent acceptance with mandatory periodic review
- **Requirements:** Documented compensating controls and monitoring plan. Examples include:
    - Alternative controls effectively mitigate risk exposure
    - Defense-in-depth measures eliminate practical attack vectors
    - Monitoring and detection provide adequate coverage

#### 2. Accept as Low Risk (risk treatment::accept low-risk)

- **Definition:** Risk is accepted due to very low impact and/or likelihood
- **Duration:** Permanent acceptance with standard periodic review
- **Requirements:** Risk assessment justifying low risk determination. Examples include:
    - Extremely low likelihood of exploitation
    - Minimal impact if exploited
    - Existing controls provide adequate protection

#### 3. Accept Due to Constraints (risk treatment::accept constrained)

- **Definition:** Risk is accepted due to technical, operational, or business constraints that prevent remediation
- **Duration:** Permanent acceptance with mandatory annual review
- **Requirements:** Detailed constraint documentation and alternative control assessment. Examples include:
   - Required fix would cause system instability or unavailability
   - No viable technical solution exists
   - Technology end-of-life with no upgrade path
   - Critical business process would be severely disrupted
   - Customer contractual obligations prevent modification
   - Cost of remediation significantly exceeds risk value

#### 4. Accept False Positive (risk treatment::accept false-positive)

- **Definition:** Reported risk is determined to be a false positive but cannot be eliminated from scanning/detection
- **Duration:** Permanent acceptance with monitoring for scan configuration changes
- **Requirements:** Technical validation of false positive determination. Examples include:
   - Alternative controls effectively mitigate risk exposure
   - Defense-in-depth measures eliminate practical attack vectors
   - Monitoring and detection provide adequate coverage
   - Network segmentation isolates risk impact

## Risk Acceptance Process

### Step 1: Risk Acceptance Request Initiation
Who: Risk Acceptance Requestor (Business Owner, System Owner, or designated representative)

1. Complete risk acceptance request using appropriate issue template:

  - Observation Management Risk Acceptance
  - Penetration Testing Risk Acceptance
  - TPRM Security Notice Risk Acceptance
  - Vulnerability Risk Acceptance


2. Provide the following information:

  - Risk Description: Detailed description of the security risk or finding
  - Risk Rating: Current risk severity (Critical/High/Medium/Low)
  - Acceptance Justification: Clear explanation of why acceptance is appropriate
  - Acceptance Category: Select appropriate category from above
  - Compensating Controls: Existing or planned controls that mitigate risk exposure (if applicable)
  - Business Impact: Potential impact if risk is exploited
  - Review Schedule: Proposed periodic review frequency

### Step 2: Program Review Team Review
Who: Appropriate Program Review Team member (see Program Review Team Assignments above)

- Validate risk assessment and severity rating
- Review acceptance justification for appropriateness
- Assess proposed compensating controls for effectiveness (if applicable)
- Determine appropriate approval level based on risk severity
- Add recommendations and final risk acceptance category assignment

#### Approval Authority Matrix:

| Risk Severity| Program Review Team| Department Management| Director/VP| CISO|
|--|--|--|--| --|
| Low| :checkmark: Approve| - | -| -|
|Medium| Review and reccomend| :checkmark: Approve| -| -|
|High| Review and reccomend| Review | :checkmark: Approve| -|
|Critical| Review and reccomend| Review | :checkmark: Approve| Notify|

### Step 3: Review and Approval
Who: Appropriate management level per approval matrix

- Acknowledge understanding of accepted risk and potential impact
- Confirm implementation of any required compensating controls
- Accept accountability for ongoing risk monitoring and periodic review
- Provide formal approval within designated authority level

### Step 4: Risk Acceptance Documentation
Who: Program Review Team

- Apply appropriate risk acceptance labels
- Set mandatory review dates based on risk level
- Close original finding with acceptance documentation

#### Mandatory Review Schedule
For each perodic review, the risk acceptance must be repeated.

| Risk Level| Review Frequency| Review Team|
|--| --|--|
|Low| Bi-annual| Program Review Team|
|Medium| Annual| Program Review Team|
|High| Semi- Annual| Program Review Team + Security Risk Team|
|Critical| Quarterly| Program Review Team + Security Risk Team|


### Step 5: Periodic Review
Who: Program Review Team

- Evaluate if original risk conditions still exist
- Assess whether risk severity has changed
- Review any changes to threat landscape or business environment
- Confirm acceptance justification remains valid
- Evaluate if remediation options have become available
- Assess if risk severity has changed
- Follow approval process based on the approval matrix

### Contact Information
For questions regarding this procedure, contact:

- Security Compliance Team (Observations & Penetration Testing): `@gitlab-com/gl-security/security-assurance/security-compliance-team`
- Security Risk Team (TPRM & Central Registry): `@gitlab-com/gl-security/security-assurance/security-risk-team`
- Vulnerability Management Team (Vulnerabilities): `@gitlab-com/gl-security/product-security/vulnerability-management`
- Slack Channel: `#sec-assurance-team`

## References

- [Observation Management Procedure](/handbook/security/security-assurance/observation-management-procedure/)
- [Penetration Testing Standard (internal only)](https://internal.gitlab.com/handbook/security/standards/penetration-testing-standard/)
- [Vulnerability Management](/handbook/security/product-security/vulnerability-management/)
- [Third-Party Risk Management Security Notices](/handbook/security/security-assurance/security-risk/third-party-risk-management/#tprm-security-notice-process)

