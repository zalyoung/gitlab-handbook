---
title: "GitLab Unfiltered Video Scanner"
aliases:
  - "/handbook/security/product-security/security-platforms-architecture/video-scanner"
description: "Handbook page for the GitLab Unfiltered Video Scanner."
---

Last Updated: June 2025

## About Video Scanner

### What Is Video Scanner

The YouTube Video Scanner is a GitLab internal application that scans videos for potential secrets before publishing to the GitLab Unfiltered channel. Team members can access it via https://frontend.video-scanner-dev.sec.gitlab.net/.

### When to Use It

Starting from milestone 18.3, all GitLab team members are requested to upload videos to `GitLab Unfiltered` through Video Scanner, with exceptions indicated in the `MVP Scope and Limitations` section below.

### How to Use it

Instead of uploading new video directly to GitLab Unfiltered, upload it through https://frontend.video-scanner-dev.sec.gitlab.net/. The app will automatically finish the upload if no token is found. However, if token is found, the upload aborts, and the user will be notified in the indicated Slack channel (see later section), with the detected strings and timestamps.

More details about how the scan is performed: the app first parses texts from the video using [Google's Video Intelligence API](https://cloud.google.com/video-intelligence?hl=en). The prasing result is stored in a file, which then gets scanned by [Tokinator](https://gitlab.com/gitlab-com/gl-security/appsec/tokinator) to detect sensitive strings. Depending on the scan results, the app will decide whether to proceed or to abort the upload attemp.

## Slack Notifications

**Channel:** `#video-scanner-updates`

Users receive Slack notifications in this channel for both successful and aborted upload attempts.

## MVP Scope and Limitations

The Video Scanner MVP has limited product scope. See the [Pre-publication Workflow Diagram with Architectural Details](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/issues/90#note_2457778646) for the supported workflow.

### MVP Limitations

* Users can only upload videos to `GitLab Unfiltered` using the Video Scanner app for now. We will integrate with other GitLab channels after MVP is delivered.
* Uploading to playlists is not supported
* Manual override for false positives is not supported

**Workaround:** To bypass these limitations, upload directly to Youtube channels on an as-needed basis. Please submit feature requests through the feedback issue linked below, if you encouter limitations that we haven't documented.

### Feedback

Please submit feedback in the [Video Scanner Feedback Issue](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/issues/103).

## Projects and Release Process

### Video Scanner Project Epic

https://gitlab.com/groups/gitlab-com/gl-security/security-research/video-scanner/-/epics/1

### DRI

`#sec-product-security-engineering`

### Project links

1. GitLab repos:

* [YouTube Video Scanner](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner)
* [Frontend](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/frontend)
* [Terraform Config](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config)

### Deployment

1. Infrastructure

Video Scanner is hosted in GCP, with all resources configured using terraform. See [Video Scanner infra deployment instructions](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config#deploy-1) when making changes to these resources.

1. `secret-matcher`

The [secret-matcher](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/tree/main/functions/secret-matcher?ref_type=heads) function is responsbile for secret scanning and the completion of video upload + Slack notification. To deploy new versions, first [push a new secret-matcher image to package registry](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config#build-and-push-the-image-of-secret-matcher) and [deploy a new Cloud Run function revision linking the new image](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config#create-a-new-revision-of-secret-matcher).

1. `frontend-service`

The [frontend-service](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/frontend) powers the uploader UI. New versions can be deployed following the same steps as `secret-matcher`.

## Communication Plan for Future Releases

Major version changes to Video Scanner will be announced in `#whats-happening-at-gitlab`, `#brand_video`, `#security`, `#engineering-fyi`.

**TODO:**

* Add project version tags

## Token Rotation

YouTube OAuth2.0 tokens enable automated video uploads. For rotation instructions, see the [security-research-terraform-config README](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config/-/blob/main/README.md?ref_type=heads#youtube-video-scanner-oauth20-client-and-audience-details).

## End-to-End Testing

[Section content WIP] See https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/issues/98.
