---
title: "Testing-related training resources"
description: A collection of resources to help you understand, write, and debug tests at GitLab. Whether you're new to testing or looking to deepen your knowledge of our testing infrastructure, these materials will guide you through best practices and practical techniques.
---

## General Testing Resources

Essential resources that apply across all testing types at GitLab.

### Documentation

- [GitLab Testing Guide](https://docs.gitlab.com/development/testing_guide) -  Guidelines for automated testing of the GitLab project
- [GitLab Testing Best Practices](https://docs.gitlab.com/development/testing_guide/best_practices) - Everything you should know about how to write good tests in the GitLab project
- [GitLab Testing Levels](https://docs.gitlab.com/development/testing_guide/testing_levels) - Learn about the different testing levels in the GitLab project, and how to decide at what level your changes should be tested
- [The Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html) - A deep dive into the "Test Pyramid"

## Testing Categories

### Frontend Testing

- [Getting Started With Feature Specs](https://docs.gitlab.com/development/testing_guide/frontend_testing/#get-started-with-feature-tests) - How to write feature specs in the GitLab project
- [Vue 3 Testing](https://docs.gitlab.com/development/testing_guide/testing_vue3/) - Testing in Vue 3 mode

### End-to-End Testing

Learn how GitLab's end-to-end testing framework ensures our application works correctly from a user's perspective.

- [End-to-End Testing Guide](https://docs.gitlab.com/development/testing_guide/end_to_end/) - End-to-end testing in the GitLab project
- [End-to-End Testing Best Practices](https://docs.gitlab.com/development/testing_guide/end_to_end/best_practices/) - Best practices when writing End-to-end tests in the GitLab project
- [Running End-to-End tests against your GDK](https://docs.gitlab.com/development/testing_guide/end_to_end/debugging_end_to_end_test_failures/#run-the-test-against-your-gdk)
- [End-to-End Testing with Feature Flags](https://docs.gitlab.com/development/testing_guide/end_to_end/best_practices/feature_flags/)
- [Supported End-to-End Test Environment Variables](https://gitlab.com/gitlab-org/gitlab-qa/blob/master/docs/what_tests_can_be_run.md#supported-gitlab-environment-variables)

#### 📹 GitLab End-to-End Testing Overview (Video)

<figure class="video_container">
  <iframe src="https://www.youtube.com/embed/KbQzrVJMvNQ" frameborder="0" allowfullscreen="true"> </iframe>
</figure>

**Duration:** ~30 minutes
**Level:** Beginner to Intermediate

This video covers:

- 📁 [Directory structure and test organization](https://www.youtube.com/watch?v=KbQzrVJMvNQ&t=150)
- 🕵️ [Finding and understanding existing tests](https://www.youtube.com/watch?v=KbQzrVJMvNQ&t=322)
- 🤿 [Deep dive into E2E test architecture](https://www.youtube.com/watch?v=KbQzrVJMvNQ&t=399)
- 📍 [Where E2E tests run in our infrastructure](https://www.youtube.com/watch?v=KbQzrVJMvNQ&t=978)
- 🐛 [Debugging test failures from merge requests](https://www.youtube.com/watch?v=KbQzrVJMvNQ&t=1084)
- 🚩 [Working with feature flags in tests](https://www.youtube.com/watch?v=KbQzrVJMvNQ&t=1406)
- 🔧 [Troubleshooting common failure issues](https://www.youtube.com/watch?v=KbQzrVJMvNQ&t=1552)
- 💻 [Running tests locally in your GDK](https://www.youtube.com/watch?v=KbQzrVJMvNQ&t=1721)

- [Presentation Slides](https://docs.google.com/presentation/d/1eYLuTdSpI-H0ZalzoqH7Ee8cprjmL1FNoV0XwRPY4-4/edit?usp=sharing)

### Database Testing

- [Testing Rails migrations](https://docs.gitlab.com/development/testing_guide/testing_migrations_guide/) - Everything you should know about how to test migrations

### Testing Rake Tasks

- [Testing Rake Tasks](https://docs.gitlab.com/development/testing_guide/testing_rake_tasks/) - Everything you should know about how to test Rake tasks in the GitLab project
