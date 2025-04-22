---
title: "GitLab Agile Portfolio Management - Hands-On Lab: Reporting & Portfolio Management"
description: "This Hands-On Guide walks you through creating and managing dashboards in GitLab."
---

> Estimated time to complete: 20 minutes

## Objectives

GitLab provides different types of analytics insights for instances, groups, and projects. In this lab, we will explore various types of dashboard one can use in your system, as well as how to create your own dashboards.

### Task A. Accessing Built-in Dashboards

GitLab offers several built-in dashboards at both the project and group level. Let's look at a few of them now.

1. Navigate to your project repository.

1. Click on **Analytics** in the left sidebar.

1. Explore the available dashboard options:
   - Value Stream Analytics - Shows the time it takes for code changes to move through your development lifecycle
   - CI/CD Analytics - Focuses on pipelines and jobs
   - Repository Analytics - Provides insights into repository activities like commits and merges
   - Insights (if enabled) - Allows for custom dashboards within your project or group.

Now that we have some understanding on how dashboards look and function, let's create a dashboard for our project. To create a custom dashboard we will need to create our own `.gitlab/insights.yml` file, define its content, and save this configuration.

#### Task B. Creating an Insights File

1. In your repository, click the **+** button, and click **Create new directory**.

1. Name the directory _.gitlab_, and commit on the main branch.

1. Inside the _.gitlab_ directory, click the **+** button, and click **Create new file**.

1. Title the file **insights.yml**.

1. Copy the content below into the file and press **Commit changes**.

```yaml
group_dashboards:
  main:
    name: 'Main Dashboard'
    panels:
      - name: 'Issues by type'
        type: 'bar'
        query:
          data_source: 'issuables'
          params:
            issuable_type: 'issue'
            collection_labels: ['bug', 'feature', 'documentation']
```

### Task C. Create a Dashboard

1. Navigate to your project.

1. Click on **Analyze > Analytics dashboards** in the left sidebar.

1. Click on **New Dashboard** in the top right.

1. **Enter a name for your dashboard**

1. Write 'My New Dashboard' in the Dashboard title.

1. Click **Add visualization**, and select the one you created earlier.

1. Click the **Save your dashboard** button.

By effectively using GitLab's dashboard capabilities, you can gain valuable insights into your projects and make data-driven decisions for your portfolio management.

## Lab Guide Complete

You have completed this lab exercise. You can view the other [lab guides for this course](/handbook/customer-success/professional-services-engineering/education-services/ilt-labs/gitlabpmhandson).

## Suggestions?

If you'd like to suggest changes to the *GitLab Agile Portfolio Management Hands-on Guide*, please submit them via merge request.