---
title: "GitLab IT Onboarding 101"
---

## Welcome To GitLab

Congratulations on joining GitLab! This page is dedicated to the IT onboarding experience, here at GitLab we use many applications and the latest hardware to enable you to complete your work to the best of your ability! While it may seen a little bit overwhelming at the start the Team member enablement team is here to make the process as easy as possible!

## Table of Contents

1. [Before you begin](#before-you-begin)
1. [Laptop Setup: MacBook](#laptop-setup-macbook)
   - [Activate your Okata Account](#step-1-activate-your-okta-account)
   - [MacBook Initial Setup](#step-2-macbook-initial-setup)
   - [System Configuration](#step-3-system-configuration)
   - [Google Account Setup](#step-4-google-account-setup)
   - [Okta Account Verification](#step-5-okta-account-verification)
   - [Access GitLab Email & GitLab.com Account](#step-6-access-gitlab-email--gitlabcom-account)
3. [Laptop Setup: Linux](#laptop-setup-linux)
   - [Activate your Okata Account](#step-1-activate-your-okta-account-1)
   - [Okta Setup](#step-2-okta-setup)
   - [Google Account Setup](#step-3-google-account-setup)
   - [Access GitLab Email & GitLab.com Account](#step-4-access-gitlab-email--gitlabcom-account)

## Before You Begin

You will receive an Okta activation email in your personal email. This is the first step to gaining access to GitLab's systems.

## Laptop Setup: MacBook

> **IMPORTANT**: You will not have access to your work MacBook until your start date. On your start date,  please follow this guide.

### Step 1: Activate Your Okta Account

- On a mobile device, check your personal email for an Okta activation email.
- Click the link in the email to set your password
- After setting your password, your browser will redirect to the Okta Dashboard. **IMPORTANT: Do not open Gmail (G Suite SSO Mail) or any Google application (G Suite SSO Drive, G Suite SSO Calendar, G Suite SSO Account) before finishing the laptop setup process in Step 2. Opening these applications too early will lock you out of your laptop.**
- You will receive a follow-up email from Okta with the subject **Security Method enrolled**.

### Step 2: MacBook Initial Setup

> **IMPORTANT**: If `Remote Management` is not available on your laptop, please use the [Jamf MDM Setup Guide](/handbook/security/corporate/systems/jamf/setup/) to manually enroll your device.

1. Power on your GitLab laptop
1. Complete the initial macOS setup:
   - Choose your preferred language
   - Select your country or region
   - Choose accessibility options (or click **Not Now**)
   - Select your WiFi network
   - On the **Remote Management** screen, click **Enroll**

3. Log into GitLab Okta:
   - Use the full GitLab email address (e.g., yourname@gitlab.com)
   - Enter the password you created on your personal device
   - Click **Sign in**

4. Set up your computer account:
   - Create a password for your local Mac account
   - Click **Continue**

5. Configure system settings:
   - On the **Enable Location Services** screen, check **Enable Location Services on this Mac**
   - Click **Continue**
   - On the **Touch ID** screen, click **Continue**
   - Enroll in Touch ID by placing your finger on the scanner (this is required)
   - On the **Choose Your Look** screen, select **Light,** **Dark,** or **Auto**
   - Click **Continue**

### Step 3: System Configuration

1. On the **Welcome to your new Mac!** screen, wait while applications are automatically installed
   - This should take a few minutes
   - When finished, click **Done**

2. System Restart:
   - A pop-up will inform you that your machine needs to restart within the next minute
   - Wait for the automatic restart or initiate it yourself
   - After restart, log back in

3. Enable FileVault:
   - Click **Enable Now** when prompted to enable FileVault (disk encryption)

### Step 4: Google Account Setup

- Open Google Chrome
- In the **Sign in to Chrome** window, click **Sign in**
- Enter your GitLab email address
- If Okta Verify opens, click **Not now** or close it
- Sign in to Okta with your username and password
- Click **Agree** on the Google Workspace policy that appears
- On the **Verify it's you** screen, click **Continue**
- On the **Enhanced Ad Privacy in Chrome** notice, click **Got it**
- When you see **Your organization will manage this profile**, click **Continue**
- On the **Turn on Sync** window, click **Yes, I'm in**

### Step 5: Okta Account Verification

1. In Chrome, go to https://gitlab.okta.com and wait for Okta Verify to open
   - On the **Welcome to Okta Verify** window, click **Get Started**
   - In Chrome, enter your Okta password and click **Verify**
   - In the Okta Verify window, click **Enable** for **Enable Touch ID confirmation**
   - Close the **Complete** tab in Chrome

2. Complete security verification:
   - In Chrome, click **Verify it's you with a security method**
   - Select **Password** and click **Verify**
   - In Okta Verify, click **Yes, it's me** (or provide your fingerprint)

3. Set up additional security methods:
   - On the **Set up Security methods** screen, click **Set up** for **Security Key or Biometric authenticator**
   - Click **Set up** again to confirm
   - On the **Create a passkey for gitlab.okta.com** pop-up, click **Save another way**
   - Select **Your Chrome profile** followed by **Continue**

### Step 6: Access GitLab Email & GitLab.com Account

1. Access your GitLab email by clicking **G Suite SSO Mail** in Okta
2. Check your GitLab email for an email titled "**Welcome to GitLab Onboarding, `yourname`!**"
3. Follow the instructions in the email to set up your GitLab.com account and access your Onboarding Issue

## Laptop Setup: Linux

### Step 1: Activate Your Okta Account

- On a mobile device, check your personal email for an Okta activation email.
- Click the link in the email to set your password
- After setting your password, your browser will redirect to the Okta Dashboard
- You will receive a follow-up email from Okta with the subject **Security Method enrolled**

### Step 2: Okta Setup

- On your Linux laptop, download Google Chrome
- Open Google Chrome, and navigate to https://gitlab.okta.com
- Complete security verification:
   - Click "Verify it's you with a security method"
   - Select "Password" and click "Verify"
- Set up additional security methods:
   - On the "Set up Security methods" screen, click "Set up" for "Security Key or Biometric authenticator"
   - Click "Set up" again to confirm
   - On the "Create a passkey for gitlab.okta.com" pop-up, click "Continue"

### Step 3: Google Account Setup

- Open Google Chrome
- In the **Sign in to Chrome** window, click **Sign in**
- Enter your GitLab email address
- Sign in to Okta with your username and password
- Click **Agree** on the Google Workspace policy that appears
- On the **Verify it's you** screen, click **Continue**
- On the **Enhanced Ad Privacy in Chrome** notice, click **Got it**
- When you see **Your organization will manage this profile**, click **Continue**
- On the **Turn on Sync** window, click **Yes, I'm in**

### Step 4: Access GitLab Email & GitLab.com Account

1. Check your GitLab email for an email titled "**Welcome to GitLab Onboarding, `yourname`!**"
2. Follow the instructions in the email to set up your GitLab.com account and access your Onboarding Issue

### Congratulations

You have completed the initial setup process for your GitLab account and laptop. If you encounter any issues, please contact us via the #it_help Slack channel or it-help@gitlab.com.

### Next Steps

To access company applications on your mobile device as per Day 2 of your onboarding, please follow the [Mobile Device Onboarding](/handbook/security/corporate/end-user-services/onboarding101/onboarding-mobile-devices) guide.

## Need Help?

If you need further assistance with setting up your laptop please join our weekly onboarding call scheduled every Tuesday (Check your Calendar!) or reach out to us in Slack in the #it_help channel or via it-help@gitlab.com.
