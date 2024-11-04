---
title: "Push Security User Guide"
description: "Push Security guide for end users on Push functionality."
---

## Overview

[Push Security](https://pushsecurity.com/help/audience/employees/docs/what-is-push/) is a web browser-based agent that is used to detect and prevent identity based cybersecurity threats.

The Push agent (Chrome Extension) will be installed across GitLab’s entire fleet of endpoints and performs both passive monitoring as well as active interrogation to detect and prevent identity breaches. The agent will automatically block credential reuse/credential stealing and prevent malicious website interactions, while providing logging and alerting capabilities. The extension can generate a salted partial hash of a user's password, called a fingerprint, which is stored locally for comparison. Push Security can then compare the fingerprint to known fingerprints for identity provider passwords to detect phishing attacks. The extension can also identify if a Team Member is using a weak or leaked password to log into cloud applications. 

In addition, the agent gives the Security Team visibility into unapproved SaaS applications and plugins allowing Security to quickly assess the overall risk to GitLab. GitLab is currently only considering covering Google Chrome based browsers, which will soon be a requirement to access GitLab data.


### System Owner

- DRI: `@zhardie1`
- `#security-corpsec` Slack channel
