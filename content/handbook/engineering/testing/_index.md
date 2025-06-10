---
title: Testing
---

Welcome to the Testing Guide. Pages in this section provides information about
testing practices, methodologies, and tools used in our development workflow.
Effective testing is crucial for maintaining code quality, preventing
regressions, and ensuring that our software meets requirements.

## Introduction to Testing at GitLab

This introduction provides new engineers with an
overview of our testing philosophy, practices, and the support available to help
you contribute effectively to our quality engineering efforts.

## How We Test

### Our Testing Philosophy

At GitLab, we believe that quality is everyone's responsibility, and testing is
integrated into every stage of our development process rather than being a
separate phase. Our approach is built on industry best practices and GitLab's
core values.

**Test Pyramid Approach**: [We champion the concept of the test pyramid](https://docs.gitlab.com/development/testing_guide/testing_levels/),
prioritizing fast, reliable tests at the base (unit tests) while using fewer,
more focused tests at higher levels (integration and end-to-end). This approach
gives us:

- Rapid feedback during development
- Reliable detection of regressions
- Efficient use of CI/CD resources
- Maintainable test suites

**Strategic Testing Focus**: Our testing strives to consider risk analysis and
input on test strategy, helping us focus testing efforts on critical user
journeys and high-impact areas. We make strategic decisions about where to
invest our testing efforts based on user impact and business needs.

**Quality Gates**: Testing is embedded throughout our [product development
workflow](https://handbook.gitlab.com/handbook/product-development-flow/):

- Pre-commit hooks for immediate feedback
- [Merge request pipelines with mandatory code reviews](https://handbook.gitlab.com/handbook/engineering/workflow/code-review/)
  that must pass before code integration
- Deployment pipelines with comprehensive test suites
- Post-deployment monitoring and validation

### Testing Ownership Model

**Everyone Tests**: While we have dedicated Test Governance team and greater
Developer Experience department, every developer is responsible for writing and
maintaining tests for their code. These members are there for supporting
developers in creating comprehensive test coverage that includes:

- Writing unit tests for new functionality
- Adding integration tests for API endpoints and service interactions
- Contributing to end-to-end test coverage for critical user flows
- Maintaining and fixing flaky or outdated tests

**Test Governance Support**: Our Test Governance team provides:

- Testing infrastructure and tooling through [Developer Experience teams](https://handbook.gitlab.com/handbook/engineering/infrastructure-platforms/developer-experience/)
- [Collaboration with Engineering Productivity's support for development workflows](https://handbook.gitlab.com/handbook/engineering/infrastructure/engineering-productivity/)
- Guidance on testing strategies and best practices
- Support for complex testing scenarios
- Test automation frameworks and libraries

## When We Test

### Development Workflow Integration

**Testing Early and Often**: We encourage writing tests alongside feature
development to ensure clear requirements understanding, better code design,
and comprehensive coverage from the start.

**Continuous Integration**: Every merge request triggers automated testing:

- Unit and integration tests run on every commit
- Feature tests execute for UI changes
- Performance tests validate critical paths
- Security scans check for vulnerabilities

### Release and Deployment Testing

**Pre-Deployment Validation**: Before code reaches production:

- Smoke tests verify basic functionality
- Performance tests ensure acceptable response times
- End-to-end tests validate critical user journeys
- Canary deployments allow gradual rollout with monitoring

**Production Monitoring**: Testing doesn't stop at deployment. [GitLab's
Observability teams deliver world-class monitoring capabilities](https://handbook.gitlab.com/handbook/engineering/infrastructure/team/observability/)
including:

- Synthetic monitoring simulating user interactions
- Performance monitoring tracking application health
- Error tracking identifying issues in real-time
- Feature flag testing enabling safe experimentation

## Testing Tools and Frameworks

### Unit Testing

**Purpose**: Validate individual components and business logic in isolation

- **Ruby**: [RSpec for backend unit tests](https://docs.gitlab.com/development/testing_guide/best_practices/)
  with comprehensive test design guidelines
- **JavaScript**: [Jest for frontend unit tests](https://docs.gitlab.com/development/testing_guide/frontend_testing/)
  with integration testing capabilities
- **Focus**: Fast execution, isolated testing, comprehensive coverage of
  business logic

### Integration Testing

**Purpose**: Verify interactions between different parts of the system

- **API Testing**: [RSpec request specs for API endpoints](https://docs.gitlab.com/development/testing_guide/testing_levels/#integration-tests)
- **Contract Testing**: Validate service interfaces and data contracts
- **Database Integration**: Test data layer interactions and migrations
- **Focus**: Service boundaries, data flow, integration points

### System and Feature Testing

**Purpose**: Test complete user workflows and application behavior

- **Capybara**: [Rails-based feature testing with browser simulation](https://docs.gitlab.com/development/testing_guide/frontend_testing/#feature-tests)
  for end-to-end integration testing
- **Playwright**: Modern end-to-end testing for complex user interactions
- **Focus**: User journeys, UI functionality, cross-browser compatibility

### Performance Testing

**Purpose**: Ensure application performance meets user expectations

- **GitLab Browser Performance Tool (GBPT)**: [Our frontend performance testing
  capabilities](https://handbook.gitlab.com/handbook/engineering/infrastructure-platforms/developer-experience/performance-enablement/browser-performance-testing/)
  for validating application performance
- **Load Testing**: Validate system behavior under expected traffic
- **Memory and Resource Testing**: Monitor application resource usage
- **Focus**: Response times, scalability, resource efficiency

### Specialized Testing Tools

- **Security Testing**: [Application Security Testing capabilities](https://handbook.gitlab.com/handbook/engineering/development/sec/secure/)
  including SAST, DAST, and vulnerability scanning

## Support Available

### Getting Help with Testing

**Request for Help Process**: When you need testing support or guidance, use
our established request process:

- Create an issue using the [testing support template](https://gitlab.com/gitlab-org/quality/test-governance/request-for-help)
- Include context about your testing challenges or requirements
- Expect response within our defined SLA timeframes

### Test Governance Teams

**Developer Experience Department**: [Provides testing infrastructure, tools,
and frameworks](https://handbook.gitlab.com/handbook/engineering/infrastructure-platforms/developer-experience/)
including:

- Testing pipeline optimization
- Test automation libraries and utilities
- CI/CD testing infrastructure
- Performance testing capabilities

**Test Governance Team**: Support specific product areas with:

- Testing strategy guidance
- Complex test scenario design
- Flaky test investigation and resolution
- Test coverage analysis and recommendations

**On-Call Support**: [Engineering teams participate in incident management
rotations](https://handbook.gitlab.com/handbook/engineering/on-call/) to ensure
rapid response to production issues

### Self-Service Resources

**Documentation and Guides**:

- [Testing Levels and Strategy](https://docs.gitlab.com/development/testing_guide/testing_levels/) -
  Detailed technical implementation guide
- [Testing Best Practices](https://docs.gitlab.com/development/testing_guide/best_practices/) -
  Coding standards and patterns
- [Code Review Guidelines](https://handbook.gitlab.com/handbook/engineering/workflow/code-review/) -
  Mandatory review process for all merge requests
- Internal testing guidelines and examples

**Community and Communication**:

- Testing-focused Slack channels for questions and discussions

**Tooling and Automation**:

- Test generators and templates for common scenarios
- [Automated workflow tooling](https://handbook.gitlab.com/handbook/engineering/infrastructure/engineering-productivity/workflow-automation/)
  for issue and MR triage
- CI/CD pipeline templates with testing best practices
- Performance and coverage monitoring dashboards

### Contributing to Testing Excellence

As you grow in your role at GitLab, consider contributing to our testing
culture by:

- Sharing testing patterns and solutions with the team
- Contributing to testing tools and frameworks
- Mentoring other developers on testing practices
- Participating in testing strategy discussions and improvements

### Types of Testing

The GitLab application is testing through a combination of automated tests,
following the [test pyramid levels](https://docs.gitlab.com/development/testing_guide/testing_levels/)

---

*For detailed technical implementation guidance, refer to our comprehensive
[Development Testing Guide](https://docs.gitlab.com/development/testing_guide/).
For immediate testing support, use our [request for help process](https://gitlab.com/gitlab-org/quality/test-governance/request-for-help).*
