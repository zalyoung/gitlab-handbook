---
title: "Testing related training resources"
---

## Introduction

A collection of resources to help you understand, write, and debug tests at GitLab. Whether you're new to testing or looking to deepen your knowledge of our testing infrastructure, these materials will guide you through best practices and practical techniques.

## General Testing Resources

Essential resources that apply across all testing types at GitLab.

### Documentation

- [GitLab Testing Guide](https://docs.gitlab.com/development/testing_guide)
- [Testing Best Practices](https://docs.gitlab.com/development/testing_guide/best_practices)
- [Testing Levels](https://docs.gitlab.com/development/testing_guide/testing_levels) - Understanding the testing pyramid
- [Testing Rake Tasks](https://docs.gitlab.com/development/testing_guide/testing_rake_tasks/)
- [Testing Rails migrations](https://docs.gitlab.com/development/testing_guide/testing_migrations_guide/)

## Testing Categories

### End-to-End Testing

Learn how GitLab's end-to-end testing framework ensures our application works correctly from a user's perspective.

#### 📹 GitLab End-to-End Testing Overview (Video)

<div class="video-container">
  <iframe src="https://www.youtube.com/embed/KbQzrVJMvNQ" allowfullscreen></iframe>
</div>

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

**Resources mentioned in the video:**

- [Presentation Slides](https://docs.google.com/presentation/d/1eYLuTdSpI-H0ZalzoqH7Ee8cprjmL1FNoV0XwRPY4-4/edit?usp=sharing)
- [End-to-End Testing Guide](https://docs.gitlab.com/development/testing_guide/end_to_end/)
- [Running End-to-End tests against your GDK](https://docs.gitlab.com/development/testing_guide/end_to_end/debugging_end_to_end_test_failures/#run-the-test-against-your-gdk)
- [Testing with Feature Flags](https://docs.gitlab.com/development/testing_guide/end_to_end/best_practices/feature_flags/)
- [Supported End-to-End test Environment Variables](https://gitlab.com/gitlab-org/gitlab-qa/blob/master/docs/what_tests_can_be_run.md#supported-gitlab-environment-variables)
