---
title: "Organization Authentication"
owning-stage: "~devops::tenant scale"
group: Organizations
toc_hide: true
---

The current state of authentication in GitLab requires many features to be developed twice: once for GitLab.com top-level groups and once for self-managed instances. This duplication arises because GitLab.com often requires special treatment due to the lack of an isolated container for enterprise customers. As a result, we've built specialized features around top-level groups for authentication, account ownership, and user management.
By moving authentication to the Organization level, we can consolidate GitLab.com and self-managed authentication in one unified approach. This consolidation will resolve account ownership and management concerns on GitLab.com while providing feature parity across all deployment models. Organizations will serve as the natural boundary for authentication policies, user management, and administrative control, bringing the full GitLab experience to all platforms.

## GitLab as an Identity Provider

GitLab functions as an identity provider with support for both OAuth2 and OIDC. See [Organizations Identity Provider] (TODO) for details on how OAuth and OIDC will work with Organizations. 

## GitLab as a Service Provider

For all other purposes, GitLab functions as an authentication service provider, allowing users to sign-in using other third party identity providers such as with SAML, Google, Azure and more. See [OmniAuth documentation](https://docs.gitlab.com/integration/omniauth/) for more information. GitLab also provides local, standard database authentication when third-party integration is not needed. 

[SAML SSO (Group SAML) for GitLab.com](https://docs.gitlab.com/ee/user/group/saml_sso/) is a variation of self-managed SAML specific to GitLab.com. 

The end goal is to migrate all OmniAuth authentication and standard authentication support from both top-level group and self-managed instance levels to the Organization level. As we iterate toward this goal, it will be necessary to prioritize certain providers based on usage patterns and customer demand. For example, SAML and Group SAML are widely adopted and represent strong candidates for initial prioritization in the migration roadmap.

### Configuration

While OmniAuth providers are typically configured statically and loaded at startup, the Organization model requires dynamic configuration capabilities. Authentication provider configuration will transition from static configuration files in self-managed instances to dynamic Organization settings. The existing Group SAML provider already supports UI-based configuration and can serve as a foundation for this approach. Other authentication providers will need modifications to support dynamic configuration.

## Browser-based Authentication flow

### Unified sign-in page

This option utilizes a sign-in page similar to the current approach - https://gitlab.com/users/sign_in - but makes it Organization-aware.

As long as usernames remain globally unique, the sign-in page can route authentication requests based on the username. Many services accomplish this through a two-step sign-in process. 

1. The user specifies their username with no password field visible. 
1. If the user has no external identity provider configured, the password field appears. 
1. If the user has an external identity provider, they are:
    1. redirected to the appropriate third-party identity provider
    1. redirected to the Organization-specific sign-in page

### Organization-specific sign-in page

Once usernames are no longer globally unique we will likely need to rely on a path-based approach. 

1. When a user selects "Sign in with SSO" or some other "Organization SSO" designation we will ask the user for the Organization path. Display the base hostname/URL - `https://gitlab.com/` or whatever the base Organization path is (`https://gitlab.com/org/`, for example).
1. The user provides the path for their organization - `acme-corp`, for example. 
1. The user is redirected to the Organization-specific URL and is presented with all the authentication mechanisms enabled for that Organization.

Users can navigate directly to the Organization's URL to skip to step 3.
