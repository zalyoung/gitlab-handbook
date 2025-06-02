---
title: Handbook Embedding Demonstration Page
type: docs
---

This is our Tableau embed demo page.  It is used to demonstrate how we can embed Tableau visualizations into the handbook. To facilitate uniform experience and presentation we use a [shortcode](http://handbook.gitlab.com/docs/shortcodes/#tableau-embeds) to embed Tableau charts and dashboards.

**Important:** Users must have a Tableau license to view embedded content. Dashboards will not load for users without proper licensing.

To view charts embedded in the handbook the browser will need to have third party cookies enabled. This is because the handbook site needs to connect to our public Tableau site, and uses cookies to do this.

## Embedding Straight Into the Handbook (No YML File)

### Viz from Internal Tableau site

Follow this video [demonstration on how to do the embed](https://youtu.be/Vry_yqUP2C8). Note this has information on how to emmbed for a legacy Tableau Public site that has now been deactivated. Much of the training is still relevant for embedding internally

The source url for a view from the internal Tableau site can be found by navigating to the view and selecting the `Share` option at the top of the screen and then selecting the `Copy Link` option.

![tableau share](/images/enterprise-data/platform/tableau/embed-demo/tableau_view_share.png)

![tableau link](/images/enterprise-data/platform/tableau/embed-demo/tableau_view_link.png)

This chart should only require a log in to the Tableau site and only be visible to those that have a Tableau license. GitLab team members should login via OKTA SSO.

{{< tableau height="600px" src="https://10az.online.tableau.com/t/gitlab/views/OKR4_7EngKPITest/PastDueInfraDevIssues" >}}
{{< /tableau >}}

### Viz with Parameters and Filters and Height

This chart should be filtered to a pre-selected Severity and Subtype. The ability to use parameters and filters means that we can more flexibly use a single chart to display different cuts in different embeds if needed.

{{< tableau height="600px" src="https://us-west-2b.online.tableau.com/t/gitlabpublic/views/OKR4_7EngKPITest/PastDueSecurityIssues" >}}
  {{< tableau/params "Severity Select"="S2" >}}
  {{< tableau/filters "Subtype Label"="bug::vulnerability" >}}
{{< /tableau >}}

## Embedding Performance Indicators or Other Views Using YML Files

[Here is a video demonstrating the entire process of embedding PI's using yml files- public or internal views.](https://gitlab.zoom.us/rec/share/rK5olD88X0ZEzbbSmVFXB-jsMYfaD7V9j_ALTL89WJ4JZM1m_CugxAp_T1C5m87n.XK69XZAoRmndQglk?startTime=1706031218000)
Passcode: 6yz?njYI

There are a few extra steps to embed any views using a yml file, because you do not add the shortcodes right into the handbook page where the actual view shows up. Here is the process.

1. Use the normal URL of the view in Tableau. Make sure that you get the URL by navigating to the specific view you want to embed and clicking "share" and copying that URL - the URL from the top of the page in the normal URL bar may not work. 

2. You will need to make the data source an "extract" instead of "live" connection for the process to work correctly. If your extract is over 10 million rows or does not follow [the guidelines for extracts](/handbook/enterprise-data/platform/tableau/tableau-developer-guide/#guidelines-for-publishing-extracts), reach out to the data team to use the service account's credentials to on the workbook so that you can use a live connection.

3. Now you are ready to update your yml file. Go to the handbook page you want to update the PI's for, and edit the page. There you will find the name of the file that you are looking to update. It will look something like this:

    ```md
      {{</* performance-indicators "developer_relations_department" /*/>}}
    ```

4. Go to the [Gitlab.com repository](https://gitlab.com/gitlab-com/www-gitlab-com) and search "find file" for that file name, it should be a yml file.

5. Update the yml file according to [these guidelines for the performance indicators YML files](/handbook/enterprise-data/platform/tableau/tableau-developer-guide/#yml) using a Merge Request.
