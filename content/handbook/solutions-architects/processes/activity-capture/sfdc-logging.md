---
title: Salesforce Field Logging Requirements
description: >-
  Comprehensive guide for Solutions Architects on required Salesforce fields, data capture requirements, and best practices
  for maintaining accurate opportunity tracking.
---

## Overview

Solutions Architects are responsible for maintaining several key fields in Salesforce to ensure accurate tracking of technical evaluations, customer engagements, and opportunity progress. This guide outlines the required fields and best practices for maintaining them.

## Required Fields

### Primary Fields

1. **Primary SA**
   - The primary Solutions Architect assigned to and working on the opportunity
   - Must be updated whenever SA assignment changes
   - Critical for accurate reporting and accountability

2. **SA Validated Tech Evaluation Start Date**
   - Marks the beginning of serious technical evaluation
   - Should reflect when customer explicitly starts evaluation of value
   - Requirements:
     - Must have SA engagement
     - Customer must be seriously evaluating GitLab
     - Simple demos or discovery do not qualify
   - Special note for Commercial: Should reflect trial start date when SA is engaged

3. **SA Validated Tech Evaluation End Date**
   - Marks the conclusion of technical evaluation
   - Should be set when evaluation is complete (win/loss) or stalled
   - Independent of final deal outcome
   - For Commercial: Should reflect trial end date when SA is engaged

4. **SA Validated Tech Evaluation Close Status**
   Options include:
   - **Win**: Customer agrees GitLab meets requirements
   - **Loss**: Customer choosing alternative solution
   - **Stalled**: No active evaluation for 2+ weeks
   
5. **SA Validated Tech Evaluation Close Details**
   - 1-2 line description explaining the close status
   - Should provide clear context for the outcome

### When to Update Fields

- Update fields as soon as status changes occur
- Don't wait until opportunity closes
- Keep fields current for accurate reporting
- Update through Rattle or directly in Salesforce

## Best Practices

### Field Updates

1. **Timing**
   - Update fields in real-time when possible
   - Don't backdate unless absolutely necessary
   - Keep current even if opportunity is early stage

2. **Accuracy**
   - Be precise with dates
   - Use clear, concise descriptions
   - Maintain consistency across opportunities

3. **Completeness**
   - Fill all required fields
   - Don't leave fields blank or TBD
   - Include relevant context

### Common Scenarios

1. **Multiple SAs**
   - Only one Primary SA
   - Others tracked through activity logging
   - Clear handoff process when changing Primary SA

2. **Stalled Evaluations**
   - Mark as stalled after 2 weeks of inactivity
   - Update status if evaluation resumes
   - Document reason in close details

3. **Commercial Trials**
   - Align with trial dates
   - Must have SA engagement
   - Track through completion

## Updating Closed Opportunities

If opportunity is closed and fields need updating:

1. Go to the opportunity
2. Click "Show Feed"
3. Tag @Sales-Support
4. Specify needed updates
5. Provide clear justification

Example message:

```
@Sales-Support please update the SA Validated Tech Evaluation Close Status to Won, 
and SA Validated Tech Evaluation End Date to 2024-01-14
```

## Validation Rules

- Start Date must be before End Date
- Close Status required if End Date is set
- Close Details required if Status is set
- Primary SA required for Stage 3+ opportunities

## Reporting & Analytics

These fields drive key reports:

- Technical Evaluation Dashboard
- SA Activity Analysis
- Win/Loss Analysis
- Pipeline Health Metrics

## Field Dependencies

Understanding how fields interact:

- Start Date enables End Date
- End Date requires Close Status
- Close Status requires Close Details
- All fields linked to Primary SA

## Quality Assurance

Regular checks for:

- Missing required fields
- Inconsistent dates
- Incomplete close details
- Accurate status updates

## Getting Help

- Contact Sales Support for closed opportunity updates
- Reach out to SA leadership for guidance
- Use #salesforce-help Slack channel
- Submit feedback through standard process
