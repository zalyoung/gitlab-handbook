---
title: "Well-Articulated Product Security Risks Guide"
description: "This guide outlines the requirements for submitting high-quality risk entries to the [Product Security Risk Register](/handbook/security/product-security/security-platforms-architecture/risk-register/) so they can be used effectively to prioritize product security work."
---

## What Makes a Well-Articulated Risk

A well-articulated product security risk clearly communicates:

1. **Problem Statement**: A specific, concise description of the security vulnerability, design weakness, functional logical issue, or capability gap that exposes GitLab (the product) to compromise.
1. **Potential Impact**: Clear explanation of the potential harm to GitLab and/or its customers if the risk remains unaddressed, including possible business impacts, data compromise scenarios, service or operational disruptions, etc.
1. **Supporting Evidence**: Concrete trends, data points, or proofs of concept that substantiate the risk is real and not merely theoretical that can help inform prioritization.
1. **Scope and Scale**: Information about how widespread the risk is and what parts of the product or infrastructure are affected.

## What a Well-Articulated Risk is NOT

1. **A Solution Statement**: "We need to implement X technology" or "build Y feature" without explaining the underlying risk.
1. **A Feature Request**: Describing desired functionality without connecting it to an actual security exposure.
1. **An Individual Vulnerability**: Specific CVEs or component-based vulnerabilities belonging elsewhere.
1. **A Vague or Generalized Problem**: "Our security posture is weak" without specific details.
