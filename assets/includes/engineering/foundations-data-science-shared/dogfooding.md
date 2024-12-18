[Dogfooding for R&D is important](/handbook/product/product-processes/dogfooding-for-r-d/), and even more-so as we graduate to [empowering teams with Artificial Intelligence](/handbook/engineering/core-development/#ai-everywhere-empowering-teams-with-artificial-intelligence). GitLab Duo is an offering to (1) support you across the software development lifecycle, (2) improve the developer experience, and (3) boost productivity. Based on these goals, our teams are placed perfectly to dogfood the features that will best support us, our customers through our own case studies, and our product through high quality feedback.

#### **Examples**

##### **Automation and Task Streamlining**
- **When to use:** Automating tasks like bootstrapping a new project or implementing a proof of concept.
  - **What to use:** [Duo Workflow](https://docs.gitlab.com/ee/user/duo_workflow/).
  - **How to use:** Use Duo Workflow to scaffold a new project. Provide [feedback](https://gitlab.com/gitlab-org/gitlab/-/issues/480148#pray-readme) after testing.
  - **Impact:** Speeds up project initialization, saving hours of manual setup.

- **When to use:** Writing scripts or automating repetitive tasks.
  - **What to use:** Duo Chat for script generation.
  - **How to use:** Request Duo Chat to write scripts for automating tasks like posting MR threads or generating custom diffs [Example Script](https://gitlab.com/knejad/gitlab-career-development/-/merge_requests/1).
  - **Impact:** Reduces manual work and ensures consistency in repetitive tasks.

---

##### **Debugging and Issue Resolution**
- **When to use:** Debugging pipeline failures after submitting an MR.
  - **What to use:** Duo Chat’s "troubleshoot" button with Root Cause Analysis.
  - **How to use:** Use the troubleshoot button to identify errors such as linting issues directly, without scrolling through logs [Example Job](https://gitlab.com/gitlab-com/content-sites/handbook/-/jobs/8223593899).
  - **Impact:** Saves time, reduces feedback loops, and expedites MR approvals.

- **When to use:** Resolving flaky test issues.
  - **What to use:** Duo Chat with advanced context.
  - **How to use:** Add the test and related files into [advanced context](https://www.youtube.com/watch?v=Mlbe-no6t0E) and ask Duo Chat for the issue and its fix.
  - **Impact:** Quickly identifies and resolves flaky tests.

- **When to use:** Refactoring code or fixing complex merge conflicts.
  - **What to use:** Duo Chat’s `/refactor` command.
  - **How to use:** Use Duo Chat to propose [refactor](https://docs.gitlab.com/ee/user/gitlab_duo_chat/examples.html#refactor-code-in-the-ide) ideas.
  - **Impact:** Reduces time spent debugging and improves code quality.

---

##### **Collaboration and Feedback**
- **When to use:** Reviewing MRs with unfamiliar syntax or concepts.
  - **What to use:** Duo Chat for syntax explanation.
  - **How to use:** Highlight unfamiliar code and use Duo Chat to [explain](https://docs.gitlab.com/ee/user/gitlab_duo_chat/examples.html#refactor-code-in-the-ide) it, reducing the need for additional research or questions.
  - **Impact:** Enables quicker MR turnarounds with reduced dependency on the author.

- **When to use:** Enhancing MR feedback and collaboration.
  - **What to use:** Duo Chat’s contextual features.
  - **How to use:** Use Duo Chat with advanced context to clarify MR feedback. Highlight the specific code or section in question, open Duo Chat, and utilize the `/explain` command to gain a deeper understanding of the feedback. Additionally, use Duo Chat to draft responses or propose solutions.
  - **Impact:** Streamlines feedback processing by reducing the time spent interpreting feedback or researching solutions. Enhances collaboration by fostering clear and actionable communication within the MR process.

---

##### **Documentation and Reporting**
- **When to use:** Generating documentation for a feature.
  - **What to use:** Duo Workflow or Duo Chat.
  - **How to use:** Provide Duo Chat with an issue description or MR details to generate documentation or README updates.
  - **Impact:** Saves time on manual documentation writing and improves consistency.

- **When to use:** Handling complex security incidents.
  - **What to use:** Duo Chat for comprehensive information management.
  - **How to use:** Utilize Duo Chat to organize and retrieve incident details across issues, comments, and labels.
  - **Impact:** Ensures accurate reporting and prevents key information from being overlooked.

---

##### **Visualization and Analysis**
- **When to use:** Generating visualizations for complex code.
  - **What to use:** Duo Chat for diagram generation.
  - **How to use:** Ask Duo Chat to create diagrams such as mermaid diagrams for workflows or concurrent processes in an MR.
  - **Impact:** Adds clarity to complex workflows and saves time on manual diagram creation.

- **When to use:** Reviewing customer interview transcripts to extract insights.
  - **What to use:** Duo Chat for text analysis and summarization.
  - **How to use:** Provide Duo Chat with transcripts and request a summary or analysis from a Product Manager perspective.
  - **Impact:** Reduces hours of manual review, enabling faster decision-making.