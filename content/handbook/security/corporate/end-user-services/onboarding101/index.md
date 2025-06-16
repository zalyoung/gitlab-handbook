---
title: "GitLab IT Onboarding 101"
---

## Welcome To GitLab

Congratulations on joining GitLab! This page is dedicated to the IT onboarding experience, here at GitLab we use many applications and the latest hardware to enable you to complete your work to the best of your ability! While it may seen a little bit overwhelming at the start the Team member enablement team is here to make the process as easy as possible!

## Table of Contents

1. [Before you begin](#before-you-begin)
2. [Laptop Setup: MacBook](#laptop-setup-macbook)
   1. [Activate your Okata Account](#step-1-activate-your-okta-account)
   2. [MacBook Initial Setup](#step-2-macbook-initial-setup)
   3. [System Configuration](#step-3-system-configuration)
   4. [Google Account Setup](#step-4-google-account-setup)
   5. [Okta Account Verification](#step-5-okta-account-verification)
   6. [Access GitLab Email & GitLab.com Account](#step-6-access-gitlab-email--gitlabcom-account)
3. [Laptop Setup: Linux](#laptop-setup-linux)
   1. [Activate your Okata Account](#step-1-activate-your-okta-account-1)
   2. [Okta Setup](#step-2-okta-setup)
   3. [Google Account Setup](#step-3-google-account-setup)
   4. [Access GitLab Email & GitLab.com Account](#step-4-access-gitlab-email--gitlabcom-account)
4. [Mobile Setup](#mobile-setup)
   1. [Okta Verify](#okta-verify)
   2. [Mobile Passkey and Yubikey Setup](#mobile-passkey-and-yubikey-setup)

## Before You Begin

You will receive an Okta activation email in your personal email. This is the first step to gaining access to GitLab's systems.

## Laptop Setup: MacBook

> **IMPORTANT**: You will not have access to your work MacBook until your start date. On your start date,  please follow this guide.

### Step 1: Activate Your Okta Account

1. On a mobile device, check your personal email for an Okta activation email.
2. Click the link in the email to set your password
3. After setting your password, your browser will redirect to the Okta Dashboard. **IMPORTANT: Do not open Gmail (G Suite SSO Mail) or any Google application (G Suite SSO Drive, G Suite SSO Calendar, G Suite SSO Account) before finishing the laptop setup process in Step 2. Opening these applications too early will lock you out of your laptop.**
4. You will receive a follow-up email from Okta with the subject **Security Method enrolled**.

### Step 2: MacBook Initial Setup

> **IMPORTANT**: If `Remote Management` is not available on your laptop, please use the [Jamf MDM Setup Guide](/handbook/security/corporate/systems/jamf/setup/) to manually enroll your device.

1. Power on your GitLab laptop
2. Complete the initial macOS setup:
   1. Choose your preferred language
   2. Select your country or region
   3. Choose accessibility options (or click **Not Now**)
   4. Select your WiFi network
   5. On the **Remote Management** screen, click **Enroll**

3. Log into GitLab Okta:
   1. Use the full GitLab email address (e.g., yourname@gitlab.com)
   2. Enter the password you created on your personal device
   3. Click **Sign in**

4. Set up your computer account:
   1. Create a password for your local Mac account
   2. Click **Continue**

5. Configure system settings:
   1. On the **Enable Location Services** screen, check **Enable Location Services on this Mac**
   2. Click **Continue**
   3. On the **Touch ID** screen, click **Continue**
   4. Enroll in Touch ID by placing your finger on the scanner (this is required)
   5. On the **Choose Your Look** screen, select **Light,** **Dark,** or **Auto**
   6. Click **Continue**

### Step 3: System Configuration

1. On the **Welcome to your new Mac!** screen, wait while applications are automatically installed
   1. This should take a few minutes
   2. When finished, click **Done**

2. System Restart:
   1. A pop-up will inform you that your machine needs to restart within the next minute
   2. Wait for the automatic restart or initiate it yourself
   3. After restart, log back in

3. Enable FileVault:
   1. Click **Enable Now** when prompted to enable FileVault (disk encryption)

### Step 4: Google Account Setup

1. Open Google Chrome
2. In the **Sign in to Chrome** window, click **Sign in**
3. Enter your GitLab email address
4. If Okta Verify opens, click **Not now** or close it
5. Sign in to Okta with your username and password
6. Click **Agree** on the Google Workspace policy that appears
7. On the **Verify it's you** screen, click **Continue**
8. On the **Enhanced Ad Privacy in Chrome** notice, click **Got It**
9. When you see **Your organization will manage this profile,** click **Continue**
10. On the **Turn on Sync** window, click **Yes, I'm in**

### Step 5: Okta Account Verification

1. In Chrome, go to https://gitlab.okta.com
2. When Okta Verify appears:
   1. On the **Welcome to Okta Verify** window, click **Get Started**
   2. In Chrome, enter your Okta password and click **Verify**
   3. In the Okta Verify window, click **Enable** for **Enable Touch ID confirmation**
   4. Close the **Complete** tab in Chrome

3. Complete security verification:
   1. In Chrome, click **Verify it's you with a security method**
   2. Select **Password** and click **Verify**
   3. In Okta Verify, click **Yes, it's me** (or provide your fingerprint)

4. Set up additional security methods:
   1. On the **Set up Security methods** screen, click **Set up** for **Security Key or Biometric authenticator**
   2. Click **Set up** again to confirm
   3. On the **Create a passkey for gitlab.okta.com** pop-up, click **Save another way**
   4. Select **Your Chrome profile** followed by **Continue**

### Step 6: Access GitLab Email & GitLab.com Account

1. Access your GitLab email by clicking **G Suite SSO Mail** in Okta
2. Check your GitLab email for an email titled "**Welcome to GitLab Onboarding, `yourname`!**"
3. Follow the instructions in the email to set up your GitLab.com account and access your Onboarding Issue

### Congratulations

You have completed the initial setup process for your GitLab account and MacBook. If you encounter any issues, please contact the IT Help Desk.

## Laptop Setup: Linux

### Step 1: Activate Your Okta Account

1. On a mobile device, check your personal email for an Okta activation email.
2. Click the link in the email to set your password
3. After setting your password, your browser will redirect to the Okta Dashboard
4. You will receive a follow-up email from Okta with the subject **Security Method enrolled**

### Step 2: Okta Setup

1. On your Linux laptop, download Google Chrome
2. Open Google Chrome, and navigate to https://gitlab.okta.com
3. Complete security verification:
   - Click "Verify it's you with a security method"
   - Select "Password" and click "Verify"
4. Set up additional security methods:
   - On the "Set up Security methods" screen, click "Set up" for "Security Key or Biometric authenticator"
   - Click "Set up" again to confirm
   - On the "Create a passkey for gitlab.okta.com" pop-up, click "Continue"

### Step 3: Google Account Setup

1. Access your GitLab email by clicking **G Suite SSO Mail** in Okta
2. In the **Sign in to Chrome** window, click **Sign in**
3. Enter your GitLab email address
4. Sign in to Okta with your username and password
5. Click **Agree** on the Google Workspace policy that appears
6. On the **Verify it's you** screen, click **Continue**
7. On the **Enhanced Ad Privacy in Chrome** notice, click **Got It**
8. When you see **Your organization will manage this profile,** click **Continue**
9. On the **Turn on Sync** window, click **Yes, I'm in**

### Step 4: Access GitLab Email & GitLab.com Account

1. Check your GitLab email for an email titled "**Welcome to GitLab Onboarding, `yourname`!**"
2. Follow the instructions in the email to set up your GitLab.com account and access your Onboarding Issue

## Mobile Setup

To be able to access applications behind Okta (e.g. Slack, GMail, Calendar, etc) on a mobile device; the device needs to be enrolled in Okta Verify, and a passkey needs to be saved on the device.

### Okta Verify

> These steps apply to Apple and Android devices

1. Download the Okta Verify app from the App Store (Apple) / Play Store (Android)
2. On your laptop, click on the `Okta Verify` icon at the top of your screen, near the battery indicator and seclect `Open Okta Verify`
3. Click on your account, indicated by your name and email address
4. Click `Add Account to another device`
5. Verify your identity via Touch ID, and enable bluetooth if prompted
6. You should now see a QR code on screen
7. Ensure that bluetooth is enabled on your mobile device andthat the device is on the same Wi-Fi network as the laptop
8. Open the mobile app. 
   1. If this id your first time using the app, select `Add account from another device`
   2. If you have used the ap before, press the `+` button near the top of the screen
9. On the `Choose account type` screen, select `Organization`
10. Select `Add account from another device` followd by `Scan QR code`
11. Scan the QR code on your laptop screen
12. On your laptop, enter the 6-digit pin shown on the phone screen
13. On your mobile device, enable biometric verification when prompted
14. You can verify that your phone is succesfully enrolled by going to https://gitlab.okta.com/enduser/settings and checking that your phone is listed under `Okta Verify`

### Okta Verify -Manual Setup

> Use these steps in case the mobile app fails to connect to the laptop app or the laptop app is unavailable

1. Ensure that you have an [Okta passkey saved on your phone](#mobile-passkey-and-yubikey-setup)
2. Download the Okta Verify app from the App Store (Apple) / Play Store (Android)
3. Open the mobile app. 
   1. If this id your first time using the app, select `Get started`, and continue until you get to the `Choose account type` screen
   2. If you have used the ap before, press the `+` button near the top of the screen
4. On the `Choose account type` screen, select `Organization` and then `Skip`
5. Select `No, sign in instead`
6. For `Organization's sign-in URL`, enter `gitlab.okta.com`
7. Enter your `Okta Username` and `Password` and sign in
8. Agree to the terms on screen and enable touch ID

### Mobile Passkey and Yubikey Setup

> Adding a passkey to your mobile device will not give GitLab any access to any data on your phone. For more information, please see https://support.okta.com/help/s/article/Passkey-Management
> The steps below apply to both iOS and Android devices

1. On your laptop, open Chrome and go to https://gitlab.okta.com/enduser/settings
2. Next to `Security Key or Biometric Authenticator`, click `Set up another`
3. Verify your identy via your preferred method (e.g. Touch ID, 1Password, etc)
4. Click `Set up` followed by `set up`
   1. If the 1Password `Save Passkey` pop-up appears, click `x`
   2. If `Use Touch ID to sign in?` pop-up appears, click `Cancel`
5. When asked to `choose where to save your passkey for gitlab.okta.com`, select `Use a phone, tablet or security key` - A QR code should now appear on screen
   1. **Yubikey**: Insert your Yubikey and press the button
   2. **iOS**:
      1. Ensure that iOS is up-to-date - https://support.apple.com/en-gb/guide/iphone/iph3e504502/ios
      2. Ensure that you have the `Password` app installed and activated in your system settings - https://support.apple.com/en-gb/guide/iphone/iphf538ea8d0/ios
      3. Open the camera app and scan the QR code
      4. Select to save a passkey and follow the steps on your phone to save the passkey
   3. **Android**:
      1. Ensure that Android is up-to-date - https://support.google.com/android/answer/7680439?
      2. Open the `Camera` app OR `Google Lens`, depending on your device
      3. Scan the QR code and select the option to save a passkey to your Google account
         1. On Samsung devices, when prompted to `Skip the QR code next time`, select `not now` and proceed to save the passkey to your Google account.

## Need Help?

If you need further assistance with setting up your laptop please join our weekly onboarding call scheduled every Tuesday (Check your Calendar!) or reach out to us in Slack in the #it_help channel or via it-help@gitlab.com.
