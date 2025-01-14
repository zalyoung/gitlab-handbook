---
title: Customer Success Plans
description: Customer Success Plans are strategic documents that bridge pre-sales and post-sales activities, ensuring alignment between GitLab and customer objectives while providing clear documentation of evaluation, implementation, and success criteria.
---

## Overview

A Customer Success Plan (CSP) is a customer-facing and mutually agreed roadmap for achieving value through GitLab adoption. This plan starts in the pre-sales process and is designed to support shifting from product-scoped conversations (focusing on specific features or functions) towards solution or strategic scopes (shaping business outcomes through holistic organizational process innovation and transformation).

## Purpose

The CSP serves multiple key purposes:

1. For the **Customer**: Provides a prescriptive, phased approach to successful GitLab adoption, including architecture recommendations, deployment strategy, migration plans, integration approach, and user onboarding at scale.

2. For the **Customer Success Team**: Creates a foundation for the post-sales relationship by documenting objectives, success criteria, and milestones for the next 30, 60, 90 days and beyond.

3. For the **Professional Services Team**: Delivers context for scoping Statements of Work (SOW) based on outlined initiatives.

4. For the **Go-To-Market Team**: Serves as a source of truth when executives or customer support needs context about customer interactions and plans.

## When to Create a Success Plan

A Customer Success Plan should be initiated when:

1. An opportunity has completed Stage-3 Technical Evaluation with a technical win
2. First Order opportunities for accounts with LAM over $2M in Proposal stage (Stage-4) and beyond
3. All New or Growth Opportunities over $300k net ARR, in Proposal stage (Stage-4) and beyond
4. All existing customers with upcoming Renewals, over $300k in ARR basis

*Note: SA Managers have discretion for additional opportunities to be included or excluded.*

## Creating the Plan

The CSP is generated from our centralized account planning dataset (plan.yaml) and includes:

### Customer-Facing Elements

- Company background
- Business objectives and outcomes
- Key stakeholders and project team
- Current and desired state workflows
- Technical activities planned/completed
- Value outcome metrics
- Phased success plan and adoption journey
- Technical milestones (3/6/12 month)
- Architecture recommendations

### Tracking in Salesforce

The following fields must be maintained in Salesforce:

1. Customer Success Plan: URL to the plan
2. CSM Ready: Checked when plan is ready for CSM review
3. Customer Accepted: Checked after customer review

## Transition to Post-Sales

At the point of sale, the CSP transitions into post-sales execution. This transition varies based on the customer type:

### New Customer Transition

1. CSP is converted into a Mutual Success Plan (MSP)
2. MSP is implemented as GitLab Issues and Epics in a customer-facing GitLab project
3. Ownership transfers to the assigned Customer Success team member:
   - Customer Success Manager (CSM)
   - Customer Success Architect (CSA)
   - Customer Success Engineer (CSE)

### Existing Customer Growth

1. CSP content is evaluated against existing MSP
2. Relevant elements are merged into the existing MSP structure
3. New Epics/Issues are created to track additional objectives
4. Existing Customer Success team maintains ownership

### Implementation Details

The CSP content is transformed into actionable GitLab items:

- Success criteria become Epic success metrics
- Technical requirements translate to specific Issues
- Timeline milestones become Epic due dates
- Implementation phases are organized as Epic groups
- Customer stakeholders are added as project members

## Post-Sales Ownership

After the sale, ownership moves to the Customer Success organization. Based on the customer's tier and needs, the primary owner will be:

1. **Customer Success Manager (CSM)**
   - Manages overall customer relationship
   - Drives adoption and expansion strategy
   - Oversees MSP execution

2. **Customer Success Architect (CSA)**
   - Provides technical leadership
   - Guides architectural decisions
   - Supports complex implementations

3. **Customer Success Engineer (CSE)**
   - Handles technical implementation
   - Resolves technical blockers
   - Supports customer enablement

The Solutions Architect remains available for consultation during the transition period but is not responsible for MSP execution.

## Success Plan Review Cadence

1. Pre-Sales:
   - Regular reviews with customer during technical evaluation
   - Internal reviews with AE (and later CSM) for deals over threshold
   - Executive sponsor review for strategic accounts

2. Post-Sales:
   - Transition review with CSM/CSA/CSE
   - Regular cadence established by CS team
   - Quarterly business reviews as needed

## Resources

- [Mutual Customer Success Plan Information](https://gitlab.com/gitlab-sales-continuous-planning/gitlab-profile/-/blob/main/README.md)
- [Account Planning Data Schema](https://gitlab.com/gl-demo-ultimate-ryappleby/technical-close-plans/generators/-/blob/main/plan-schemas/accountPlan.schema.json)
- [Example Success Plans](https://gitlab.com/gl-demo-ultimate-ryappleby/customer-collab/customers)
