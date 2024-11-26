---
title: "Gitlab Packager Onboarding"
description: "Overview of Gitlab packager and how to use it"
---

## Overview

### Architectural Overview

The Gitlab Packager project consists of:

1. The Packager toolchain as a container image for use in client build pipelines.
2. Package Repositories for distribution of public and private packages.
3. The Packager pipeline which moves packages to the repositories.
4. Deployment infrastructure for distribution of packages and authentication.

The full architecture can be found with the [architectural decision records](https://gitlab.com/gitlab-org/distribution/build-architecture/documentation/-/tree/main/architecture-decision-records/packager).

### Publishing a Package

To publish a package, the client will gain authorization to push to the Generic Package Registry, which is hosted with the Packager project. Packager will poll for new packages periodically, and automatically deploy them to the package repository.  

### Authenticating

To publish packages as an internal Gitlab team, contact the [distribution team](https://handbook.gitlab.com/handbook/engineering/infrastructure/core-platform/systems/distribution) for permission to push to the Generic Package Registry.

To pull private packages, contact [distribution team](https://handbook.gitlab.com/handbook/engineering/infrastructure/core-platform/systems/distribution) for basic authentication setup to the private package repository. Public packages are available to everyone.

## Onboarding

### Requesting Access

### Setting Up a Publishing Pipeline

