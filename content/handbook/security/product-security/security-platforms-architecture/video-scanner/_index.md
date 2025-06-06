---
title: "GitLab Unfiltered Video Scanner"
aliases:
  - "/handbook/security/product-security/security-platforms-architecture/video-scanner"
description: "Handbook page for the GitLab Unfiltered Video Scanner."
---

Last Updated: June 2025

## Purpose

The YouTube Video Scanner is an internal tool that scans videos for potential secrets before publication to the GitLab Unfiltered channel. If sensitive strings are detected, the upload is automatically aborted.

Starting from milestone 18.3, all GitLab team members are encouraged to upload videos through this scanner.

Starting from xx, it's mandatory that all videos are uploaded via the Youtube Video Scanner.

## Epic Link

https://gitlab.com/groups/gitlab-com/gl-security/security-research/video-scanner/-/epics/1

## Feedback

Please submit feedback in the [Video Scanner Feedback Issue](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/issues/103).

## DRI

`#sec-product-security-engineering`

## Slack Notifications

**Channel:** TBD

Team members are notified about successful and aborted video uploads through Slack notifications.

## MVP Scope and Limitations

The Video Scanner MVP was released in milestone 18.2. See the [Pre-publication Workflow Diagram with Architectural Details](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/issues/90#note_2457778646) for the current product scope.

### Current Limitations

* Playlist uploads are not supported
* Manual override for false positives is not available

**Workaround:** To bypass these limitations, upload directly to GitLab Unfiltered on an as-needed basis. Please submit feature requests through the feedback issue, if you encouter limitations that we haven't documented.

## Projects and Release Process

### Core Repositories

* [YouTube Video Scanner](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner)
* [Frontend](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/frontend)
* [Terraform Config](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config)

### Services Under Active Development

* [secret-matcher](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/tree/main/functions/secret-matcher?ref_type=heads)
* [frontend-service](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/frontend)

### Deployment

Follow the [deployment instructions for video-scanner-live](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config#deploy-1). Refer to [Troubleshooting Tips](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config#deployment-troubleshooting-tips) if errors occur.

**TODO:**
- Add project version tags
- Identify deployment communication channels

## Token Rotation

YouTube OAuth2.0 tokens enable automated video uploads. For rotation instructions, see the [security-research-terraform-config README](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config/-/blob/main/README.md?ref_type=heads#youtube-video-scanner-oauth20-client-and-audience-details).

## End-to-End Testing

[Section content WIP] Include testing process for:

* successful video upload
  * check for Slack notification
  * check if Video is present
* aborted video upload with detected secret
  * check for Slack notification
