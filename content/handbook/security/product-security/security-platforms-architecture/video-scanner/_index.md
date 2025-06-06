---
title: "GitLab Unfiltered Video Scanner"
aliases:
  - "/handbook/security/product-security/security-platforms-architecture/video-scanner"
description: "This is the handbook page for GitLab Unfiltered Video Scanner."
---

Last Updated: Jun, 2025

## Purpose

This is the handbook page for the Youtube Video Scanner, an internal tool provided to GitLab team members.

GitLab team members are requested to upload Videos through the Youtube Video Scanner starting from milestone 18.3. It is designed to scan videos for potential secrets before they are published to the GitLab Unfiltered channel. If the system detects sensitive strings in the video, the upload will be aborted.

## Epic Link

https://gitlab.com/groups/gitlab-com/gl-security/security-research/video-scanner/-/epics/1

## Feedback Issue

Please leave your feedback in [Video Scanner Feedback Issue](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/issues/103).

## DRI

`#sec-product-security-engineering`.

## Slack Notification

Channel: TBD

Alerts will be posted in Slack to notify team members about successful and aborted video uploads.

## MVP Product Scope and Limitations

The Video Scanner MVP is planned to be released in milestone `18.2`. See [Pre-publication Workflow Diagram with Architectural Details](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/issues/90#note_2457778646) for feature scope.

MVP was released with the following limitations:

* Upload videos to a playlist is not supported.
* Users will not receive Email notifications on successful / aborted uploads. All communications are done in Slack channel.
* Users cannot force the system to upload anyway, after a false positive detection.

For now, if you must bypass any of the above limitations, please upload directly to GitLab Unfiltered on an as-needed basis. If you have more feature requirements, please send us a feedback using the feedback issue.

## Projects and Release Process

The Video Scanner system codebase involve the following projects:
- https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner
- https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/frontend
- https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config

[secret-matcher](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/youtube-video-scanner/-/tree/main/functions/secret-matcher?ref_type=heads) and [frontend-service](https://gitlab.com/gitlab-com/gl-security/security-research/video-scanner/frontend) are the 2 core services that are actively developed.

To release a new version, follow the [deployment instructions for video-scanner-live](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config#deploy-1) and use the [Troubleshooting Tips](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config#deployment-troubleshooting-tips) when encounter errors.

TODO: Project version tags?

TODO: identify the channels that we need to send deployment communication to.

## Token Rotation

Youtube OAuth2.0 token is required to perform the automated video upload. Instructions on how to rotate this token can be found in [security-research-terraform-config project README](https://gitlab.com/gitlab-com/gl-security/security-research/security-research-terraform-config/-/blob/main/README.md?ref_type=heads#youtube-video-scanner-oauth20-client-and-audience-details).

## End to end testing
