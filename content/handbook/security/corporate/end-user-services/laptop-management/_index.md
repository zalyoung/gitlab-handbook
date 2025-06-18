---
title: "GitLab Laptop Management"
---

## Introduction

The EUS team oversees all laptop procurement and management. While certain aspects, such as endpoint management yools configurations, are supported by other parts of the CorpSec team, we generally act as the point of contact for all related issues.

At GitLab, we use centralized laptop management for company issued devices. If you are in possession of a company issued laptop, the details below apply to you. However, not all endpoint management technologies GitLab deploys will be required for Apple, Linux, and Windows laptops. Some technologies may be specific to the hardware platform or operating system.

## Laptop Specs

GitLab approves and supports the use of Linux and Apple's macOS as the OS for employee laptops. To keep GitLab IT Support efficient, Windows is not supported as a hardware laptop OS.

Further information on GitLab authorized operating systems, versions, and exception process is available on the [Approved Operating Systems for GitLab Team Member Endpoint Systems](https://internal.gitlab.com/handbook/security/corporate/operating-systems/) page.

The operating system choices have obviously affected the hardware selection process.

Apple hardware is the common choice among GitLab team members. Team members may also select a Dell Linux laptop if they are familiar with Linux and capable of self-support, as long as they are using an approved operating system.

### Apple Hardware

We aim to provide the most up-to-date hardware for all laptop orders. However, while the exact specs will vary based on availability, we guarantee the below at a minimum:

* MacBook Pro 14-inch - 16GB Unified memory / 512GB storage  **Standard model**
* MacBook Pro 16-inch - 36GB Unified memory / 1TB storage **Performance model**
* MacBook Pro 14-inch - 36GB Unified memory / 1TB storage **Performance model**

Most roles that require higher performance machines are approved for a 14" or 16" MacBook Pro performance model. Please see this [spreadsheet](https://docs.google.com/spreadsheets/d/1OuC0_iliCzASKfOhDLWO4fBmDS-uL3VGRMI6063R6tk/edit?usp=sharing) (public) to locate your department group and determine which machine you are eligible for.

### Linux Hardware

{{% alert color="warning" %}}
IT strongly encourages team members to select Macs; please only request a Linux laptop if you are experienced in Linux and capable of self-support.
{{% /alert %}}

**Below are roles that qualify for Linux Laptops**

* Engineers, Support Engineers, Data Analysts, Technical Marketing Managers, Product Designers, UX Managers, Product Managers, Technical Writers, and Digital Production are eligible for Dell Precision Mobile Workstation laptops from the 5690 line. Due to supply constraints, specific models available from these lines may vary. EUS will work with each person to find an available model meeting at least the following specifications: 

- 16" Display
- Intel i9 CPU or equivalent
- 512GB SSD
- 32GB Memory

\*\*NOTE: The maximum price of Linux laptops is not to exceed **the price of the equivalent [16" MacBook Pro laptop](#apple-hardware)**. Please make sure you order this model a minimum of 14 days, based on your locality, prior to your desired date to receive.

Our **only approved Linux laptop vendor at this time is Dell**. These laptops generally come pre-loaded with Ubuntu Linux in order to save money on unused Windows licenses.

Dell is GitLab's exclusive Linux vendor for the following reasons:

* Dell has the longest history of shipping laptops with Linux pre-installed among major manufacturers.
* Dell is able to ship laptops to all countries in which GitLab employees live.
* As we move forward with Zero Trust networking solutions, we need to have a stable and unified platform for deployment of software components in the GitLab environment.
    Standardization on a single platform for Linux simplifies this.
* The current Ubuntu LTS is the preferred Linux platform; Ubuntu LTS has a record of stability and quick patching.
* Purchasing laptops from a single vendor opens the possibility of corporate discounts.
* [Dell is a certified Ubuntu vendor](https://certification.ubuntu.com/desktop/models?query=&category=Desktop&category=Laptop&level=&release=18.04+LTS&vendors=Dell) with multiple laptop choices available. They even have their own Ubuntu OEM release of Ubuntu they maintain, and as a result of their effort, the standard Ubuntu Linux 20.04 LTS image natively supports Dell hardware and even firmware updates.
* To date, all of Dell's major security issues have not been related to their hardware.

### Windows for Customer Support and Product Development

While GitLab limits the Laptop Hardware OSes supported for team member daily work, specific roles will need to use Windows for Customer Support and Product Development to ensure excellent platform and ecosystem support for GitLab customers and partners who develop for the Microsoft Ecosystem.

Microsoft Windows Professional (Desktop OS) and Windows Server may need to be used by some technical roles for supporting GitLab customer usage of Windows and developing GitLab software. These editions can be used for support and development purposes using virtualization or cloud instances and are self-supported and must be in compliance with [all endpoint policies](https://internal.gitlab.com/handbook/it/it-self-service/operating-systems/), [including installation of SentinelOne](/handbook/security/corporate/systems/sentinelone/) as well all information in this section.

Complete details about Windows usage is available on the [Approved Operating Systems for GitLab Team Member Endpoint Systems](https://internal.gitlab.com/handbook/it/it-self-service/operating-systems/) page.

## Laptop Management Policies

In addition to specific hardware requirements, we also employ various policies and software solutions to ensure that all GitLab devices remain safe.

### Endpoint Management

#### Jamf

[Jamf](https://www.jamf.com/) allows us to remotely manage all of our Macs and perform tasks such as pushing updates, and remotely locking and wiping laptops. All new Macs shipped by GitLab are typically automatically enrolled in Jamf but it may be necessary to manually enroll a lapttop if it was self-procured. It is not possible to access any system behind Okta from a Mac that is not enrolled in Jamf.

#### Fleet

(Fleet)[https://fleetdm.com/] is an Open-Source remote maangement system that is required to be installed on all of our Linux and Windows devives in order to be able to access any GitLab service behind Okta. It allows us to remotely manaage all enrolled laptops to ensure security compliance, and perform tasks such as remotely loicking and wiping machines.

### Backblaze

(Backblaze)[https://www.backblaze.com/] is a tool that might be deployed to backup data on your company owned device in the event of a security or legal hold/investigation and only following a request of the Legal and People Ops teams, subject to local data, privacy and employment laws.

### Apple IDs

While the use of an Apple ID is currently not required to use a GitLab-owned Mac, we do allow users to [create new IDs](https://support.apple.com/en-us/108647?device-type=web) using their GitLab email addresses.
The use use of personal Apple IDs on GitLab-owned devices is prohibited as per the following reasons:

* Backups, keychains and documents are all considered sensitive information, and should not be stored in personal services.
* 2FA for remote lock, wipe, or account resets are common methods of account compromises, and ensuring the use of GitLab.com email addresses also ensures we are in control of that aspect of multi-factor authentication.
* Keeping a strong separation between work and personal accounts will help prevent the accidental leak of information from one to the other, in either direction.

Defense in depth, in part, means you make a best effort to be secure at each layer. To read through more instructions, please refer to [security best practices](/handbook/security/corporate/services/laptops/security/).
