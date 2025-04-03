---
title: "Workshop Contribution Guidelines"
description: "Guidance on how you can contribute your own content to be supported by Demo Architecture"
---

## Workshop Contribution Guidelines

### Team Contributions

Any team member is able to contribute back a pre/post sales workshop that they created to be supported by the demo architecture team and its infrastructure. This means that it will be added to Learn Labs so that you can easily repeat your events without a hassle. By contributing back, other sales teams across the org will be able to use your content, and hopefully even contribute back. We are open to accepting content of all types.

### Guidelines

As a first rule of thumb the content needs to not be specifc to a single customer and should be repeatable for any customer in any region/vertical. Its ok to suggest multiple workshops that focus on AI for example, but please do due dillegence to confirm that your content suggestion shouldnt just be a contribution to something that exists. Second, we ask that if additional resource set up is included (like attaching a cluster) the guideliens for set up instructions for that are included as well. 

Some styling guidelines are:

- All hands on steps need to be written in markdown with the assumption that they will be added as issues for the customer

- Anything a customer needs to click should be bold

- Anything a customer needs to look at should be in italics

- Title with "[[_TOC_]]" is expected at the top of every issue

- Any prep work for a specific issue starts at step 0, otherwise start at step 1

- When possible make code copayable, for example:

    ```plaintext
    How to enable experimental and beta AI features for GitLab Duo?
    ```

    having students write out instructions often leads to problems

- link docs where possible, example:

> [Docs for GitLab Discussion Summary](https://docs.gitlab.com/ee/user/discussions/index.html#summarize-issue-discussions-with-duo-chat)

- if you make a large number of code changes it is always suggested that you have a "finished" branch for each issue

- When in doubt, reference this file for reference: https://gitlab.com/gitlab-learn-labs/sample-projects/tanuki-racing/-/blob/main/Courses/Workshops/Duo_Enterprise/1_Modern_Development_With_GitLab_AI.md?ref_type=heads

Otherwise here are a few things to avoid when writting content:

- Stay on the GitLab platform if possible. Having customers download seperate IDEs/Tools often leads to larger issues with firewalls, versioning, and security. Because of that we ask that you always try to sick to using the Web IDE as well.

- Stay away from experimental or early development features. These often have unepected outages and have frequent changes, so if you must include one of these features call that out in the instructions.

- Keep the time length in mind, if its approaching the 3 hour mark it might make sense to break up the content

- Accesability is key. This applies for both slides and content, but at a base line make sure you have high contrast to avoid color blindness problems

- We do not support admin demos at current, so assume that the students will be owners of a subgroup but not top level admins.

### Expectations
