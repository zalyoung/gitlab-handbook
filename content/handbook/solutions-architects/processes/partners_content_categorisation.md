---
title: GitLab Partners Content Categorisation & Governance
---

## GitLab Partners Content Categorisation & Governance

This document outlines the comprehensive content categorisation framework and governance model for GitLab Partners content management in HighSpot.

## Table of Contents

* [Content Categorisation Framework](#content-categorisation-framework)
  * [Content Privacy Classification](#content-privacy-classification)
  * [Asset Types](#asset-types)
  * [Additional Classification Dimensions](#additional-classification-dimensions)
* [Content Governance Model](#content-governance-model)
  * [Roles & Responsibilities](#1-roles--responsibilities)
  * [Compliance Requirements](#3-compliance-requirements)
  * [Categorisation Decision Guidelines](#4-categorisation-decision-guidelines)
  * [Content Quality Standards](#5-content-quality-standards)
* [Content Categorisation Decision Tree](#content-categorisation-decision-tree)
* [Example Content Categorisation](#example-content-categorisation)
---

## Content Categorisation Framework

### Content Privacy Classification

* **Ecosystems Internal:** Content restricted to GitLab team
* **Ecosystems External:** Content approved for external distribution and public sharing on the partner portal

### Asset Types

#### Standard Assets

* Analyst Report
* Competitive Insights
* Demo (includes former Product Tours)
* Digital Rooms/Template
* eBook/Whitepaper
* Field Guide
* Google Forms
* Handbook Pages
* Ecosystems Internal Presentations (formerly "Internal-facing slide/Presentations")
* Solution Briefing by Region (formerly "Success Story")
* Technical Webinar
  * Security
  * Governance and Compliance
  * Analytics
  * GitOps
  * Premium
  * Ultimate
  * Duo Enterprise/Pro
  * Duo with Amazon Q
  * Duo Workflow
  * Other product subcategories

### Additional Classification Dimensions

#### By Lifecycle Stage

* **Enablement** - Training materials, onboarding guides
* **Pre-Sales** - Discovery templates, proposal frameworks
* **Implementation** - Technical guides, integration documentation
* **Adoption** - Best practices, optimisation guides
* **Growth** - Upsell/cross-sell materials, expansion playbooks

#### By Partner Type

* Technology Partners
* Services Partners
* Channel Partners
* Alliance Partners

#### By Use Case

* DevOps Transformation
* Security & Compliance
* Cloud Migration
* CI/CD Implementation
* Enterprise Agile Planning

#### Metadata Tags

* Product Version
* Publish Date
* Target Audience
* Associated Partner Programme Tier
* Language/Locale
  * English
  * Japanese
  * Korean
* Region
  * US
  * EMEA
  * APAC

---

## Content Governance Model

### 1. Roles & Responsibilities

<table>
<tr>
<th>Role</th>
<th>Responsibilities</th>
</tr>
<tr>
<td>

**Content Owner**
</td>
<td>

• Creates/updates content

• Applies initial categorisation

• Ensures adherence to privacy policies
</td>
</tr>
<tr>
<td>

**Content Reviewer**
</td>
<td>

• Validates categorisation accuracy

• Checks metadata completeness

• Approves content for distribution
</td>
</tr>
<tr>
<td>

**Platform Administrator**
</td>
<td>

• Maintains categorisation structure

• Conducts periodic audits

• Enforces governance policies
</td>
</tr>
</table>

### 3. Compliance Requirements

* All Partner External content must be approved by legal before sharing
* Content with GitLab roadmap information must be classified as Partner Internal
* Customer-specific information requires explicit sharing permission

### 4. Categorisation Decision Guidelines

* When content fits multiple categories, prioritise by primary audience need
* Use minimum necessary categories to avoid over-classification
* When in doubt, default to more restrictive privacy settings

### 5. Content Quality Standards

* All content must have a clear target audience
* Content should include a "last updated" date
* Technical accuracy must be validated before publication
* External content should follow GitLab brand guidelines

---

## Content Categorisation Decision Tree

For full visualisation, please use a Mermaid-compatible renderer. Here's the code to generate the decision tree:

```mermaid
flowchart TD
    A[New Content] --> B{Can be shared externally?}
    B -->|Yes| C[Partner External]
    B -->|No| D[Partner Internal]
    
    C --> E{What type of asset?}
    D --> E
    
    E -->|Knowledge/Information| F[Select Asset Type]
    E -->|Interactive/Engagement| G[Select Asset Type]
    
    F --> F1[Analyst Report]
    F --> F2[Competitive Insights]
    F --> F3[eBook/Whitepaper]
    F --> F4[Field Guide]
    F --> F5[Handbook Page]
    F --> F6[Partner Internal Presentations]
    F --> F7[Solution Briefing]
    
    G --> G1[Demo]
    G --> G2[Digital Rooms/Template]
    G --> G3[Google Forms]
    G --> G4[Technical Webinar]
    
    F1 & F2 & F3 & F4 & F5 & F6 & F7 & G1 & G2 & G3 & G4 --> H{What lifecycle stage?}
    
    H --> H1[Enablement]
    H --> H2[Pre-Sales]
    H --> H3[Implementation]
    H --> H4[Adoption]
    H --> H5[Growth]
    
    H1 & H2 & H3 & H4 & H5 --> I{Which partner type?}
    
    I --> I1[Technology Partners]
    I --> I2[Services Partners]
    I --> I3[Channel Partners]
    I --> I4[Alliance Partners]
    
    I1 & I2 & I3 & I4 --> J{Which use case?}
    
    J --> J1[DevOps Transformation]
    J --> J2[Security & Compliance]
    J --> J3[Cloud Migration]
    J --> J4[CI/CD Implementation]
    J --> J5[Enterprise Agile Planning]
    
    J1 & J2 & J3 & J4 & J5 --> K[Add Metadata Tags]
    
    K --> L[Content Ready for Review]
    
    classDef privacy fill:#f9d5e5,stroke:#d64161
    classDef assetType fill:#eeeeee,stroke:#333333
    classDef lifecycle fill:#dcf3ff,stroke:#0096c7
    classDef partnerType fill:#d8f3dc,stroke:#2d6a4f
    classDef useCase fill:#fff1e6,stroke:#bc6c25
    classDef metadata fill:#f9f9f9,stroke:#666666
    
    class B,C,D privacy
    class E,F,G,F1,F2,F3,F4,F5,F6,F7,G1,G2,G3,G4 assetType
    class H,H1,H2,H3,H4,H5 lifecycle
    class I,I1,I2,I3,I4 partnerType
    class J,J1,J2,J3,J4,J5 useCase
    class K metadata
```

---

## Example Content Categorisation

This section provides examples of properly categorised content to serve as a reference for content creators and reviewers.

### Example 1: Technical Webinar

| Category | Selection |
|----------|-----------|
| **Content Privacy** | Partner External |
| **Asset Type** | Technical Webinar \> Ultimate |
| **Lifecycle Stage** | Implementation |
| **Partner Type** | Services Partners |
| **Use Case** | CI/CD Implementation |
| **Metadata Tags** | GitLab 16.5, June 2024, Technical Audience, Premier Tier, English |

**Description**: "GitLab Ultimate CI/CD Pipeline Optimisation Webinar"

### Example 2: Partner Playbook

| Category | Selection |
|----------|-----------|
| **Content Privacy** | Partner Internal |
| **Asset Type** | Partner Internal Presentations |
| **Lifecycle Stage** | Pre-Sales |
| **Partner Type** | Channel Partners |
| **Use Case** | DevOps Transformation |
| **Metadata Tags** | GitLab 16.3, April 2024, Sales Audience, All Tiers, English |

**Description**: "GitLab DevOps Assessment Framework and Pricing Strategy"

### Example 3: Customer Solution Briefing

| Category | Selection |
|----------|-----------|
| **Content Privacy** | Partner External |
| **Asset Type** | Solution Briefing \> EMEA |
| **Lifecycle Stage** | Growth |
| **Partner Type** | Technology Partners |
| **Use Case** | Security & Compliance |
| **Metadata Tags** | GitLab 16.4, May 2024, Executive Audience, Select Tier, French |

**Description**: "Financial Services Security Compliance with GitLab & Partner X"

### Example 4: Integration Guide

| Category | Selection |
|----------|-----------|
| **Content Privacy** | Partner External |
| **Asset Type** | Field Guide |
| **Lifecycle Stage** | Implementation |
| **Partner Type** | Technology Partners |
| **Use Case** | Cloud Migration |
| **Metadata Tags** | GitLab 16.6, July 2024, Technical Audience, Premier Tier, English |

**Description**: "GitLab & Cloud Provider X Migration Implementation Guide"

### Example 5: Training Workshop

| Category | Selection |
|----------|-----------|
| **Content Privacy** | Partner Internal |
| **Asset Type** | Digital Rooms/Template |
| **Lifecycle Stage** | Enablement |
| **Partner Type** | Services Partners |
| **Use Case** | Enterprise Agile Planning |
| **Metadata Tags** | GitLab 16.5, June 2024, Technical Audience, Select Tier, English |

**Description**: "GitLab Enterprise Agile Planning Workshop Materials"

---
