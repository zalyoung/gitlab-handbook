---
title: "Laptop Repairs"
---

**Any loss or damage must be reported to IT as soon as it occurs.**

If your laptop has been damaged, you must open an issue in the [End User Services Issue Tracker](https://gitlab.com/gitlab-com/it/end-user-services/issues/laptop-issue-tracker/-/issues/new?issuable_template=Laptop_Repair) to document what is broken. GitLab IT will be able to assess the damage and provide guidance on the most beneficial repair option.

## Repair options

In some regions, GitLab IT has an Apple certified vendor to perform repairs. At GitLab IT's discretion and vendor availability, the broken laptop may be sent to the vendor for repair. Our GitLab IT team can check if vendor support is available in your region. For minor repairs or when vendor support isn't an option, they may suggest visiting an Apple authorized service center in your area.

Estimates or quotes from an Apple authorized service center must be included in the issue before approval. Approval must be given by IT and your manager **prior** to any repair work being done. Either a picture or PDF are both acceptable and should include some identifying information about the laptop (Serial number, year, make, model). If the quote for the repair is less than $1,000 USD, and can be completed within a short time frame, GitLab IT may recommend/approve the Apple authorized service center to complete the work. If the repair is going to take longer than a day, make sure you have a back up laptop that uses an approved OS.

However, if the repair is going to be more than $1,000 USD and/or take too long to fix, GitLab IT may decide to replace the laptop. In those cases, a replacement laptop will be shipped out and the broken laptop collected to be repaired or recycled. Be advised, broken laptops do not qualify for the [Laptop Buyback Policy](/handbook/security/corporate/end-user-services/laptop-management/laptop-offboarding-returns/#laptop-buybacks) and will need to be returned to GitLab IT. Replacements for broken laptops may be used, but will be the same model of laptop (a performance model wouldn't be replaced by a standard model).

If IT confirms the laptop needs to be replaced, please create [an issue for the replacement](https://gitlab.com/gitlab-com/it/end-user-services/issues/laptop-issue-tracker/-/issues/new?issuable_template=Laptop_Replacement) and link it to the laptop repair issue.
When you receive the new laptop, please follow the guidelines in the replacement template.

## Process

#### Creating the Request

Before repairing, you must open an issue in the [End User Services Issue Tracker](https://gitlab.com/gitlab-com/it/end-user-services/issues/laptop-issue-tracker/-/issues/new?issuable_template=Laptop_Repair) to document the repair. Prior to the repairs being done, the issue must include the following:

- Include the quote for the cost of repairs
- Approval from an IT team member
- Your manager's approval

#### Getting a Quote

Take the MacBook to the Apple Store (or any authorized service center). You should ensure that you have a recent backup before doing so, and that your laptop is not your only registered device for iCloud two-factor authentication.

If the repair is less than `$1,000 USD`, follow the below process to repair and expense.

Please make sure to attach/include any estimates or receipts for the repair that you get from Apple (or any authorized service center) in the issue. Picture or PDF will work just fine.

Do not provide the repair center with any credentials to your laptop. If they ask, you can tell them that they're authorized to do a factory reset on the laptop should it be necessary to run diagnostics. This will help prevent sensitive data from being accidentally or intentionally leaked during repair.

If the repair is going to be greater than `$1,000 USD` and take several weeks to fix and you have no back up laptop, your best option is to replace the laptop. You can skip the steps blow and create a [laptop replacement issue](ttps://gitlab.com/gitlab-com/it/end-user-services/issues/laptop-issue-tracker/-/issues/new?issuable_template=Laptop_Replacement).

#### During the repair process

If the repair is going to take longer than a day and you are blocked for work. The IT team may have spares MacBooks to send to you. Please reach out to us in #it_help via Slack or in your created laptop repair issue so we can check if we are able to provide a loaner device

#### After the repair process

Once you receive your laptop back, [re-install MacOS](https://support.apple.com/en-us/102639) and restore your data from a recent backup. This is to ensure that no unauthorized software was added during the repair process. Make sure that your [disk is encrypted](/handbook/security/corporate/services/laptops/security/encryption) and you've reinstalled [Jamf for Mac](/handbook/security/corporate/systems/jamf/setup) or [DriveStrike for Linux](/handbook/security/corporate/systems/driverstrike/setup). Also, ensure that you have installed [SentinelOne](/handbook/security/corporate/systems/sentinelone/setup) in order to keep your laptop secure.