---
title: Coding Standards
description: Information on the coding standard for Operations
canonical_path: "/handbook/security/customer-support-operations/coding-standards/"
---

<sup>*Introduced via [gitlab-com/support/support-ops/support-ops-project#1963](https://gitlab.com/gitlab-com/support/support-ops/support-ops-project/-/issues/1963)*</sup>

This document attempts to define coding standards and best practices to follow for the GitLab Support Operations team. By utilizing these guidelines, we ensure consistency, maintainability, simplicity, and better collaboration within the team. All contributors to our projects are expected to follow these guidelines, unless a specific exception is agreed upon.

## General Principles

We believe the [GitLab core values](/handbook/values/) should guide all our coding decisions:

- Collaboration
  - Collaborate with teammates, review each other’s code, and share knowledge.
  - Always be open to feedback and improve your code based on it.
  - Ensure your contributions are readable and understandable to others on the team
- Results
  - Focus on the impact and effectiveness of the code.
  - Prioritize working solutions over perfect solutions (but try to avoid shortcuts that undermine quality)
- Efficiency
  - Write clear and maintainable code.
  - Strive for simplicity without sacrificing functionality.
- Transparency
  - Code should be easy to understand and accessible to all.
  - Document assumptions, choices, and design decisions clearly when needed.
- Iteration
  - Code should be flexible and easy to refactor.
  - We aim for continuous improvement and don't shy away from updating or reworking code when necessary.

## Naming Conventions

- Variables
  - Use descriptive names that clearly convey the purpose of the variable. If the name of the variable does not clearly convey the purpose, then add a comment on the code to explain it better.
  - All variable names should use snake case:
    - Examples: `sum_of_pairings`, `gitlab_user`
- Constants
  - Use descriptive names that clearly convey the purpose of the constant. If the name of the constant does not clearly convey the purpose, then add a comment on the code to explain it better.
  - Constants should be written in upper snake case:
    - Examples: `MAX_RETRIES`, `DEFAULT_TIMEOUT`
- Functions and Methods
  - Function and method names should describe the action they perform. If the name of the function/method does not clearly convey the purpose, then add a comment on the code to explain it better.
  - Function and method names should be written in snake case"
    - Examples: `my_new_function`, `check_gitlab_user`
- Classes and Modules
  - Classes and modules should be written in PascalCase:
    - Examples: `AccountBlocked`, `SupportSuperFormProcessor`
- Filenames
  - All filenames should use snake case:
    - Examples: `process_account`, `compare_only`

## Code Formatting

- Indentation
  - Use 2 spaces per indentation level whenever possible.
    - Example:

      ```ruby
      def self.subscriptions
        @subscriptions ||= Readiness::GitLab::Namespaces.subscription(client, namespace)
      end
      ```

- Line length
  - Keep lines of code to a maximum length of 80-120 characters (80 characters preferred). This ensures readability and allows code to fit comfortably in most environments.
- Blank lines
  - Use blank lines to separate functions, classes, and logically related code blocks
  - Use a single blank line between method definitions
- Spacing
  - Use a single space between operators (e.g. `+`, `<`, `=`, etc.)

## Comments and Documentation

- Inline comments
  - Use inline comments sparingly. Only use them to clarify complex or non-obvious code. If you are needing a large number of comments, you are probably overcomplicating your code!
  - Keep comments up to date and relevant to the code they describe.

## Code Complexity

- Avoid deeply nested code. Refactor code to use helper functions or early returns if nesting becomes too complex.
- Limit function size. Each function should have a clear, single responsibility and be relatively small (under 30 lines).

## Testing

Always aim for high test coverage! When in doubt, test your code thoroughly!

## Version control

- Commit messages
- Branches
  - The format of a branch should follow the format of `USERNAME-PROJECT-IID`,
    where:
    - `USERNAME` is your gitlab.com username
    - `PROJECT` is the project's slug
    - `IID` is the issue's IID
    - Example:
      - For branch `jcolyer` is creating for the work of issue `https://gitlab.com/gitlab-com/support/support-ops/support-ops-project/-/issues/1963`, your branch name should be `jcolyer-support-ops-project-1963`
  - The exception to this is branches for the [GitLab Support Readiness Gem](https://gitlab.com/gitlab-support-readiness/gitlab_support_readiness_gem), which should always use the format `vXX.YY.ZZ`, where `XX.YY.ZZ` is the version of the gem you are working on.

## Error Handling

Whenever possible, have your code gracefully handle errors. Where this is not possible, ensure the errors clearly explain what the problem is (and bonus points if they tell you what to do about it).

## Performance Considerations

- Focus on performance only after your code is functional and maintainable. Avoid premature optimization.
- Measure performance impacts using profiling tools and identify bottlenecks before optimizing.
- Use common sense to reduce API calls to our tooling.
  - Example: While you could manually fetch every ticket from Zendesk one by one, there is no logical reason to when the Readiness Gem will do this efficiently using the `list` method.

## Security

- Validate all inputs to prevent injection attacks (e.g., SQL Injection, XSS).
- Never store passwords, tokens, etc. in plaintext. Use CI/CD variables.

## Code Reviews

- All code must undergo peer review before merging. Ensure reviews are thorough and address quality, consistency, and security.
- Embrace constructive feedback and improve the code collaboratively.

## Language specific guidelines

### Ruby

- Whenever possible, utilize the [GitLab Support Readiness Gem](https://gitlab.com/gitlab-support-readiness/gitlab_support_readiness_gem)
- Whenever possible, try to ensure your code presents no issues when run via the [rubocop](https://rubygems.org/gems/rubocop) linter.

## Examples to help you get started

### Writing a ruby script

When writing a ruby script, you should always start it with:

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

require 'support_readiness'
```

This ensures you can start coding on the very next line and have all the dependencies you might need.

### Connecting to Zendesk via ruby

When you need to connect to Zendesk, utilize the [GitLab Support Readiness Gem](https://gitlab.com/gitlab-support-readiness/gitlab_support_readiness_gem) by doing the following:

```ruby
require 'support_readiness'

zendesk_config = Readiness::Zendesk::Configuration.new
zendesk_config.username = ENV.fetch('ZD_USERNAME')
zendesk_config.token = ENV.fetch('ZD_TOKEN')
zendesk_config.url = ENV.fetch('ZD_URL')
zendesk_client = Readiness::Zendesk::Client.new(zendesk_config)
```

For the above example, the environment variables translate to:

- `ZD_USERNAME`: The email address of the user making the connection. Take note you do not put `/token` or anything at the end (the gem will handle this for you).
- `ZD_TOKEN`: The API token being used to connect to Zendesk
- `ZD_URL`: The API URL. This should be one of the following values:
  - Zendesk Global: `https://gitlab.zendesk.com/api/v2`
  - Zendesk Global Sandbox: `https://gitlab1707170878.zendesk.com/api/v2`
  - Zendesk US Government: `https://gitlab-federal-support.zendesk.com/api/v2`
  - Zendesk US Government Sandbox: `https://gitlabfederalsupport1585318082.zendesk.com/api/v2`

### Connecting to GitLab.com via ruby

When you need to connect to gitlab.com, utilize the [GitLab Support Readiness Gem](https://gitlab.com/gitlab-support-readiness/gitlab_support_readiness_gem) by doing the following:

```ruby
require 'support_readiness'

gitlab_config = Readiness::GitLab::Configuration.new
gitlab_config.token = ENV.fetch('GL_TOKEN')
gitlab_client = Readiness::GitLab::Client.new(gitlab_config)
```

For the above example, the environment variables translate to:

- `GL_TOKEN`: The API token being used to connect to gitlab.com

### Connecting to Slack via ruby

When you need to connect to Slack, utilize the [GitLab Support Readiness Gem](https://gitlab.com/gitlab-support-readiness/gitlab_support_readiness_gem) by doing the following:

```ruby
require 'support_readiness'

slack_config = Readiness::Slack::Configuration.new
slack_config.url = ENV.fetch('SLACK_URL')
slack_client = Readiness::Slack::Client.new(slack_config)
```

For the above example, the environment variables translate to:

- `SLACK_URL`: The webhook URL to use in the connection

### Connecting to Redis via ruby

When you need to connect to Redis, utilize the [GitLab Support Readiness Gem](https://gitlab.com/gitlab-support-readiness/gitlab_support_readiness_gem) by doing the following:

```ruby
require 'support_readiness'

redis_client = Readiness::Redis.new(
  ENV.fetch('REDIS_HOST'),
  ENV.fetch('REDIS_PORT'),
  ENV.fetch('REDIS_PASSWORD')
)
```

For the above example, the environment variables translate to:

- `REDIS_HOST`: The hostname used to connect to Redis
- `REDIS_PASSWORD`: The password used to connect to Redis
- `REDIS_PORT`: The port used to connect to Redis

### Connecting to Salesforce via ruby

When you need to connect to Salesforce, utilize the [GitLab Support Readiness Gem](https://gitlab.com/gitlab-support-readiness/gitlab_support_readiness_gem) by doing the following:

```ruby
require 'support_readiness'

salesforce_config = Readiness::Salesforce::Configuration.new
salesforce_config.api_version = '58.0'
salesforce_config.client_id = ENV.fetch('SFDC_CLIENTID')
salesforce_config.client_secret = ENV.fetch('SFDC_CLIENTSECRET')
salesforce_config.password = ENV.fetch('SFDC_PASSWORD')
salesforce_config.security_token = ENV.fetch('SFDC_SECURITYTOKEN')
salesforce_config.username = ENV.fetch('SFDC_USERNAME')
salesforce_client = Readiness::Salesforce::Client.new(salesforce_config)
```

For the above example, the environment variables translate to:

- `SFDC_CLIENTID`: The client ID used to connect to Salesforce
- `SFDC_CLIENTSECRET`: The client secret token used to connect to Salesforce
- `SFDC_HOST`: The hostname used to connect to Salesforce
- `SFDC_PASSWORD`: The password used to connect to Salesforce
- `SFDC_SECURITYTOKEN`: The security token used to connect to Salesforce
- `SFDC_USERNAME`: The username used to connect to Salesforce

### Connecting to Mailgun via ruby

When you need to connect to Mailgun, utilize the [GitLab Support Readiness Gem](https://gitlab.com/gitlab-support-readiness/gitlab_support_readiness_gem) by doing the following:

```ruby
require 'support_readiness'

mailgun_config = Readiness::Mailgun::Configuration.new
mailgun_config.domain = ENV.fetch('MAILGUN_DOMAIN')
mailgun_config.token = ENV.fetch('MAILGUN_KEY')
mailgun_client = Readiness::Mailgun::Client.new(mailgun_config)
```

For the above example, the environment variables translate to:

- `MAILGUN_DOMAIN`: The domain within Mailgun to use
- `MAILGUN_KEY`: The API token being used to connect to Mailgun
