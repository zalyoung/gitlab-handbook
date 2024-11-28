---
title: "Security Champions program"
---

The Security Champions Program is designed to address the growing challenges of scaling security efforts as GitLab expands. Currently, the AppSec team supports engineering teams through stable counterparts who act as points of contact for security-related tasks like AppSec reviews, MR reviews and threat modeling. However, as the company grows and development velocity increases, this model becomes unsustainable. The Security Champions Program aims to embed dedicated security advocates within each team, allowing for faster and more effective security collaboration.

By appointing Security Champions from within the engineering teams, the program fosters a proactive security culture where developers take ownership of security within their daily workflows. These champions will serve as the main security point of contact within their respective teams, ensuring that secure coding practices are followed, security issues are identified and resolved early, and teams are aligned with AppSec on broader security initiatives.

This approach will not only distribute security expertise across the organization but also improve the overall response time to security issues and ensure that security becomes an integral part of the development lifecycle, rather than a dependence on AppSec. With Security Champions in place, the organization will be better equipped to scale its security efforts and keep pace with its growing development teams.

---

## 1. Program Structure

- **Overview**:  
The **Security Champions Program** will embed designated security advocates (Security Champions) within each engineering team to drive security efforts. These champions will bridge the gap between engineering and the AppSec team, ensuring that security is deeply embedded in the software development lifecycle. Security Champions will provide security leadership and guidance within their teams, enabling quicker identification and remediation of security issues.

- **Roles & Responsibilities**:
  - **Security Champions**:  
    - Act as the primary point of contact for security within their teams.
    - Assist with secure coding practices and provide support for security-related queries.
    - Participate in AppSec reviews, threat modeling, and security testing activities.
    - Help prioritize and escalate vulnerabilities, including those resulting from HackerOne reports.
    - Advocate for and raise awareness of security best practices in their teams.
  
  - **AppSec Team**:  
    - Provide initial training and ongoing education to Security Champions. This will most likely be through an LMS platform.
    - Develop and maintain the educational content, including security processes and secure coding guidelines.
    - Support Champions with resources, tools, and expertise for vulnerability management and remediation.
    - Assist with escalation and investigation of high-priority security issues.
    - Ensure alignment of Security Champions with broader organizational security initiatives.

- **Scope**:  
  - Teams Involved:
    Initially, the program will involve engineering teams that have had a history of high-severity vulnerabilities, like ~"group::import", as the team members in these groups already have a lot of experience dealing with security issues and fixing them. Over time, the scope will ideally expand to all engineering teams.

  - Embedding Champions:
    **(WIP)** One Security Champion will be embedded per engineering team. The Champion will work closely with their team, attending milestone planning, retrospectives, and other relevant meetings to ensure security is integrated into every stage of development.

---

## 2. Knowledge Sharing & Maintenance

