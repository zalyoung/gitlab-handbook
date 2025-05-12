---
title: Setting up external secret storage with Vault
description: Process outline on how to setup external secrets storage as a secure alternative to environment variables.
---

# Using HashiCorp Vault for Secret Management in GitLab CI/CD

## Overview

This guide explains how to use HashiCorp Vault as an external secrets manager for your GitLab CI/CD pipelines. Properly managing secrets such as API keys and passwords is critical for maintaining security in your projects.

## Why Use External Secrets?

Secrets are credentials like API keys and passwords that should be kept unknown or unseen by others. While GitLab CI has a built-in variable area with [masking capability](https://docs.gitlab.com/ee/ci/variables/#mask-a-cicd-variable), this feature has limitations:

> **Warning:** Masking a CI/CD variable is not a guaranteed way to prevent malicious users from accessing variable values. The masking feature is "best-effort" and there to help when a variable is accidentally revealed. To make variables more secure, consider using external secrets.

Secret exposure from CI job logs can result in security incidents and may qualify for bug bounty payouts. When you print a masked variable using a script, the masking may not work as expected or may be circumvented depending on how it is called. External Secret Storage (ESS) fixes that by taking the storage of the sensitive variable out of the loop.

## HashiCorp Vault Integration

HashiCorp Vault is one of three [supported](https://docs.gitlab.com/ee/ci/secrets/#supported-secret-providers) external secrets solutions for GitLab:

1. HashiCorp Vault
2. Google Cloud Secrets Manager (requires GitLab 16.8+, released January 2024)
3. Azure Key Vault

The integration between Vault and GitLab works via a JWT-based authentication flow:

1. GitLab generates a JWT and provides it to the CI job
2. The CI runner authenticates with Vault using this JWT
3. Vault verifies the JWT and checks bounded claims
4. Vault returns a token to the runner
5. The runner reads secrets from Vault

## Setup Guide

### Prerequisites

- A GitLab project where you want to use external secrets
- Access to [GitLab's HashiCorp Vault instance](https://vault.gitlab.net)
- Proper permissions to create/manage access requests

> **Note:** GitLab (the product) has a [tutorial page available](https://docs.gitlab.com/ee/ci/secrets/), but for internal GitLab projects this may be overkill because our SRE team has a vault setup available already!

### Step 1: Access Request

1. Request an [Okta group](https://okta.com/) for your team to be created (no individual access)
2. The group will be added to the Vault application (standard process for IT teams)
3. Okta will need to be updated with a "group claim" to send your new group to HashiCorp Vault
4. Additional configuration will be performed on the SRE/HashiCorp Vault side

> **Note:** For GitLab internal users, refer to the [SRE internal runbook](https://internal-handbook.gitlab.io/handbook/engineering/infrastructure/team/reliability/vault.html) for detailed setup instructions.

### Step 2: Create the Terraform Configuration

HashiCorp Vault is configured via Terraform. Create the necessary configuration files based on examples or templates that might be available from GitLab's [security automation team](https://gitlab.com/gitlab-com/gl-security/security-automation).

### Step 3: Invite the Bot

The "gitlab-infra-mgmt-bot" (or equivalent in your case) needs to be an owner of your project group BEFORE merging the Terraform configuration. This bot automates [the CI variables](https://docs.gitlab.com/ee/ci/variables/) listed in the HashiCorp documentation.

### Step 4: Merge the Terraform Configuration

Submit and merge the Terraform configuration into your repository.

### Step 5: Set Up Secrets in Vault

1. Access your Vault instance through the web interface or CLI
2. Create a structure following the naming convention from your Terraform and project
   - For example:
     - Project URL: [`https://gitlab.com/gitlab-com/it/security/it-security-automation`](https://gitlab.com/gitlab-com/it/security/it-security-automation)
     - Vault URL path: `/ci/gitlab-com/gitlab-com/it/security/it-security-automation`
   - [View example of Vault navigation](https://vault.gitlab.net/)

### Step 6: Configure Environments

1. Determine which environments (dev, test, prod) you need to support
2. Create appropriate subfolders in Vault for each environment
   - All CI jobs have access to the "shared" subfolder by default
   - For protected branches, use the "protected/" subfolder

### Step 7: Create Secrets

Each ["secret"](https://www.vaultproject.io/docs/secrets) in Vault contains key:value pairs or a JSON object. Add your secrets with appropriate key names and values.

### Step 8: Access Secrets from CI/CD

Edit your `.gitlab-ci.yml` file to access the secrets from Vault:

```yaml
deploy:
  id_tokens:
    VAULT_ID_TOKEN:
      aud: https://vault.gitlab.net
  secrets:
    OKTA_TOKEN:
      file: false
      vault: ${VAULT_SECRETS_PATH}/shared/apikeys/okta@ci
    GOOGLE_SECRET:
      file: true
      vault: ${VAULT_SECRETS_PATH}/shared/google/googlekey@ci
```

Note the following:
- All secret paths must end with `@ci` for CI purposes
- Set `file: false` for simple variables
- Set `file: true` for secrets that should be converted to a file

### Step 9: Use Secrets in Your Scripts

For Python scripts, you can access the secrets as environment variables:

```python
# check if running in CI and get variables as required
if os.getenv("GITLAB_CI"):
    config.read(directory + '/config.template')
    gitlab_token = os.getenv('GITLAB_TOKEN')
else:
    config.read(directory + '/config.ini')
    gitlab_token = config['gitlab']['token']

gitlab_url = config['gitlab']['url']
headers = {"Private-Token": gitlab_token}
```


## Verification

You can verify that your secrets are being properly resolved by checking the CI output job. You should see log entries like:

```
Resolving secrets
Resolving secret "JAMF_USER"...
Using "vault" secret resolver...
Resolving secret "OKTA_TOKEN"...
Using "vault" secret resolver...
```

When printing sensitive values, they should appear as `[MASKED]` in the logs.

## Best Practices

1. Never store secrets directly in your code
2. Use the appropriate subfolder structure in Vault for different environments
3. Limit access to secrets through group-based permissions
4. Regularly rotate credentials stored in Vault
5. Use file-based secrets for more complex authentication configurations like service account JSON files

## Troubleshooting

If you encounter issues with Vault integration:

1. Check that the bot has proper permissions to your project
2. Verify the secret paths in your `.gitlab-ci.yml` match the structure in Vault
3. Ensure your Okta group has the correct permissions in Vault
4. Check CI job logs for error messages related to secret resolution

## Future Considerations

- We're not limited to Vault for ESS. Consider utilizing 1Password's API integration. You can find an excellent example [here](https://gitlab.com/gitlab-com/it/security/it-security-automation/-/blob/main/onepassword.py?ref_type=heads).
- Google Cloud Secrets Manager integration
- OAuth 2.0 API service with Proof of Possession (POP) for Okta-specific applications

## Related Resources

- [GitLab CI/CD Secrets Management Documentation](https://docs.gitlab.com/ee/ci/secrets/)
- [HashiCorp Vault Documentation](https://www.vaultproject.io/docs)
- [External Secrets with Terraform](https://docs.gitlab.com/ee/administration/terraform_state.html)
- [CI/CD Variables Documentation](https://docs.gitlab.com/ee/ci/variables/)
- [GitLab IT Security Automation Repository](https://gitlab.com/gitlab-com/it/security/it-security-automation)