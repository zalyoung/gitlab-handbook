# Trust & Safety Team Frequently Asked Questions

## Overview

{{% note %}}
This page provides guidance for users experiencing account issues, reporting abuse, or seeking information about GitLab's Trust & Safety policies. If your account has been blocked or restricted, don't worry - most issues can be resolved by following the appropriate steps below.
{{% /note %}}

## Need immediate help? Jump to the section that matches your situation:

{{% note theme="info" %}}
- [Account Blocks and Reinstatements](#account-blocks-and-reinstatements)
- [Intellectual Property Issues](#intellectual-property-issues)
- [Using VPNs and TOR](#using-vpns-and-tor)
- [Reporting Abuse and Spam](#reporting-abuse-and-spam)
- [Security Research and Testing](#security-research-and-testing)
- [Namespace Disputes](#namespace-disputes)
{{% /note %}}

---

## Account Blocks and Reinstatements

### My account was blocked - how do I get it back?

If you see the "Account Blocked" message when trying to access your account, follow these steps to request reinstatement.

#### Why didn't I receive a notification about my account block?

GitLab generally does not proactively notify users when accounts are blocked. In most cases, you'll discover the block when attempting to access your account. To find out what corrective actions are needed for reinstatement, you'll typically need to submit a support ticket as outlined below.

**However, there are some exceptions where you may receive email notification:**
- **Intellectual property takedowns:** If your account was blocked due to not responding to a DMCA or trademark takedown request within the required 24-hour period, check the primary email address registered on your GitLab.com account. You should find details about the intellectual property complaint and information about submitting a counter-claim if you believe the takedown was invalid.
- **Service stability issues:** Occasionally, GitLab support may contact users directly when account activity significantly impacts GitLab.com's availability and stability. This is not done in all instances, so if you don't see any communication, proceed with opening a support ticket.

**Important:** Always check your spam/junk folder as email providers sometimes mark GitLab communications as potential spam.

If you haven't received any email notifications, or if the information provided doesn't fully address your situation, the support ticket process below will provide specific guidance for your account.

#### Important notes about account blocks:

- **New account blocks:** Accounts blocked immediately after signing up are often flagged by automated security measures that detect specific patterns matching suspicious activity.
- **Multiple accounts:** Creating additional accounts to circumvent a block violates our Terms of Service and may result in permanent restrictions. Always work with our support team to resolve the original account issue.

#### How do I find out why my account was blocked and what I can do about it?

**Step 1: Access GitLab Support**
1. Go to [GitLab Global Support](https://support.gitlab.com/hc/en-us)
2. Click on `Submit a ticket`

**Step 2: Login to Support Portal**

**Important:** Support portal login details are **different** from your GitLab.com account
- **Your GitLab.com account block does NOT affect your ability to submit support requests** - the support portal is completely separate
- If you don't have a support portal account, you'll need to create a new one
- Use an email address you can access (may be different from your blocked GitLab account email)

**Step 3: Submit Your Request**
1. Click on `Submit a Request`
2. Complete the form with the following details:

**Required Form Fields:**
- **GitLab Subscription:** Select "Free user" (or your subscription type)
- **Problem Type:** Select "Cannot access account"
- **What specifically do you need help with?:** Select "GitLab says my user is blocked"
- **Which email address is being impacted?:** Enter the email associated with your blocked GitLab account
- **GitLab.com Username:** Enter your blocked username (without the @ symbol)
- **Ticket Severity:** Select "Severity 4 - Questions or clarifications"
- **Priority:** Select "Low"
- **Preferred Region for Support:** Choose your preferred support region

**In the Description field, include:**
- Clear statement that your account is blocked
- Your GitLab username
- Any error messages you received
- Why you believe the block may have occurred
- Any additional context that might help with the review

**Step 4: Submit and Wait**
1. Attach any relevant screenshots if helpful
2. Click `Submit` to send your request
3. **Wait for review** - Our support team typically responds within 1-2 business days

**Note for Free users:** Free GitLab accounts may experience longer response times than paid accounts

**Important:** The support team serves as your point of contact but does not make reinstatement decisions. Reviews are conducted by our Security team and other specialized teams depending on the nature of the block.

**Step 5: Follow Up**
- **Provide additional information if requested** - The reviewing teams may need more details
- **Be prepared to provide detailed account activity information** - You should expect requests for comprehensive information about your account usage, projects, and activities to ensure a thorough review process
- **Provide accurate and complete information** - Submit only truthful and detailed information. Submitting incorrect or false information could result in your request being denied
- Respond promptly to any requests for clarification to avoid delays
- **Note:** GitLab may not provide detailed reasons for account blocks due to security considerations
- **Do not submit multiple requests** - This will not expedite your case and may actually slow down the review process
- **Use official channels:** While it's natural to want to reach out to friends or former colleagues at GitLab, the support ticket system is the most effective way to ensure your request reaches the right team quickly
- **For priority escalation:** If your organization has a dedicated contact person at GitLab, you can reach out to them to discuss potential paths for prioritizing your request

**Important:** While providing detailed and accurate information helps ensure a quick and thorough review process, account reinstatement is not guaranteed.

{{% details summary="What are the most common reasons accounts get blocked?" %}}
- Engaging in, promoting, or encouraging illegal or malicious activity
- Violating the privacy of others or misusing personal data of other users
- Harassment, discrimination, threats, or other harmful behavior toward individuals or groups
- Using our services in a deceptive or fraudulent manner, impersonating others, or falsely implying endorsement
- Compromising, overburdening, or otherwise impairing our services or those of others
- Interfering with security or integrity of systems, or seeking unauthorized access
- Transmitting spam or undertaking phishing
- Creating, uploading, or hosting content that is vulgar, obscene, pornographic, or gratuitously violent
- Violating the GitLab Community Code of Conduct
- Using the Website to mine or demonstrate proof-of-work for cryptocurrency or blockchain
- Intellectual property violations (copyright, trademark infringement, DMCA anti-circumvention violations)
- Unusual login patterns or suspicious account activity triggering automated security measures
{{% /details %}}

---

## Intellectual Property Issues

{{% details summary="I received a DMCA takedown notice" %}}
If you've been notified that your namespace has been targeted in an intellectual property takedown request:

**Your options:**
1. **Remove the content** - If you choose to remove the content rather than dispute the claim:
   - You must respond to the email from GitLab confirming your agreement to remove the infringing content
   - Your account block will be lifted after you respond to allow content removal
   - GitLab does not remove content on users' behalf - you must perform this action yourself
   - Complete removal must be done within 24 hours of account reinstatement to avoid being blocked again
   - **Important:** Simply privatizing repositories is not sufficient - complete deletion of infringing content is required
   - This includes removing content from all branches, commit history, and any forks under your control

2. **Submit a counter-notice** - If you believe the claim is invalid, you can challenge it
   - Visit our [Intellectual Property Policy page] for counter-notice requirements
   - Counter-notices must include specific legal information and your contact details
   - False counter-notices may have legal consequences
   - Your account will remain blocked during the counter-notice process
   - **Be prepared to provide detailed information** about your account activity and the disputed content. Submitting accurate and complete information helps ensure a thorough review, though reinstatement is not guaranteed

**What happens next:**
- If you remove content: We'll review and may reinstate your account
- If you submit a counter-notice: The original claimant has 10-14 days to respond with legal action
- If no legal action is taken: We'll restore the content per DMCA requirements
{{% /details %}}

{{% details summary="My account was blocked due to a trademark issue" %}}
**Your options:**
1. **Provide proof of rights** - Submit documentation showing you have legitimate rights to use the trademark
2. **Remove the trademark content** - Agree to remove or modify the infringing content
3. **Challenge the claim** - If you believe the trademark claim is invalid, provide your reasoning and supporting evidence

**Required documentation may include:**
- Trademark registration certificates
- Licensing agreements
- Proof of prior use
- Legal opinion letters
{{% /details %}}

{{% details summary="How does GitLab handle intellectual property disputes?" %}}
**Copyright (DMCA):** We follow the Digital Millennium Copyright Act process, including takedown notices and counter-notices.

**Trademark disputes:** These are handled case-by-case. We may remove content if there's clear trademark infringement, but we don't arbitrate disputes between parties.

**Important:** GitLab will not take action without proper legal documentation. Disputes between parties must be resolved independently or through appropriate legal channels.
{{% /details %}}

---

## Using VPNs and TOR

{{% details summary="Can I use a VPN to access my account?" %}}
While VPN usage is not prohibited, it is **strongly discouraged** as it frequently triggers our security systems and may result in account blocks or platform access issues.

**Particularly problematic scenarios:**
- Frequently switching between different VPN servers
- Using VPNs from countries with trade restrictions
- VPN services associated with malicious activity
- Shared VPN exit points with high abuse rates

{{% note theme="warning" %}}
**Important:** If your account is blocked due to VPN usage appearing to originate from regions covered by the Personal Information Protection Law of the People's Republic of China (PIPL), including mainland China, Hong Kong, and Macau, GitLab may not be able to restore your account for legal reasons, which could result in irreversible consequences.
{{% /note %}}

**Recommendation:** For the best GitLab experience and to avoid potential account issues, use standard internet connections without VPN services whenever possible.
{{% /details %}}

{{% details summary="Can I use TOR to access GitLab?" %}}
**Why TOR causes problems:**
- TOR exit nodes are frequently associated with malicious activity
- Our security systems actively monitor and restrict TOR traffic
- High likelihood of triggering automated account blocks
- Severely degraded platform performance and functionality
- Potential conflicts with our Terms of Service regarding service stability

**Our recommendation:** Do not use TOR to access GitLab. Use standard internet connections for reliable access to the platform.

If your account was blocked while using TOR, submit a support ticket, though reinstatement is not guaranteed depending on other factors involved.
{{% /details %}}

---

## Reporting Abuse and Spam

### How to report abusive behavior

There are multiple ways to report abuse, spam, and inappropriate behavior on GitLab.com. Choose the method that best fits your situation:

**Quick reporting options through GitLab's interface:**

{{% details summary="How do I report a user profile?" %}}
You can report abuse directly from any user's profile page.

**Steps:**
1. Navigate to the user's profile page
2. In the upper-right corner of the user's profile select the vertical ellipsis (⋯), then select "Report abuse"
3. Select a reason for reporting the user from the dropdown menu
4. Complete the abuse report form with detailed information
5. Click "Send report"

**Note:** Reports with insufficient information cannot be reviewed and will therefore be closed. More detailed reports can be sent to abuse@gitlab.com.
{{% /details %}}

{{% details summary="How do I report comments, issues, or merge requests?" %}}
You can report abusive content directly from comments, issues, and merge requests using the "Report abuse" option.

**For Comments:**
1. In the comment, in the upper-right corner, select "More actions" (⋯)
2. Select "Report abuse"
3. Select a reason for reporting
4. Complete the abuse report form
5. Click "Send report"

**For Issues:**
1. On the issue, in the upper-right corner, select "Issue actions" (⋯)
2. Select "Report abuse"
3. Complete the form and submit

**For Merge Requests:**
1. On the merge request, in the upper-right corner, select "Merge request actions" (⋯)
2. Select "Report abuse"
3. Complete the form and submit

A URL to the reported content is automatically pre-filled in the abuse report's Message field.
{{% /details %}}

{{% details summary="How do I report snippets?" %}}
You can report abusive or spam snippets directly from the snippet page.

**Steps:**
1. Navigate to the problematic snippet
2. Look for the report option (typically in the upper-right corner or actions menu)
3. Select "Submit as spam" if reporting spam content
4. Complete the report form

GitLab forwards spam reports to Akismet for processing.
{{% /details %}}

{{% note theme="success" %}}
**For detailed or complex reports:** Email `abuse@gitlab.com` with:
- Specific GitLab URLs of the problematic content
- Detailed description of the abuse type
- Any relevant screenshots or evidence
- Multiple accounts/URLs if reporting coordinated abuse
{{% /note %}}

### Types of behavior to report

{{% details summary="What should I report?" %}}
Report behavior and content that violates GitLab's community guidelines and terms of service.

**Definitely report:**
- Distributing harmful or offensive content that is defamatory, obscene, abusive, an invasion of privacy (Personally Identifiable Information/PII) or harassing
- The use of sexualized language or imagery and unwelcome sexual attention or advances
- Trolling, insulting/derogatory comments, and personal or political attacks
- Public or private harassment
- Publishing others' private information, such as a physical or electronic address, without explicit permission
- Spam comments, issues, or projects
- Copyright content of which the account holder does not hold the rights to distribute
- Impersonation of other users or organizations
- Malicious software that is designed and distributed with the intention of causing damage to a computer, server, client, or computer network
- An account that has been created for the purpose of distributing spam in the form of advertising a product, service, item etc.
- Coordinated abuse campaigns

{{% note theme="warning" %}}
**Special reporting for CSAM:** Reports of Child Sexual Abuse Material (CSAM) should be reported to INHOPE via the "Report it!" option (follow the steps outlined on the site to submit a report).
{{% /note %}}
{{% /details %}}

{{% details summary="What happens after I report abuse?" %}}
GitLab administrators review abuse reports and can take several actions.

**Possible outcomes:**
- Content removal
- Account restrictions or blocking - blocked users cannot sign in, though they may still access public repositories without logging in

**Review process:**
- Our Security team reviews all reports
- Action is taken based on the severity and evidence provided
- For privacy reasons, specific actions taken against other users are not always disclosed

{{% note theme="warning" %}}
**Important:** Submitting false or malicious reports may result in action against your own account.
{{% /note %}}
{{% /details %}}

{{% details summary="Security Research and Testing on GitLab.com" %}}
Security research on GitLab.com is allowed under specific conditions. **All security researchers must follow our HackerOne Rules of Engagement.**

**Requirements for security research:**
- You must use only test accounts - never target other users' private information
- Your `@wearehackerone.com` address must be associated with your testing GitLab.com account
- Follow all [HackerOne Rules of Engagement](https://hackerone.com/gitlab) at all times
- Do not perform disruptive activities that negatively affect GitLab's users or operations

**Prohibited activities include:**
- Generating abusive requests including API requests
- Accessing private information of other users
- Spam or denial of service attacks
- Any activity disruptive to GitLab operations

**Note:** Having a HackerOne association does not provide immunity from account restrictions if you violate our terms.

**Recommendation:** For comprehensive security testing, use your own GitLab installation. GitLab is open-source and available at gitlab.com/gitlab-org/gitlab-foss and gitlab.com/gitlab-org/gitlab.
{{% /details %}}

{{% details summary="Hosting Malware for Research Purposes" %}}
Making use of GitLab.com services to deliver malicious executables or as attack infrastructure is prohibited under the GitLab Website Terms of Use. However, hosting malware for legitimate research purposes is allowed if specific criteria are met.

**Requirements for research malware hosting:**
- **Clear documentation required:** The Group and Project descriptions must clearly describe the purpose and author of the content
- **Detailed README.md file:** Must include specific project content that can be independently verified by the GitLab Security department
- **Supporting materials:** Include links to supporting materials such as research papers, blog posts, or academic references
- **Research purpose only:** Content must be clearly intended for research and educational purposes
- **Not publicly accessible:** Malware should not be made easily available to the public where it could be misused

{{% note theme="warning" %}}
**Important:** Projects that do not meet these criteria or appear to be hosting malware for malicious purposes will result in account blocks and content removal. Users blocked for malware research violations may be required to submit extensive and technical information about their project for evaluation during the reinstatement process.
{{% /note %}}
{{% /details %}}

{{% details summary="CI/CD Infrastructure Abuse" %}}
Misusing GitLab's CI/CD infrastructure can result in account blocks and is prohibited under our Terms of Service.

**Examples of CI/CD abuse include:**
- Using CI/CD runners for cryptocurrency mining
- Running excessive or unnecessary computational workloads
- Using CI/CD infrastructure for purposes unrelated to software development
- Generating excessive API requests or system load
- Circumventing usage limits or fair use policies
- Using CI/CD resources for commercial purposes outside of legitimate software development

{{% note theme="warning" %}}
**Terms of Service Reference:** Such activities violate our Terms of Service regarding responsible use of GitLab resources and can result in immediate account suspension or permanent blocking.
{{% /note %}}

**Fair use:** GitLab's CI/CD infrastructure is provided for legitimate software development, testing, and deployment activities. Users should ensure their usage aligns with these intended purposes.
{{% /details %}}

{{% details summary="Someone is using my copyright work, what should I do?" %}}
If someone is using your copyrighted material without permission on GitLab:

Visit our [Intellectual Property Policy page] for complete DMCA notice requirements and process details.

**Reporting options:**
1. **Submit a DMCA notice** to `dmca@gitlab.com`
2. **Use the Report Abuse button** - You can also report copyright infringement directly through the platform using the "Report abuse" button on user profiles, comments, issues, or merge requests

**Have this information ready before submitting a DMCA claim:**
- Your contact information
- Description of the copyrighted work
- Location of the infringing content (specific GitLab URLs)
- Statement of good faith belief
- Statement of accuracy under penalty of perjury
- Your physical or electronic signature

**Note:** You do not need a GitLab.com account to submit copyright infringement claims.
{{% /details %}}

{{% details summary="How does GitLab treat Copyright or Trademark requests?" %}}
**Copyright (DMCA):** We follow the Digital Millennium Copyright Act process, including takedown notices and counter-notices.

**Trademark disputes:** These are handled case-by-case. We may remove content if there's clear trademark infringement, but we don't arbitrate disputes between parties.

**Important:** GitLab will not take action without proper legal documentation. Disputes between parties must be resolved independently or through appropriate legal channels.
{{% /details %}}

---

## Security Research and Testing

{{% details summary="Can I host security research tools?" %}}
{{% note theme="success" %}}
**Generally allowed if:**
- The tools are for legitimate research purposes
- They benefit the security community
- Content meets our Abuse Policy criteria
- You're not using GitLab as attack infrastructure
{{% /note %}}

{{% note theme="warning" %}}
**Not allowed:**
- Hosting malicious executables
- Using GitLab to deliver malware
- Storing tools intended for malicious attacks
{{% /note %}}

**Best practice:** Include clear documentation explaining the research purpose and ethical use of your tools.
{{% /details %}}

{{% details summary="Can I perform security testing on GitLab?" %}}
**Limited testing is permitted with restrictions:**

**Requirements:**
- Use only test accounts (never target other users' data)
- Associate your `@wearehackerone.com` email with your testing account
- Follow our [HackerOne Rules of Engagement](https://hackerone.com/gitlab?type=team)
- Respect other users' privacy and platform stability

**Prohibited activities:**
- Port scanning
- Intrusion attempts
- Denial of service attacks
- Accessing other users' private information
- Any activity that disrupts GitLab operations

**Recommended approach:** Install your own GitLab instance for comprehensive testing. GitLab is open source and available at:
- Community Edition: `https://gitlab.com/gitlab-org/gitlab-foss`
- Enterprise Edition: `https://gitlab.com/gitlab-org/gitlab`

**Note:** HackerOne association doesn't provide immunity from account restrictions if you violate our terms.
{{% /details %}}

---

## Namespace Disputes

{{% details summary="Can I claim an existing namespace?" %}}
**GitLab namespace policy:**
- Namespaces are available on a **first-come, first-served basis**
- No reservations are made for brands, companies, or trademarks
- Owning a trademark doesn't grant rights to the corresponding namespace
- Example: Owning "GreatCompany" trademark doesn't mean you can claim `gitlab.com/GreatCompany`

**Dispute resolution:**
- Namespace disputes must be resolved between the parties involved
- GitLab Support cannot arbitrate or mediate these disputes
- We only take action when presented with appropriate legal orders
- Consider using alternative namespaces or contacting the current owner directly

{{% note theme="info" %}}
**Exceptions:** We may intervene in cases of clear impersonation or trademark infringement with proper legal documentation.
{{% /note %}}
{{% /details %}}

---

{{% note theme="info" class="contact-section" %}}
## Getting Additional Help

**Still need assistance?** Contact us through:
- **General support:** [GitLab Support Portal](https://support.gitlab.com/hc/en-us/requests/new)
- **Abuse reports:** `abuse@gitlab.com`
- **Copyright issues:** `dmca@gitlab.com`
- **Security research:** Follow our [HackerOne program](https://hackerone.com/gitlab)

*Remember: Most account issues can be resolved through our standard support channels. Provide detailed information in your initial request to help us assist you more quickly.*
{{% /note %}}