---
title: "SLSA Level 3 Provenance Attestations ADR 001: Verification Component"
toc_hide: true
---

## Context

GitLab is implementing SLSA Level 3 compliance features for CI/CD pipelines. A key aspect of this implementation is the generation and verification of attestations that provide evidence of build provenance. The initial design documented the creation of a reusable GitLab CI component for generating and signing SLSA-compliant provenance, but lacked a clear separation between the attestation generation and verification processes.

SLSA (Supply-chain Levels for Software Artifacts) attestations provide cryptographic proof about how artifacts were created. Verification Summary Attestations (VSAs) are separate documents that record the results of verifying these attestations against a policy.

## Problem Statement

The current design has the following issues:

Lack of separation of concerns: The same component that generates and signs the provenance attestation also creates the Verification Summary Attestation (VSA).
Verification is not truly independent: When the same component generates both the attestation and VSA, there's no true validation that the attestation meets SLSA L3 requirements.
Pipeline structure doesn't reflect real-world usage: In production environments, artifact publishing and verification often occur in separate stages or even separate pipelines.

##  Options Considered

### Option 1: Single Unified Component

Description: Keep a single component that handles both attestation generation and verification.

Pros:

- Simpler implementation
- Fewer components to maintain
- Less pipeline overhead

Cons:

- No true separation of concerns
- he VSA doesn't represent an independent verification
- Doesn't align with enterprise CI/CD practices where build and verification are often separate processes

### Option 2: Split Functionality into Separate Components

Description: Create two distinct components:

- A provenance-signer component that generates and signs the SLSA attestation
- A provenance-verifier component that verifies attestations and generates VSAs

Pros:

- Clear separation of concerns
- The VSA truly represents an independent verification
- Aligns with enterprise CI/CD practices
- Better security through independent verification
- Enables using different environments or permissions for signing vs verification
- Supports future workflows where verification might happen in different contexts (e.g., artifact repository consumption)

Cons:

- More components to maintain
- Slightly more complex pipeline configuration
- Additional pipeline stage required

### Option 3: Integrated Component with Optional Verification

Description: Keep a single component but make verification an optional step.

Pros:

- Flexibility for different use cases
- Simpler for basic scenarios

Cons:

- Still lacks true separation of concerns
- Confusing configuration options
- Doesn't encourage best practices

## Decision

We have decided to implement `Option 2: Split Functionality into Separate Components`. This decision provides several advantages:

1. Security Improvement: By separating the generation and verification of attestations, we enable a more robust security model where the verification process is truly independent.
1. Real-world Alignment: This structure better aligns with enterprise CI/CD practices where artifacts might be built, signed, published, and later verified in separate processes.
1. Future Flexibility: The separated components provide flexibility for future enhancements:
   1. Different identities could be used for signing vs. verification
   1. Verification could happen in different environments (e.g., during deployment)
   1. Different policies could be applied during verification
1. Proper VSA Semantics: The Verification Summary Attestation becomes what it claims to be - a summary of an independent verification process, not just an extension of the attestation generation.
1. Clear Responsibility Boundaries: Each component has a clear, singular responsibility which aligns with good software design principles.

## Open Questions

- Should the verification component be configurable to verify against different SLSA levels?
- What specific SLSA L3 requirements should be checked during verification?
- Should the VSA be signed as well? If so, with what identity?
- How will we handle verification failures in downstream processes?
