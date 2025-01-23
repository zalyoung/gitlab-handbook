---
title: "Automated evidence collection and control testing"
---

## Overview
This document outlines GitLab's approach to automated evidence collection and control testing, detailing two distinct methodologies used to ensure comprehensive security and compliance coverage.

## Executive Summary

Key aspects of GitLab's automated evidence collection and control testing:

* Two distinct testing methodologies:
  - Framework-based: Structured approach for ISO, SOC 2, TISAX, and Cyber Essentials compliance
  - Risk-based: Dynamic approach for emerging security challenges and operational risks

* Shared Infrastructure:
  - Centralized evidence collection system
  - Automated collection and validation
  - Common storage and retrieval mechanisms

* Key Differentiators:
  - Framework testing follows rigid schedules and standardized procedures
  - Risk-based testing adapts to the threat landscape and risk assessments
  - Evidence can serve both purposes through proper classification

* Implementation:
  - Mix of custom automation and security platforms
  - Flexible architecture to accommodate evolving requirements
  - Comprehensive reporting for both compliance and risk management

## Introduction
Automated evidence collection and control testing at GitLab follow a sophisticated dual-pronged approach designed to meet compliance requirements and address dynamic security risks. This document outlines our comprehensive strategy, which combines structured framework-based testing with flexible risk-based assessments, ensuring regulatory compliance and a robust security posture.

## Control Testing Methodologies

### Framework-Based Control Testing
Framework-based control testing forms the foundation of our compliance program, specifically addressing requirements from established frameworks such as ISO, SOC 2, TISAX, and Cyber Essentials. This methodology follows a highly structured approach where control objectives, testing procedures, and evidence requirements are clearly defined and standardized. The predictability of this approach ensures consistent compliance with certification requirements while maintaining audit readiness.

Testing under this approach adheres to strict documentation standards and predetermined frequencies aligned with certification cycles. Each control test must produce evidence that meets specific framework criteria, often following standardized templates and formats acceptable to external auditors. This rigorous structure ensures that our compliance posture remains substantial and verifiable, with clear paths to demonstrate adherence to framework requirements.

### Risk-Based Control Testing
In contrast to the structured framework approach, our risk-based control testing methodology provides the flexibility needed to address emerging security challenges and operational risks. This approach extends beyond baseline compliance requirements to examine additional control aspects and security processes crucial for maintaining a robust security posture that compliance frameworks may not explicitly cover.

The risk-based approach adapts to the evolving threat landscape, allowing for dynamic adjustment of testing parameters and frequencies based on risk indicators. Testing depth and evidence collection requirements vary according to the control context and current risk assessment findings. This flexibility enables the security team to focus resources on areas of most significant risk while maintaining comprehensive coverage of the security landscape.

## Evidence Collection Infrastructure

### Centralized Collection and Storage
Our evidence-collection infrastructure serves both testing methodologies through a centralized system that maintains strict control over evidence quality and integrity. The system incorporates sophisticated metadata tagging, version control, and access management to ensure evidence reliability and availability. Evidence retention policies are carefully crafted to meet both compliance requirements and operational needs, with automated collection schedules optimized for efficient resource utilization.

The infrastructure handles diverse evidence types, from system configurations and log data to policy documents and security event records. Each piece of evidence is automatically tagged with relevant metadata, including collection timestamps, control identifiers, and validation criteria. This comprehensive metadata enables efficient evidence retrieval and correlation during audit preparation or risk analysis.

### Automation Implementation
Evidence-collection automation leverages both custom-developed solutions and integrated security platforms. Custom scripts, typically developed in Python, handle specialized collection tasks and integrate with various data sources through APIs and database queries. These are complemented by established security platforms like Wiz, which provide additional automated collection capabilities and integrated analysis features.

The automation framework is designed to be extensible, allowing for the addition of new collection methods and integration with emerging security tools. This flexibility ensures that our evidence-collection capabilities can evolve alongside our security and compliance needs.

## Testing Execution and Frequency

Control testing execution varies significantly between our two methodologies, yet they share the same evidence-collection infrastructure. Framework-based testing follows rigid schedules aligned with certification requirements, typically operating on fixed daily, weekly, or monthly intervals. Each test execution includes automated compliance checking against predefined validation rules, with robust exception tracking and evidence linking.

Risk-based testing, however, operates on a more dynamic schedule driven by ongoing risk assessments, threat intelligence, and operational changes. Test execution adapts to emerging threats and vulnerabilities, adjusting frequency and depth based on risk indicators and business impact considerations. This adaptive approach ensures that security resources are allocated efficiently to address the most significant risks.

## Analysis and Reporting

Our analysis and reporting framework provides distinct views for compliance and risk-based assessments while maintaining data correlation capabilities. For framework-based controls, reports focus on certification readiness, control effectiveness, and gap analysis, providing clear visibility into our compliance posture. These reports directly support audit preparation and compliance maintenance activities.

Risk-based analysis examines control effectiveness trends, threat exposure metrics, and vulnerability status, providing insights into our security risk posture. The reporting system correlates findings across both methodologies to provide a comprehensive view of our security and compliance status, enabling informed decision-making about resource allocation and risk mitigation strategies.

## Conclusion

This dual approach to automated evidence collection and control testing provides GitLab with comprehensive coverage of compliance requirements and security risks. The shared infrastructure for evidence collection, combined with distinct testing methodologies, ensures efficient resource utilization while maintaining the flexibility to address both structured compliance needs and dynamic security challenges. This strategy positions GitLab to maintain a substantial compliance posture while effectively managing emerging security risks.