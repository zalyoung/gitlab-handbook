---
title: Articles
description: Operations workflow page for agent articles
canonical_path: "/handbook/security/customer-support-operations/workflows/zendesk/articles"
---

{{% alert title="Note" color="danger" %}}

As of 2025-06-01, the GitLab Support team manages all articles via Zendesk itself.

The deprecated information has been kept intact for historical purposes.

{{% /alert %}}

We use Zendesk Guide for Knowledge base. The Knowledge base has 3 type of roles with different permissions:

Support Engineer, Knowledge Champions and Knowledge Admins.

- **Support Engineers**: Create, update and use KB articles in tickets.
- **Knowledge Champions**: Review, publish, archive and control permissions.
- **Knowledge Admins**: Make sure everything runs smoothly.

## Creating an article

All Support Team Members can create Articles in the knowledge base in **draft** mode. Knowledge Champions or Knowledge Admins
can approve and publish the articles. There is no requirement to file an issue for that. 
For the creation of articles,please see [Zendesk documentation](https://support.zendesk.com/hc/en-us/articles/4408839258778-Creating-and-editing-articles-in-the-knowledge-base#topic_bpt_tdq_cy).

## Modifying an article

All Support Team Members can modify Articles in the knowledge base in **draft** mode. Knowledge Champions or Knowledge 
Admins can approve and publish the updated articles. There is no requirement to file an issue for that.
For information on modifying an article, please see [Zendesk documentation](https://support.zendesk.com/hc/en-us/articles/4408839258778-Creating-and-editing-articles-in-the-knowledge-base#topic_1rt_tdq_cy).

## Archiving an article

Knowledge Champions can archive the article directly in the Zendesk Guide.
It is highly recommended that articles are archived before deletion. To see how to archive an article, please see 
[Zendesk documentation](https://support.zendesk.com/hc/en-us/articles/4408838947738-Archiving-an-article-to-move-it-out-of-your-knowledge-base).
To view an archived arcticle list, please see 
[Zendesk documentation](https://support.zendesk.com/hc/en-us/articles/4408822193434-Viewing-and-restoring-archived-articles).

## Restoring an article

To restore an article from archived state, you have to file a 
[Feature/Change request](https://gitlab.com/gitlab-com/gl-security/corp/cust-support-ops/issue-tracker/-/issues/new?description_template=Feature). 
After that Knowledge Admins have to follow the process as mentioned in
[Zendesk Documentation](https://support.zendesk.com/hc/en-us/articles/4408822193434-Viewing-and-restoring-archived-articles#topic_1j3_5vp_cy).

## Creating, Editing and Deleting sections

To add, edit or delete sections, you have to file a 
[Feature/Change request](https://gitlab.com/gitlab-com/gl-security/corp/cust-support-ops/issue-tracker/-/issues/new?description_template=Feature). 
After that Knowledge Admins have to follow the process as mentioned in 
[Zendesk Documentation](https://support.zendesk.com/hc/en-us/articles/4408845897370-Organizing-knowledge-base-content-in-categories-and-sections).

## Deleting an article

An article should be archived before deletion. To delete an article from knowledge base, you have to file a 
[Feature/Change request](https://gitlab.com/gitlab-com/gl-security/corp/cust-support-ops/issue-tracker/-/issues/new?description_template=Feature) after archiving it.
Once the request is received, Knowledge admin can follow the process as mentioned in 
[this link](https://support.zendesk.com/hc/en-us/articles/4408832480154-Permanently-deleting-a-knowledge-base-article) 
to manually delete an article.
Note: This is a permanent action.

## Important links

- [Zendesk Global Articles](https://gitlab.com/gitlab-support-readiness/zendesk-global/articles)
- [Zendesk US Government Articles](https://gitlab.com/gitlab-support-readiness/zendesk-us-government/articles)
- [Support Knowledge Base](../support/knowledge-base)

## Deprecated Information below:

{{% alert title="Note" color="primary" %}}

Article changes are classified as ad-hoc. Once changes are made to the repo, they sync to Zendesk.

{{% /alert %}}

### Creating an article

For the creation of articles, the requester would utilize the Support Super Form. A submission from there will provide the processor all the information it needs to fully create the article in the repo.

### Modifying an article

This should be a rare situation and should only apply when the _title_ or _metadata_ of an article requires an update. Any other edits (like to the content) are handled via the corresponding managed content file.

#### Updating the metadata

For these, you will need to locate the corresponding article file in the sync repo and make changes to it. You should also do this in a way that creates a MR. Said MR should always be peer reviewed before merging (the MR should enforce this).

#### Updating the title

As the sync is based off the articles title, this is a bit more specific of a task. We need to update the title in the Zendesk instance(s) manually and update the sync repo files. 

### Deleting an article

Here you will delete the sync repo file (or likely files) and then remove the article in thhe corresponding Zendesk instance(s) (see [Deleting an article](../../docs/zendesk/articles/#deleting-an-article)).

### Repo links

- [Zendesk Global sync repo](https://gitlab.com/gitlab-support-readiness/zendesk-global/articles)
- [Zendesk US Government sync repo](https://gitlab.com/gitlab-support-readiness/zendesk-us-government/articles)
- [Managed content repo](https://gitlab.com/gitlab-com/support/suport-pages)
