---
title: Articles
description: Operations workflow page for agent articles
canonical_path: "/handbook/security/customer-support-operations/workflows/zendesk/articles"
---

{{% alert title="Note" color="primary" %}}

Article changes are classified as ad-hoc. Once changes are made to the repo, they sync to Zendesk.

{{% /alert %}}

## Creating an article

For the creation of articles, the requester would utilize the Support Super Form. A submission from there will provide the processor all the information it needs to fully create the article in the repo.

## Modifying an article

This should be a rare situation and should only apply when the _title_ or _metadata_ of an article requires an update. Any other edits (like to the content) are handled via the corresponding managed content file.

### Updating the metadata

For these, you will need to locate the corresponding article file in the sync repo and make changes to it. You should also do this in a way that creates a MR. Said MR should always be peer reviewed before merging (the MR should enforce this).

### Updating the title

As the sync is based off the articles title, this is a bit more specific of a task. We need to update the title in the Zendesk instance(s) manually and update the sync repo files. 

## Deleting an article

Here you will delete the sync repo file (or likely files) and then remove the article in thhe corresponding Zendesk instance(s) (see [Deleting an article](../../docs/zendesk/articles/#deleting-an-article)).

## Repo links

- [Zendesk Global sync repo](https://gitlab.com/gitlab-support-readiness/zendesk-global/articles)
- [Zendesk US Government sync repo](https://gitlab.com/gitlab-support-readiness/zendesk-us-government/articles)
- [Managed content repo](https://gitlab.com/gitlab-com/support/suport-pages)
