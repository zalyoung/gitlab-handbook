---
title: "GitLab IT 101"
---

## Welcome To GitLab

Congratulations on joining GitLab! This page is dedicated to the IT onboarding experience, here at GitLab we use many applications and the latest hardware to enable you to complete your work to the best of your ability! While it may seen a little bit overwhelming at the start the Team member enablement team is here to make the process as easy as possible!

## Getting Started

### Laptop Setup: MacBook

> **IMPORTANT**: You will not have access to your work MacBook until your start date. Once you receive it, please follow this guide.

### Before You Begin

You will receive an Okta activation email on your personal device (mobile or computer). This is the first step to gaining access to GitLab's systems.

### Step 1: Activate Your Okta Account

1. **Check your personal email** for an Okta activation email
2. **Click the link** in the email to set your password
3. After setting your password, your browser will redirect to the Okta Dashboard
4. You will receive a follow-up email from Okta with the subject "Security Method enrolled"

## Step 2: MacBook Initial Setup

1. **Power on** your GitLab laptop
2. Complete the initial macOS setup:
   - Choose your preferred language
   - Select your country or region
   - Choose accessibility options (or click "Not Now")
   - Select your WiFi network
   - On the "Remote Management" screen, click "Enroll"

3. **Log into GitLab Okta**:
   - Use the full GitLab email address (e.g., yourname@gitlab.com)
   - Enter the password you created on your personal device
   - Click "Sign in"

4. **Set up your computer account**:
   - Create a password for your local Mac account
   - Click "Continue"

5. **Configure system settings**:
   - On the "Enable Location Services" screen, check "Enable Location Services on this Mac"
   - Click "Continue"
   - On the "Touch ID" screen, click "Continue"
   - Enroll in Touch ID by placing your finger on the scanner (this is required)
   - On the "Choose Your Look" screen, select "Light," "Dark," or "Auto"
   - Click "Continue"

## Step 3: System Configuration

1. On the "Welcome to your new Mac!" screen, wait while applications are automatically installed
   - This should take a few minutes
   - When finished, click "Done"

2. **System Restart**:
   - A pop-up will inform you that your machine needs to restart within the next minute
   - Wait for the automatic restart or initiate it yourself
   - After restart, log back in

3. **Enable FileVault**:
   - Click "Enable Now" when prompted to enable FileVault (disk encryption)

## Step 4: Google Account Setup

1. **Open Google Chrome**
2. In the "Sign in to Chrome" window, click "Sign in"
3. Enter your GitLab email address
4. If Okta Verify opens, click "Not now" or close it
5. Sign in to Okta with your username and password
6. Click "Agree" on the Google Workspace policy that appears
7. On the "Verify it's you" screen, click "Continue"
8. On the "Enhanced Ad Privacy in Chrome" notice, click "Got It"
9. When you see "Your organization will manage this profile," click "Continue"
10. On the "Turn on Sync" window, click "Yes, I'm in"

## Step 5: Okta Account Verification

1. In Chrome, go to https://gitlab.okta.com
2. When Okta Verify appears:
   - On the "Welcome to Okta Verify" window, click "Get Started"
   - In Chrome, enter your Okta password and click "Verify"
   - In the Okta Verify window, click "Enable" for "Enable Touch ID confirmation"
   - Close the "Complete" tab in Chrome

3. **Complete security verification**:
   - In Chrome, click "Verify it's you with a security method"
   - Select "Password" and click "Verify"
   - In Okta Verify, click "Yes, it's me" (or provide your fingerprint)

4. **Set up additional security methods**:
   - On the "Set up Security methods" screen, click "Set up" for "Security Key or Biometric authenticator"
   - Click "Set up" again to confirm
   - On the "Create a passkey for gitlab.okta.com" pop-up, click "Continue"

## Step 6: Access GitLab Email & Account

1. Access your GitLab email by clicking "G Suite SSO Mail" in Okta
2. Check your GitLab email for an onboarding email
3. Follow the instructions in the email to set up your GitLab.com account

## Congratulations

You have completed the initial setup process for your GitLab account and MacBook. If you encounter any issues, please contact the IT Help Desk.

### Apple ID

- Please create a new Apple ID for GitLab using your @gitLab.com email address to keep your personal and work data separate. You can also reimburse apps using an Apple ID created with your GitLab account. Your Apple ID consists of an email address and a password. It's the account you use for everything you do with Apple—including using the App Store, Apple TV app, Apple Book Store, iCloud, Messages, and more.

### Optional Setup Items

- **Screen Time:** Monitor and get reports on the use of your computer. For options and details, see Screen Time on Mac.

- **Enable Siri and "Hey Siri"**: You can turn on Siri and "Hey Siri" (so you can speak your Siri requests) during setup. To enable "Hey Siri," speak several Siri commands when prompted. To learn how to turn on Siri and "Hey Siri" later and for information about using Siri on your Mac, see Siri on your Mac.

- **Store files in iCloud**: iCloud has the ability to store desktop and documents in iCloud. As our Cloud Storage option is Google Drive, please make sure this feature is disabled. Anything of importance for work should be stored in Google Drive, a GitLab Issue, or the Handbook based on the type and [data classification](/handbook/security/data-classification-standard/) of the information.

## MacBook Cheat Sheet

If you are new to using a MacBook or switched from another OS such as windows check out these useful shortcuts and options!

![mactips2.png](/images/it/end-user-services/onboarding101/mactips2.png)

![mactips1.png](/images/it/end-user-services/onboarding101/mactips1.png)

### Official Apple Training

Apple has official training sessions available every week! These training sessions are great if you are new to using a MacBook or want some tips and insider knowledge on using a MacBook! Please check it out [here](https://events.apple.com/content/events/pst/us/en/default.html?token=xww6uj7woR0X9A3Y9qIMRkNVdH60MurN7MAvJSY75sHQxWqaTEhMjEmalXqC7MMJuZhb5dzJ1P9mLUXaAAfCMipX6qVTaNqFY_njjpamZQfrSbMYEpe-edwBN1r5nI4t-GCxEY8&a=1&l=e).

## Laptop Setup: Linux

Check out [this detailed page](/handbook/tools-and-tips/linux/) on setting up your Linux laptop. Also feel free to reach out in #Linux slack channel or #it_help for assistance!

## Extra Setup

### Endpoint Management

MacBook: You are required to install Jamf on your MacBook for security and compliance reasons. Please check [this guide](https://internal.gitlab.com/handbook/it/endpoint-tools/jamf/#enrolling-in-jamf) for assistance!

Linux: Currently we do not have an endpoint management tool for Linux. However we do have [a tool](/handbook/it/end-user-services/onboarding-access-requests/#fleet-intelligence--remote-lockwipe) that we use to wipe and lock them if needed.

### Laptop Encryption

It is essential to encrypt your laptops hard drive using Mac's FileVault or Linux's built in encryption. This will prevent unauthorised access of the contents in your hard drive. Please refer to our security pages to complete this.

- [MacBook Encryption](/handbook/security/corporate/services/laptops/security/encryption/)
- [Linux Encryption](/handbook/tools-and-tips/linux/#initial-installation)

## Need Help?

If you need further assistance with setting up your MacBook please join our weekly onboarding call scheduled every Tuesday (Check your Calendar!) or reach out to us in slack in the #it_help channel.