- **Knowledge Transfer Process**:
  - **Initial training for engineers, aimed to replace Secure Code Warrior**:  
    Based on [developer feedback for the Secure Code Warrior](https://docs.google.com/forms/d/1pF1r1kKaiVPBU_yQL0ZkbtggkmtvQFwZ6IZ1xqheo1s/edit#responses) (internal-only link), the following trends can be seen:
      - Engineers **do** prefer a hands-on learning approach
      - Some challenges were downright incorrect and their solutions inaccurate
      - Many engineers found that the tutorials and challenges were **not** relevent to their role
      - The UI is not intuitive, and the platform is hard to navigate
      - Additions that engineers would prefer include training on **threat modeling and past GitLab bugs*, which currently does not exist in SCW


    The new training will also be **hands-on**, but **specific to GitLab’s security needs**. This training will focus on **real past vulnerabilities** and practical, context-driven learning that directly applies to GitLab's tech stack and components.

	-   **GitLab-Specific Vulnerability Training**:  
    Engineers will go through **real historical vulnerabilities** that have been found in GitLab's own codebase. This will help engineers understand common mistakes and vulnerabilities specific to their code, and the techniques used to mitigate them.
   
    -   **Training Content**:
        -   Case studies of past vulnerabilities in GitLab’s components (e.g., P1 authentication/authorization bypasses, account takeovers, and most importantly- recent S1 security incidents like 5529).
        -   **Hands-on Labs**: Engineers will be tasked with working on **real-world exercises**, attempting to exploit and then fix historical vulnerabilities in GitLab’s repository. This could include simulating attacks (e.g. XSS, broken access controls) and then guiding engineers to the correct remediation.
        -   **Security Patching Exercises**: Engineers will practice creating patches for the vulnerabilities, following GitLab's secure coding guidelines. This may involve simulating interactions with AppSec, in order to mock AppSec approvals on security MRs.
        -   **Focus Areas**: Emphasis will be placed on vulnerabilities related to the technologies used at GitLab (i.e., **Rails**, **Go**).
    -   **Integrated Vulnerability Scanning Tools**:  
    Engineers may also be trained to use the **security scanning tools** integrated into GitLab, such as **SAST** (Static Application Security Testing), **vulnerability report dashboards** ([example](https://gitlab.com/gitlab-org/gitaly/-/security/vulnerability_report/?_gl=1%2ae3kp0p%2a_ga%2aNTU4MDk1ODcuMTY2NDc3NTA0OA..%2a_ga_ENFH3X7M5Y%2aMTY3Mzk3MDYwOC4xMDIuMS4xNjczOTcyNDMxLjAuMC4w)) and **dependency scanning**. Engineers will learn how to **triage and fix vulnerabilities** identified by these tools and integrate them into their development workflow.
    
    -   **Completion & Evaluation**:  
    Engineers will complete the training modules with practical exercises and assessments. They will also be given a final **“real-world vulnerability scenario”** where they must identify, prioritize, and remediate a vulnerability in a simulated environment similar to GitLab's production systems.
  
  - **Training for Security Champions**:  
    -   **Introduction**
   
        -   The role of Security Champions.
        -   How Security Champions fit into the broader **AppSec framework** at GitLab.
        -   Key security challenges faced by GitLab, including past incidents, vulnerability trends, and areas of improvement.

    -   **Practical Vulnerability Remediation**
    
        -   Security Champions will receive training on **how to identify**, **analyze**, and help **remediate vulnerabilities** in real code by reviewing MRs and identifying vulnerabilities.
	-   **Collaboration with Engineering Teams**
	    -   Security Champions will be trained on how to **collaborate with their teams** to ensure security is built into the development lifecycle:
	        -   Facilitating **security discussions** during milestone planning, reviews, and retrospectives.
	        -   Assisting engineers with secure design patterns, threat modeling, and code reviews.
	-   **Escalation and Incident Response**
    
	    -   Training on when and how to escalate issues to **AppSec**
	    -   What to do when a **high-risk vulnerability** is discovered, (eg. the Champion's role during **security incidents**).

- **Content Updates & Maintenance**:
  - **Updating Educational Content**:  
    The process for updating training materials and content will be designed to ensure that all educational resources stay current with emerging security threats, new vulnerabilities, updates to GitLab’s codebase, and improvements to security tools and practices. This continuous improvement process will involve a combination of proactive and reactive updates to address both anticipated needs and lessons learned from past security incidents.
     - **Content Review Cycle**

       -   **Quarterly Review**: Every quarter, the training content (including modules on secure coding practices, vulnerability remediation, threat modeling, and code review best practices) will undergo a thorough review. The review will ensure that the content reflects the latest security trends, GitLab-specific vulnerabilities, and any new tooling or processes that have been implemented.
       -   **Post-Incident Reviews**: After every significant security incident, training content will be updated based on the lessons learned. This may include:
           -   Updates to secure coding guidelines if a vulnerability type was missed or poorly addressed in the past.
           -   Real-world examples added to the training from post-mortem analysis and remediation steps.

   - **Feedback Loops**

       -   **Feedback from Security Champions and Engineers**: Regular feedback from Security Champions and engineering teams will be solicited via surveys, retrospectives, and direct feedback channels (e.g. Slack or ideally GitLab issues). This feedback will be used to adjust content based on user experience, effectiveness, and gaps identified during real-world application.
       -   **Security Metrics**: Metrics will highlight areas where engineers might need more training. For example, if a certain class of vulnerabilities (like pipeline impersonation or account takeovers) is repeatedly discovered, additional content will be created to target those issues specifically.
  
- **Directly Responsible Individuals (DRIs)**:  
 Identify who is responsible for maintaining and updating training content.

---

## 3. High-Level Processes and Workflows

- **1. Vulnerability Identification & Escalation**

    - **Initial Steps for Security Champions**
    
       -   **Identify Severity**: When a Security Champion identifies a vulnerability, they should first assess the severity and potential impact.
        -   **Severity Classification**: Utilize the [GitLab CVSS calculator](https://gitlab-com.gitlab.io/gl-security/product-security/appsec/cvss-calculator) to calculate the CVSS score. This helps in triaging and escalating appropriately.
    -   **Immediate Action**: If the vulnerability is deemed **Critical** or **High**, the Security Champion should immediately(?) escalate to AppSec.
        -   If the vulnerability is **Low** or **Medium**, the Champion should follow the [general handbook process to open and fix security issues](https://handbook.gitlab.com/handbook/security/engaging-with-security/#creating-new-security-issues).
    -   **Escalation to AppSec**:
    
        -   For **Critical** vulnerabilities, **the Champion should escalate within 24 hours**, ensuring the AppSec team is aware and can take immediate action. AppSec will then evaluate the impact of the security issue, and create a SIRT incident if deemed necessary.
        -   For **High** vulnerabilities, **escalate to AppSec within 2-3 days** to allow time for initial remediation steps but ensure AppSec is involved early for visibility.
        -   For **Medium/Low** vulnerabilities, **regular reviews** should be scheduled (e.g., weekly or bi-weekly) for AppSec to provide input and validation of the issue.

    - **Key Action for Champions**:
      -   Provide as much detail as possible in the initial issue: Steps to reproduce, logs, affected systems/components, possible attack vectors, etc.. The [standard vulnerability disclosure template](https://gitlab.com/gitlab-org/gitlab/-/issues/new?issuable_template=Vulnerability%20Disclosure) may be used to create the issue.
      -   Collaborate with AppSec on impact analysis.

----------

  - **2. Threat Modelling & Escalation**

    -   **When Threat Modelling is Needed**:
    
        -   **Security Champions should initiate threat modeling** whenever a new feature, product, or change to the system is introduced that has potential security implications (e.g., new architecture, integration, or handling of SAFE data).
        -   If the feature introduces **complex or high-risk concerns** (e.g., involves external services, SAFE data handling, or broad changes), the Security Champion should initiate the process with AppSec.
    -   **Escalation to AppSec**:
    
        -   For features with significant security risks or new areas of concern, **AppSec should be involved early** to ensure that a thorough threat model is done for the feature.
        -   For less risky or minor changes, **Champions can complete basic threat modelling with their team** and only escalate if they encounter difficulties or require expert validation.
    
    - **Champion’s Role in Threat Modeling**:
    
        -   **Lead or co-lead the threat modeling session** with AppSec involvement, making sure all potential threats are identified.
        -   Advocate for and familiarize the rest of the team with the use of the [PASTA threat modelling framework](https://handbook.gitlab.com/handbook/security/product-security/application-security/threat-modeling/#pasta-stages)
        -   Provide insights and context for the team, ensuring that security concerns are addressed at an early stage.

----------

  - **3. AppSec Review & Escalation**

    -   **When an AppSec Review is Needed**:
    Security Champions should request an AppSec review if the team introduces major changes to critical code areas, like authentication mechanisms, authorization logic, or areas with a history of vulnerabilities. Even when the team does major refactoring that could have security implications (e.g., changing authentication flow, reworking access controls), this should trigger an AppSec review.
    -   **Escalation to AppSec**:    
        -   **Routine Code Reviews**: Security Champions should **routinely involve AppSec** during the review process if security concerns are identified.
        - For **high-impact changes** or **major new components**, [**a P1 AppSec review issue**](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/appsec-reviews/-/issues) should be opened.

    - **Champion’s Role in AppSec Reviews**:
    
        - **Champion ownership**: Champions should lead non-P1 security review process within their team, including ensuring the right security testing is performed and the team adheres to security coding standards (eg. secure coding guidelines).
        - **Feedback loop**: Collect feedback from AppSec to ensure that identified vulnerabilities are remediated.
        - **Escalation for AppSec’s Attention (P1 reviews)**: If an MR is large or complex and has significant security implications (e.g., changes to data storage, handling of sensitive data), escalate the review to AppSec as a P1 review.

---


## 4. Budget Considerations

- **Training Costs**:
  - **Initial Development**: The cost of an LMS for training delivery and tracking progress could range from **$10,000 to $30,000** per year, depending on the platform chosen. This includes estimated costs for creating and curating training content (e.g., instructional materials, LMS integration, video production, etc.). This is a very rough figure. We can probably compare the prices with SCW to get a more accurate figure.
  - **Ongoing Maintenance**: Maintaining and updating training content annually (to incorporate new vulnerabilities, labs, and practices) could cost approximately **$5,000 to $10,000** per year for content updates and instructor-led sessions.

- **Champion Incentives**:
  - **Monetary Rewards**: Budget for potential monetary rewards or bonuses (e.g., performance-based incentives, annual recognition, etc.). Estimated cost: **$2,000 to $5,000** per champion annually, depending on the number of champions. This will be similar to the [Security Awards Program](https://about.gitlab.com/blog/2021/05/14/how-we-used-gitlab-values-to-build-a-security-awards-program/) in nature.
  - **Time Investment**: Allocate time for Champions to participate in the program, including training and collaboration activities. This may require **5-10%** of their time, which should be accounted for in terms of resource allocation and project deadlines.


---


## 5. Objectives and Success Metrics

- **Onboarding Program**:
  - **Objective**: Ensure all new engineers are effectively trained on GitLab’s secure coding guidelines, past vulnerabilities, and secure development practices.
  - **Success Metric**: 
    - 90%+ completion rate for onboarding training within the first 30 days.
    - Positive feedback from at least 80% of new engineers regarding training relevance and effectiveness.

- **Security Champions Program**:
  - **Objective**: Embed security champions in engineering teams to promote secure coding practices, assist with code reviews, and help identify potential security vulnerabilities early in the development process.
  - **Success Metric**: 
    - At least one Security Champion in each stage within 3 months.
    - 80%+ of code reviews include active participation from Security Champions.
    - Champions identify and raise at least 3 potential vulnerabilities or security-focused improvements per quarter.
    - At least 2 threat models and 2 AppSec reviews initiated by Champions per quarter.

- **Champions’ Objectives**:
  - **Objective**: Equip Security Champions with the tools, knowledge, and support to act as security leaders within their teams, ensuring secure development practices are followed.
  - **Success Metric**: 
    - Champions lead or participate in at least 90% of their team’s security-related code reviews.
    - Champions identify vulnerabilities or suggest improvements during code reviews with measurable impact (e.g., issues raised before the MR is merged). This needs to be quantified.

- **Engineering Teams’ Objectives**:
  - **Objective**: Ensure engineering teams adopt secure coding practices, perform thorough code reviews, and engage with AppSec when needed.
  - **Success Metric**: 
    - 100% of the engineering teams complete security training.
    - 95% of engineering teams perform begin threat modelling for new features.
    - Increase in the number of proactive security discussions in retrospectives.

---

## 6. Estimated Timeline

- **Phase 1 (1–2 Months)**:  
  List tasks for the first phase of the program.
  
- **Phase 2 (3–4 Months)**:  
  List tasks for the second phase.

- **Phase 3 (5+ Months)**:  
  List tasks for the third phase.

---

## 7. Vision for Automated Content Updates

- **Automated Scanning and Updates**:  
  Describe how automated tools could help update content.

- **LMS Integration**:  
  Describe how a learning management system could automate and track training.

---

**Next Steps**:  
Define the next steps for approval and implementation of the program.