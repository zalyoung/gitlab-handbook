---
title: "GitLab IT - Mobile Device Onboarding"
---

To be able to access applications behind Okta (e.g. Slack, GMail, Calendar, etc) on a mobile device; the device needs to be enrolled in Okta Verify, and a passkey needs to be saved on the device.

## Table of Contents

1. [Okta Verify](#okta-verify)
1. [Mobile Passkey and Yubikey Setup](#mobile-passkey-and-yubikey-setup)

### Okta Verify

> These steps apply to Apple and Android devices

- Download the Okta Verify app from the App Store (Apple) / Play Store (Android)
- On your laptop, click on the `Okta Verify` icon at the top of your screen, near the battery indicator and select `Open Okta Verify`
- Click on your account, indicated by your name and email address
- Click `Add Account to another device`
- Verify your identity via Touch ID, and enable bluetooth if prompted
- You should now see a QR code on screen
- Ensure that bluetooth is enabled on your mobile device and that the device is on the same Wi-Fi network as the laptop
- Open the Okta Verify app on your mobile device.
   - If this is your first time using the app, select `Add account from another device`
   - If you have used the app before, press the `+` button near the top of the screen
- On the `Choose account type` screen, select `Organization`
- Select `Add account from another device` followed by `Scan QR code`
- Scan the QR code on your laptop screen
- On your laptop, enter the 6-digit pin shown on the phone screen
- On your mobile device, enable biometric verification when prompted
- You can verify that your phone is successfully enrolled by going to https://gitlab.okta.com/enduser/settings and checking that your phone is listed under `Okta Verify`.

### Okta Verify - Manual Setup

> Use these steps in case the mobile app fails to connect to the laptop app or the laptop app is unavailable

- Ensure that you have an [Okta passkey saved on your phone](#mobile-passkey-and-yubikey-setup).
- Download the Okta Verify app from the App Store (Apple) / Play Store (Android).
- Open the Okta Verify app on your mobile device.
  - If this is your first time using the app, select `Get started`, and continue until you get to the `Choose account type` screen.
  - If you have used the app before, press the `+` button near the top of the screen.
- On the `Choose account type` screen, select `Organization` and then `Skip`.
- Select `No, sign in instead`.
- For `Organization's sign-in URL`, enter `gitlab.okta.com`.
- Enter your `Okta Username` and `Password` and sign in.
- Agree to the terms on screen and enable Touch ID.

### Mobile Passkey and Yubikey Setup

> Adding a passkey to your mobile device will not give GitLab any access to any data on your phone. For more information, please see https://support.okta.com/help/s/article/Passkey-Management
> The steps below apply to both iOS and Android devices

1. On your laptop, open Chrome and go to https://gitlab.okta.com/enduser/settings
1. Next to `Security Key or Biometric Authenticator`, click `Set up another`
1. Verify your identity via your preferred method (e.g. Touch ID, 1Password, etc)
1. Click `Set up` followed by `set up`
    - If the 1Password `Save Passkey` pop-up appears, click `x`
    - If `Use Touch ID to sign in?` pop-up appears, click `Cancel`
5. When asked to `choose where to save your passkey for gitlab.okta.com`, select `Use a phone, tablet or security key` - A QR code should now appear on screen
   - **Yubikey**: Insert your Yubikey and press the button
   - **iOS**:
        - Ensure that iOS is up-to-date - https://support.apple.com/en-gb/guide/iphone/iph3e504502/ios
        - Ensure that you have the `Password` app installed and activated in your system settings - https://support.apple.com/en-gb/guide/iphone/iphf538ea8d0/ios
        - Open the camera app and scan the QR code
        - Select to save a passkey and follow the steps on your phone to save the passkey
    - **Android**:
        - Ensure that Android is up-to-date - https://support.google.com/android/answer/7680439?
        - Open the `Camera` app OR `Google Lens`, depending on your device
        - Scan the QR code and select the option to save a passkey to your Google account
        - On Samsung devices, when prompted to `Skip the QR code next time`, select `not now` and proceed to save the passkey to your Google account. Please make sure that you save the passkey to Google’s passkey manager and not Samsung Passkey.
