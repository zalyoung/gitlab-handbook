---
title: "OKRs in GitLab"
description: "How to enter and organize OKRs in the GitLab platform."
weight: 2
---

Watch this video for a demo on how to use GitLab for OKR management:

{{< youtube "OgJI_Yf4zXs" >}}

## Creating Objectives

The objectives for the quarter are defined on this page.
To add new objectives in GitLab, follow the steps below:

1. In the [GitLab OKRs project](https://gitlab.com/gitlab-com/gitlab-OKRs), navigate to OKRs by selecting **Issues** on the left sidebar.
1. In the top right corner of the **Issues** screen, select the down arrow next to **New issue** in the top right corner and then select **New objective** from the menu. Next, select the **New objective** button to [create an Objective](https://docs.gitlab.com/ee/user/okrs#create-an-objective).
1. Enter a short but descriptive title for the objective then click **Create objective**.
    1. When referring to a division, use the division name, not the e-group leader's position. For example, use "Marketing OKRs" (not "CMO OKRs").
1. Select the objective from the list to open in an editable view and add more details:
    1. Identify the owner for the objective and assign them.
         1. Ensure that only one [DRI](/handbook/people-group/directly-responsible-individuals/) is assigned to the objective. If there is a case of multi-ownership, it's likely that the OKR/KR can be simplified or broken down further.
    1. Identify the quarter for the objective and set the corresponding milestone.
    1. Add labels so objective is [searchable/filterable](#search-and-filter-okrs):
        1. Add `OKR` label.
        1. Add [division label](https://gitlab.com/gitlab-com/gitlab-OKRs/-/labels?subscribed=&search=division) to assign to the relevant division (i.e. Sales, Product, etc).
            1. Company OKRs are designated with a division::CEO scoped label.
        1. Only Product & Engineering cascade OKRs below division level, so for Product & Engineering OKRs, in addition to division labels, follow [stage labels](https://docs.gitlab.com/ee/development/labels/index.html#stage-labels) to add the Section/Stage/Group scoped labels to assign the OKR to the relevant parts of [Product Hierarchy](/handbook/product/categories/#hierarchy).
        1. Each part of hierarchy should have a label. For example, an OKR for a group would have a division label, a section label, a stage label, and a group label.
1. Review the objective against the [SAFE Framework](/handbook/legal/safe-framework/) to ensure it is information that can be shared. Review to ensure that the objective should not be [limited access](/handbook/communication/confidentiality-levels/#internal). If the information is limited access, use code name if relevant or link to a supporting issue that is limited access.

## Creating Key Results

Each [Objective](#creating-objectives) will contain one or more sub-objectives or key results. Sub-objectives are only used to cascade OKR down a level in [organizational structure](/handbook/company/structure/#layers) while [Key Results are the measure](okrs-basics.md#what-are-okrs) which helps us understand if we've met our objective and can be cascaded down a level of organization structure to become an objective one level down. Key Results must be created as part of an Objective and cannot be created independent of an Objective since Key Results [should be linked](/handbook/company/okrs/okrs-basics/#criteria-for-key-results) to an Objective.

Since [Key Results are the measure](okrs-basics.md#what-are-okrs) that helps us understand if we've met our Objective, Key Results are aligned to the same, single layer of the [organizational structure](/handbook/company/structure/#layers) as their parent Objective and not a Key Result for multiple layers of organizational structure. However, Key Results can be cascaded down from this single organizational structure layer by becoming Objectives in the next organizational level down.

To add new key results in GitLab, follow the steps below:

1. Navigate to the objective that you want to add a child key result to by opening the [GitLab OKRs project](https://gitlab.com/gitlab-com/gitlab-OKRs), selecting **Issues** on the left sidebar, then clicking on the target objective.
1. [Add new key result](https://docs.gitlab.com/ee/user/okrs#add-a-child-key-result) by clicking **Add** in the **Child objectives and key results** section of an objective and then select **New key result**. Use the [SAFE framework](/handbook/legal/safe-framework/) to determine whether it needs to have limited access.
1. Enter a short but descriptive title for the key result then click **Create key result**.
    1. When referring to a division, use the division name, not the e-group leader's position. For example, use "Marketing KR" (not "CMO KR").
1. Select the key result from the list in the **Child objectives and key results** section to open in an editable view and add more details:
    1. Identify the owner for the key result and assign them.
        1. Ensure that only one [DRI](/handbook/people-group/directly-responsible-individuals/) is assigned to the KR. If there is a case of multi-ownership, it's likely that the OKR/KR can be simplified or broken down further.
    1. Identify the quarter for the key result and set the start date as the first date of that quarter and set the due date to the last day of that quarter.
    1. Add labels so that KR is [searchable/filterable](#search-and-filter-okrs):
        1. Add `OKR` label.
        1. Add [division label](https://gitlab.com/gitlab-com/gitlab-OKRs/-/labels?subscribed=&search=division) to assign to the relevant division (i.e. Sales, Product, etc). Company OKRs are designated with a `division::CEO` scoped label.
        1. Only Product & Engineering cascade OKRs below division level. For Product & Engineering OKRs, in addition to division labels, follow [stage labels](https://docs.gitlab.com/ee/development/labels/index.html#stage-labels) to add the Section/Stage/Group scoped labels to assign the OKR to the relevant parts of [Product Hierarchy](/handbook/product/categories/#hierarchy).
        1. Each part of hierarchy should have a label. For example, an OKR for a group would have a division label, a section label, a stage label, and a group label.
1. Review the key result against the [SAFE Framework](/handbook/legal/safe-framework/) to ensure it is information that can be shared. Review to ensure that information should not be [limited access](/handbook/communication/confidentiality-levels/#internal). If the information is limited access, use code name if relevant or link to a supporting issue that is limited access.
1. Optionally, [turn on check-in reminders](https://docs.gitlab.com/ee/user/okrs.html).
1. The key result now appears in the **Child objectives and key results** section of the corresponding parent objective.

Watch this video for a demo on how to create objectives and key results:

{{< youtube "QmOM7J0Tu0o" >}}

## Search and Filter OKRs

1. You can use the List view to filter by the assignee or by your team using labels. For example:
    1. [This view](https://gitlab.com/gitlab-com/gitlab-OKRs/-/issues/?sort=created_date&state=opened&label_name%5B%5D=division%3A%3AEngineering&first_page_size=100) shows all engineering division OKRs. Division::engineering label can be swapped out for any other division/stage/section/group scoped label.
    1. [This view](https://gitlab.com/gitlab-com/gitlab-OKRs/-/issues/?sort=created_date&state=opened&assignee_username%5B%5D=sytses&first_page_size=100) shows all OKRs assigned to `@sytses`
1. You can bookmark or share the URL for future reference.

Watch this video for a demo on how to find the OKRs you're looking for:

{{< youtube "-wFJqtJQMHo" >}}
