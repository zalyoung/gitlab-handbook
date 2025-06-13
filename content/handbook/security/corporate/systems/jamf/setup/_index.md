---
title: Jamf MDM Setup Guide
---

## Manual Enrolment

While most new Macbooks supplied by GitLab are automatically enroled in Jamdf, there are still some exceptions based on where and when the laptop was purchased. In these cases, laptops must be manusally enrolled in Jamf to be able to access asy services behinded GitLab Okta.

### Prerequisites

1. A MacBook capable of running the latest version of macOS
1. An up-to-date macOS installation - [Update macOS](https://support.apple.com/en-us/108382)
1. A stable internet connection - **Do not attempt to enroll a laptop into Jamf using mobile internet, hotel Wi-Fi,etc.**
1. An active GitLab Okta account

**Note:** New hires will be able to complete the below steps without having a mobile device enroled in Okta Verify. Having a phone enroled in Okta Verify is a requirement for manually re-rnrolling a laptop. Please contact EUS via #it_help in Slack or it-help@gitlab.com for support.

### Step 1: Verify Enrolment

1. Click on the Apple icon on the top-right corner of your Mac and open `System Settings`
1. On the left, select `General` -> `Device Management` and check if `MDM Profile` is present
    1. If `Device Management` is not visible in under `General`, the laptop is not enrolled in Jamf or any other enpoint management software

### Step 2: Enrolment

1. Open Google Chrome and go to https://gitlab.jamfcloud.com/enroll
1. Sign in with your Okta credentials
1. Click the blue `Install` button to download the `enrollmentProfile.mobileconfig` file
1. Open the file by double-clicking on it
1. Go back to `System Settings` > `General` > `Device Management`
1. You will now see `MDM Profile` in the list, waiting to be installed
1. Double-click on `MDM Profile` and select `Install`
1. Enter your laptop login password when prompted and wait for the installation to finish.
1. You can verify that the process has been completed by checking if `Okta Verify` and `Self Service` are present in your `Applications` folder
