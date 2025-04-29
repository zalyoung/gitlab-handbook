---
title: "GitLab Internal Acceptable Use Policy"
description: "This policy specifies requirements related to the use of GitLab computing resources and data assets"
controlled_document: true
---

## Purpose

This policy establishes requirements for the secure use of GitLab computing resources and data assets. It protects our customers, Team Members, contractors, company, and partners from harm caused by misuse, whether deliberate or inadvertent.

Every Community member must follow these guidelines to maintain GitLab's security posture and protect our assets.

## Scope

**This policy applies to** all GitLab Team Members, contractors, advisors, and contracted parties interacting with GitLab systems or data.

**This policy covers:**
- Computing resources and equipment
- Company and customer data handling
- Mobile and tablet devices
- Removable and external storage media
- Acceptable and prohibited activities

## Roles & Responsibilities

| Role  | Responsibility |
|-----------|-----------|
| GitLab Team Members | Responsible for following the requirements in this procedure |
| Security, Legal and PeopleOps | Responsible for implementing and executing this procedure |
| Security, Legal and PeopleOps (Code Owners) | Responsible for approving significant changes and exceptions to this procedure |

## Quick Reference Guide

| Need | Action | Contact |
|------|--------|---------|
| **Report lost/stolen device** | Email [panic@gitlab.com](mailto:panic@gitlab.com) immediately | [Security Team](mailto:security@gitlab.com) |
| **Request policy exception** | Submit through [Security Compliance tracker](https://gitlab.com/gitlab-com/security-compliance/security-compliance/-/issues/new?issuable_template=policy_exception_request) | Security, Legal, and PeopleOps |
| **Software approval request** | Follow [Individual Use Software request process](/handbook/security/individual-use-software-process.html) | IT, Legal, and Security |
| **Data classification questions** | Consult [Data Classification Standard](/handbook/security/data-classification-standard/) | [Privacy Team](mailto:privacy@gitlab.com) |
| **Security consultation** | Create issue in [Security Compliance tracker](https://gitlab.com/gitlab-com/security-compliance/security-compliance) | [Security Team](mailto:security@gitlab.com) |
| **Personal device usage** | Submit [Policy Exception Request](/handbook/security/security-assurance/security-risk/policy-exceptions.html) | Security Team |
| **Required security tools** | Mac: Jamf<br>Linux: SentinelOne and DriveStrike | [IT Support](mailto:it@gitlab.com) |
| **External storage/media** | Contact Security for encrypted device recommendations | [Security Team](mailto:security@gitlab.com) |
| **Reporting policy violations** | Contact your manager or Security | [Security Team](mailto:security@gitlab.com) |

## Procedure

## Acceptable Use of GitLab Resources

GitLab provides computing resources primarily for business purposes. Limited personal use is permitted unless prohibited by your employment agreement. Key points:

- You are responsible for exercising good judgment when using GitLab resources
- All usage is subject to security monitoring and protection (unless prohibited by local laws)
- All GitLab data must be handled according to our [Data Classification Standard](#data-classification-standard)

### DO ✅
- ✅ Use GitLab resources primarily for business purposes
- ✅ Exercise good judgment when using company systems
- ✅ Keep your devices and software updated with security patches
- ✅ Report lost or stolen devices immediately to [panic@gitlab.com](mailto:panic@gitlab.com)
- ✅ Use Slack for all work-related communications
- ✅ Lock your computer when stepping away
- ✅ Report security concerns promptly

### DON'T ❌
- ❌ Share your credentials with others
- ❌ Disable security controls without approval
- ❌ Store RED data on personal devices
- ❌ Sign into GitLab accounts on public computers
- ❌ Forward confidential emails to personal accounts
- ❌ Attempt to bypass security measures

## Device Security Requirements

### Required for All Devices
- Provide device encryption evidence and serial number to IT Ops during onboarding
- Install required security software within your first week
- Maintain current operating system and security patches

### Mac-Specific Requirements
- All GitLab-provided Mac laptops come pre-configured with Jamf endpoint management
- Team Members expensing Mac laptops must install Jamf during Day 1 Security tasks
- CorpSec may install additional security tools via Jamf as needed

### Linux-Specific Requirements
- Must install SentinelOne and DriveStrike during first week onboarding

> **Note:** Detailed setup instructions can be found in your [Onboarding Issue](#onboarding-issue)

## Security and Software Management

### Data Security
- All GitLab data must be categorized according to the [Data Classification Standard](/handbook/security/data-classification-standard/)
- All computing assets connecting to GitLab networks or third-party services must comply with applicable standards
- [RED data](/handbook/security/data-classification-standard/#red) may not be transmitted from an approved source without prior approval from Privacy and Security teams

#### Open Source Libraries
- Permitted when complying with pre-approved or approval requirements in the [Product Legal Handbook](/handbook/legal/product-legal-handbook/)

#### Individual Use Software

**Definition:** Freeware, browser extensions, add-ons, and plugins for individual use

- **General Policy:**
  - Individual Use Software is permitted with exceptions noted below
  - May be retroactively removed if deemed unsafe by IT, Legal, or Security
   - Find authorized software on the [Pre-Approved Individual-Use Software list](/handbook/security/pre-approved-individual-use-software-list.html)
   - For new software approval, follow the [Individual Use Software request process](/handbook/security/individual-use-software-process.html)

- **Restrictions:**
  - Unauthorized Google Workspace integrations, Chrome extensions, and Slack integrations are prohibited. See **Third-Party Application Integrations** below.
  - Enterprise-level software exceptions are generally not granted if a Tech Stack alternative exists

#### Third-Party Application Integrations

Corporate Security maintains an application integration request workflow to ensure proper stakeholder visibility and review prior to configuring new integrations between managed environments. This process must be followed prior to allow-listing integrations with environments such as Google Workspace, Google Chrome, and Slack.

Integration requests can be entered [here](https://gitlab.com/gitlab-com/gl-security/corp/issue-tracker/-/issues/new?issue%5Btitle%5D=%5BSystem%20Name%5D%20Integration%20Request&description_template=application_integration_request). The Security, Privacy, and Legal teams will coordinate to ensure the transmission of data between these environments is lawful and appropriate based on the information shared.

#### Security Controls
- Security requirements for GitLab environments must not be disabled without approval via the [Information Security Policy Exception Management Process](/handbook/security/security-assurance/security-risk/policy-exceptions.html)

### Unacceptable Use

Team Members and contractors may **not** use GitLab-managed resources for activities that are illegal or prohibited under applicable law, no matter the circumstances.

Security requirements for GitLab production and corporate environments and on GitLab-managed assets must not be disabled without security approval via the [Information Security Policy Exception Management Process](/handbook/security/controlled-document-procedure/#exceptions).

## Unacceptable System and Network Activities

The following activities are prohibited when using GitLab systems or networks:

### Intellectual Property Violations
- Violating rights protected by copyright, trade secret, patent, or intellectual property laws
- Unauthorized copying, distribution, or use of copyrighted material
- Exporting software, technical information, encryption software, or technology in violation of export control laws

### Security Threats
- Intentionally introducing malicious programs into GitLab networks or devices
- Intentional misuse of GitLab devices (e.g., cryptocurrency mining, botnet control)
- Attempting to bypass, modify, disable, or tamper with security controls or logs
- Attempting to uninstall security controls without prior Security manager approval
- Circumventing user authentication or security of any system used by GitLab

### Access Violations
- Sharing your credentials with others or allowing others to use your account
- Intentionally accessing unauthorized data or logging into computers or accounts without permission
- Executing network monitoring that intercepts data not intended for your computer
- Tunneling between network segments or security zones (except when troubleshooting for GitLab)

### Data Handling and Tools
- Using screenshot tools with automatic upload features. Screenshots must be stored locally or in your GitLab Google Drive, following our [Access Management policy](/handbook/security/security-and-technology-policies/access-management-policy/) and [Data Classification Standard](/handbook/security/data-classification-standard/). Avoid tools like [Lightshot](https://app.prntscr.com/en/index.html) where uploads can't be disabled.
- Using high-risk remote administration tools (TeamViewer, AnyDesk) that are [frequently exploited by attackers](https://attack.mitre.org/techniques/T1219/).
- Using operating system emulators or compatibility layers like WINE
- Using torrent or P2P software on GitLab devices

### Workplace Conduct
- Using GitLab assets to procure or transmit material that violates harassment policies
- Making fraudulent offers originating from any GitLab account

#### Unacceptable Email and Communications Activities

Forwarding of confidential business emails or documents to personal external email addresses is prohibited. Automated forwarding of emails from a team member account is also prohibited.

> Note: GitLab may retrieve messages from archives and servers without prior notice if GitLab has sufficient reason to do so. If deemed necessary, this investigation will be conducted with the knowledge and approval of the Security, People Business Partners, and Legal Departments.

In addition to following the [Team Member Social Media Policy](/handbook/marketing/team-member-social-media-policy/), when utilizing social media think about the effects of statements that you make. Keep in mind that these transmissions are permanent and easily transferable, and can affect our company's reputation and relationships with Team Members and customers. When using social media tools like blogs, Facebook, Twitter or wikis, ensure that you do not make comments on behalf of GitLab without proper authorization. Also, you must not disclose our company's confidential or proprietary information about our business, our suppliers, or our customers.

### Return of GitLab-Owned Assets

All GitLab-owned computing resources must be [returned](/handbook/people-group/offboarding/#returning-property-to-gitlab) upon separation from the company.  Notwithstanding anything contrary in the [Laptop Buy Back Policy](/handbook/it/end-user-services/onboarding-access-requests/#laptop-buy-back-policy) or the [Offboarding Tasks](/handbook/people-group/offboarding/#managing-the-offboarding-tasks), Team Members must return any GitLab-Owned Assets -- irrespective of their valuation -- if they are specifically requested to do so either during their tenure with GitLab or upon offboarding. In cases of investigation, misconduct, termination for cause or any violation of [GitLab's Code of Business Conduct & Ethics](https://ir.gitlab.com/static-files/7d8c7eb3-cb17-4d68-a607-1b7a1fa1c95d), a team member has no right to retain GitLab-owned computing equipment.

## Bring-Your-Own-Device (BYOD) Policy

**General Rule:** Non-company devices are not permitted to access company assets. Access to [RED classified data](/handbook/security/data-classification-standard/) is prohibited in all cases.

### Permitted Exceptions

#### 1. Personal Mobile Devices
Mobile devices may access GitLab email and GitLab.com if:
- Device has passcode protection
- 2FA is enabled for GitLab.com and Google Workspace accounts
- Device runs the latest operating system with all security patches
- Contact the [Security Team](mailto:security@gitlab.com) with questions about device suitability

#### 2. Temporary Use of Personal Computers
Personal computers may be used temporarily only when:
- New employees haven't yet received a company laptop
- Corporate laptop is unavailable due to loss, theft, or repair

**Requirements:**
- Submit a [Policy Exception Request](/handbook/security/security-assurance/security-risk/policy-exceptions.html)
- Personal system must meet basic configuration standards
- Microsoft Windows systems are not permitted
- Never sign into GitLab accounts on public computers such as those in libraries or hotel kiosks.

## Mobile Messaging

### Acceptable Platforms

- **Primary:** All GitLab-related conversations must take place in Slack using the official [Slack application](https://slack.com/downloads/), or [Slack web application](https://slack.com/signin), available for [iOS](https://apps.apple.com/us/app/slack/id618783545) and [Android](https://play.google.com/store/apps/details?id=com.Slack&hl=en_US)
- **Secondary:** [Zoom](https://zoom.us/) for video calls and as a Slack alternative during meetings

### Important Considerations

- Avoid using integrated chat applications that combine multiple conversation platforms
- Using Slack exclusively helps maintain security, compliance, and proper incident response documentation
- For important video calls, consider recording the conversation for future reference

### Use of External Media on Company Assets

The use of removable and external storage devices such as USB flash drives and external backup drives on company-managed devices is not officially sanctioned. If there is a business need for the use of an external storage device, such as a flash drive or an external hard drive on company devices, please contact the Security Team to determine the most suitable encryption-enabled device. All external and removable storage devices must be encrypted and protected by a passcode.

As a reminder, Red Data may not be transmitted from an approved Red data source to any other systems or solutions without first obtaining approval from the Privacy and Security teams. Please refer to GitLab's [Data Classification Standard](/handbook/security/data-classification-standard/) for further details.

### Use of file sharing services other than GitLab's Google Drive

Creating an account or using for backup/redundancy purpose a file sharing service other than GitLab's Google Drive is prohibited. For sharing GitLab-related files with those external to GitLab, an exception must be granted. To obtain an exception create an [access request](/handbook/it/end-user-services/onboarding-access-requests/access-requests/) outlining the business case, and do not proceed until the exception has been granted.

When creating an account with and using a file sharing service other that Google Drive, Team Members must:

- Where available, use the `Sign in with Google` single sign-on option using a GitLab Google Workspace account, rather than creating an account using a GitLab (or other provider) email address and password.
- Only upload files directly to shared folders created by those external to GitLab and do not upload files to the personal area of the file sharing service.
- Remove all files and close the account when the file sharing service is no longer needed.

## Lost or Stolen Device Procedures

> **IMPORTANT:** If you lose a device containing credentials or GitLab data, act immediately using these procedures.

### Immediate Actions Required

1. **Report Immediately:** Send an email to [panic@gitlab.com](mailto:panic@gitlab.com) right away
2. **Include Details:** 
  - Type of device lost (laptop, phone, Yubikey, etc.)
  - When it was lost/stolen
  - What GitLab data or credentials it contained
  - Any actions you've already taken

### How This Process Works
- Emails to [panic@gitlab.com](mailto:panic@gitlab.com) are handled immediately by production and security teams
- This prompt reporting helps limit damage from lost devices containing credentials or sensitive data

### Documentation Requirements
- GitLab may request documentation of theft and/or a police report for stolen laptops
- Follow the complete [lost or stolen asset procedure](/handbook/security/lost-or-stolen-device-procedure/) for additional steps

### For Lost Access to Your Primary Device
- If you cannot access your primary device, follow the [Unable to Use Company Laptop](#unable-to-use-company-laptop) procedures

## Policy Compliance

### Monitoring and Enforcement
- Compliance with this policy is verified through:
 - Automated reporting
 - Regular audits
 - Feedback to policy owners
 - Security control effectiveness reviews

### Violation Consequences
- Any Team Member or contractor found in violation of this policy may face:
 - Disciplinary action
 - Up to and including termination of employment or contract
 - Potential legal consequences depending on the violation severity

### Reporting Concerns
- If you notice potential policy violations, report them to your manager or the [Security Team](#consultations)
- Whistleblower protections apply as outlined in the [Code of Business Conduct & Ethics](/handbook/legal/code-of-business-conduct-ethics/)

## Exceptions and Consultations

### Requesting Policy Exceptions
1. **When to Request:** Before taking any action that would violate this policy
2. **How to Request:** Submit an exception request through the [Security Compliance tracker](https://gitlab.com/gitlab-com/security-compliance/security-compliance/-/issues/new?issuable_template=policy_exception_request)
3. **Approval Process:**
  - Exceptions require joint approval from Security, Legal, and PeopleOps Departments
  - Temporary exceptions may be granted with an expiration date
  - All exceptions are documented and periodically reviewed

### Consulting with Security
- For security guidance or clarification about this policy:
 - Create an issue in the [Security Compliance tracker](https://gitlab.com/gitlab-com/security-compliance/security-compliance)
 - For urgent concerns, contact the [Security Team](mailto:security@gitlab.com) directly
 - Include details about your specific situation or question

### Regular Policy Reviews
- This policy is reviewed quarterly by Security, Legal, and PeopleOps
- Team Members can contribute suggested improvements by following the [handbook update process](/handbook/handbook-usage/#how-to-update-the-handbook)

## References

- GitLab's [Community Code of Conduct](https://about.gitlab.com/community/contribute/code-of-conduct/) applies to all members of the GitLab community
