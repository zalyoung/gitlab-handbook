---
title: "Workshop Contribution Guidelines"
description: "Guidance on how you can contribute your own content to be supported by Demo Architecture"
---
# Workshop Contribution Guidelines

## Team Contributions

All team members are encouraged to contribute their pre-sales or post-sales workshops to be supported by the COE team's infrastructure. By doing so, your workshop will be added to Learn Labs, making it easy for you and other sales teams across the organization to repeat your events seamlessly. Contributing your content allows others to leverage your work and hopefully contribute back as well. We accept a wide variety of content types.

## Guidelines

1. **Broad Applicability**: The content should not be specific to a single customer. It should be repeatable and relevant for any customer, regardless of region or industry vertical. While it's acceptable to suggest multiple workshops focused on a specific topic like AI, please do your due diligence to ensure your content is not redundant with existing workshops. 

2. **Setup Instructions**: If your workshop requires additional resource setup (e.g., attaching a cluster), please include clear setup instructions.

3. **Styling Guidelines**:
   - Write all hands-on steps in Markdown, assuming they will be added as issues for the customer.
   - Use **bold** for anything the customer needs to click.
   - Use *italics* for anything the customer needs to look at.
   - Include a title with `[[_TOC_]]` at the top of every issue.
   - Number prep work steps starting at 0. Otherwise, start at step 1.
   - Make code copyable when possible. For example:
     ```plaintext 
     How to enable experimental and beta AI features for GitLab Duo?
     ```
     Requiring students to write out instructions often leads to problems.
   - Link to relevant documentation when possible. For example:
     > [Docs for GitLab Discussion Summary](https://docs.gitlab.com/ee/user/discussions/index.html#summarize-issue-discussions-with-duo-chat)
   - For extensive code changes, provide a "finished" branch for each issue.
   - Reference this [sample file](https://gitlab.com/gitlab-learn-labs/sample-projects/tanuki-racing/-/blob/main/Courses/Workshops/Duo_Enterprise/1_Modern_Development_With_GitLab_AI.md?ref_type=heads) for guidance.

4. **Things to Avoid**:
   - Stay within the GitLab platform whenever possible. Requiring customers to download separate IDEs or tools can lead to issues with firewalls, versioning, and security. Try to use the Web IDE.
   - Avoid experimental or early development features, as they may have unexpected outages and frequent changes. If you must include one, clearly call it out in the instructions. 
   - Be mindful of workshop length. If it approaches 3 hours, consider breaking up the content.
   - Prioritize accessibility for both slides and content. Ensure high contrast to avoid issues for people with color blindness.
   - Currently, we do not support admin demos. Assume students will be owners of a subgroup but not top-level admins.

## Expectations

Once your workshop content is contributed, the COE team will review it and work with you to get it polished and added to our infrastructure. We'll handle the technical setup so you can focus on delivering engaging workshops. 

By contributing, you're helping build a valuable resource for the entire sales organization. We appreciate your collaboration in creating impactful, reusable workshop content. If you have any questions during the contribution process, don't hesitate to reach out to the COE Demo Architecture team for guidance.