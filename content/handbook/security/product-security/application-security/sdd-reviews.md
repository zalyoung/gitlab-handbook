---
title: "Secure Design & Development Reviews"
description: Details about different types of Secure Design & Development reviews.
---

## Secure Design and Development Review

Secure Design and Development (SDD) Review is a comprehensive review of a product feature for identifying security issue in design and implementation of a product feature and identify oppurtunites for defence in depth and security hardening. The review happens in tandem with the feature development from design pahse to implementation phase. The SDD review is initiated by the Security review framework. The Risk score of the feature determined by the Security review framework determines which componets of the SDD reviwes are appropriate for a feature.

### Roles and Responsibilites

The two main stake holders in SDD reviews are product and product security team.

#### Product team

The team owning the feature should proactively initiate a security review for features which require a review or attention from security team by following the [process](../../security-review-framework.md#overall-process-flow). This is primarily the responsibility of the team's Engineering Manager(s) and the Engineer(s) working on the Issue / MR. Ideal trigger points (in order of preference) are when the Epic/Issue/MR is created/updated, when an engineering proposal is updated, or when an engineer is working on the MR.

Product team is also responsible to provide design documentation, data flow diagram and architecture blue prints of the feature.

#### Product Security

- SD&D: DRI for conducting the SDD review
- SPA: Support SD&D team by addressing consultation requests regarding security architecutre. This will be supported in a best effect basis.

### Components

The Secure Design and Development Review happens in 3 phases namely the SDX Design, SDX Code and SDX verify. Following is the differnet components of these reviews. 
#### SDX Design:

##### Design Review: 
This review involves the validation of architectural and design choices in the feature aganist against established security patterns to identify potential security security issues. This step also involves conducting a Threat modelling to identify security vulnerabilities in the design.

If the feature change involves focus areas of SPA team and DATA security team, please, involve corresponsing teams in the Design reviews for additional eyes or review consultation. Due to capacity constrains their support will be on a best effort basis.

An effective security design review typically follows these steps:
1. **Prepare** - Gather design documentation, data flow diagram and security requirements
1. **Validation** - Analysing components, interfaces, data flows, authentication mechanisms,  access controls and encryption strategies to validate whether they follows secure design patterns and use components recommend as part of Paved roads initiative. 
1. **Threat modelling** - Analyse the design from the shoes of an attacker to check if the design have required controls are in place to thwart security issues.
1. **Document findings** - Create comprehensive reports detailing recommendations.
1. **Follow up** - Ensure recommendations are implemented and conduct follow-up reviews as part of the Final Security review.

##### Delivarables:

1. Defense in depth design recommendations.
1. Security issues identified in Design review.
1. Threat model.

#### SDX Design Code:

##### Static analysis

This step include reviewing the implementation of the feature
    1. Static analysis - Software composition analysis, Static Application Security Testing, Manual/Automated code review.
1. SDX Verify
    1. Final Security Review
    1. Verify if Critical SDX:Design/SDX:Code vulnerabilities are remediated
    1. Dynamic Analysis/Penetration Testing

### Deliverables:
1. 








