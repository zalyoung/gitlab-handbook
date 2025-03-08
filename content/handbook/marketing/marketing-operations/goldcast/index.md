---
title: "Goldcast"
description: "Goldcast is a digital events platform that helps B2B marketers create and host events, webinars, and video campaigns. It uses AI to help users create engaging content and repurpose videos into multiple formats."
---

<link rel="stylesheet" type="text/css" href="/stylesheets/biztech.css" />

## About Goldcast

Page in progress - Purchased as of Jan 2025. Marketing Operations is in the process of integrating and implementing. Follow along in the [Asana project](https://app.asana.com/0/1209155237570970/1209154995205852).

## Official Goldcast Resources

- The [Goldcast Knowledge Base](https://help.goldcast.io/) houses a plethora of step-by-step guides that walk through all aspects of the platform.
- The [Goldcast Hall-of-Fame](https://www.goldcast.io/customer-stories) shares multitudes of customer stories and their use cases of the Goldcast platform
- The [Goldcast Blog](https://www.goldcast.io/blog) shares additional ways to leverage the platform and other relevant updates from Goldcast

## Fields syncing between Marketo and Goldcast

List of sync fields in draft currently. Let MOps know of any more fields to consider. 

| Goldcast Field Name | Marketo Field Name | Update Cadence |
| ------ | ------ | ------ |
|   First Name     |   First Name     | Don't update if source is empty |
|   Last Name     |  Last Name     | Don't update if source is empty |
| Email| email | Lookup Field |
|Job Title | Job Title| Don't update if source is empty |
| Company | Company Name| Don't update if source is empty|
|City | City| Don't update if source is empty|
| State |State |Don't update if source is empty|
| Country | Country|Don't update if source is empty|
| Data Share Content | Opt-in| Don't update if source is empty |
|Province|Canadian Province|Don't update if source is empty|
|State/Territory|Australian State/Territory|Don't update if source is empty|
| UTM Campaign |original UTM campaign|Only update if target is empty|
| UTM Campaign | last UTM campaign| Always update|
| UTM Medium |original UTM medium|Only update if target is empty |
| UTM Medium |last UTM medium|Always update |
| UTM Term | original UTM term|Only update if target is empty |
| UTM Term | last UTM term| Always update |
| UTM Source |original UTM source|Only update if target is empty |
| UTM Source |last UTM source|Always update |
| UTM Content |original UTM content|Only update if target is empty|
| UTM Content |last UTM content|Always update|


## Event Tags in use
Tags can be used to quickly filter webcasts and events by the tagged topic. If you add more tags in the Goldcast platform, please be sure to update this handbook list. 

- DevOps Platform
- DevSecOps
- Security and Compliance
- Automated Software Delivery
- CI
- CD
- Duo
- Language: Japanese
- Language: Korean
- Language: French
- Language: German
- Language: Italian
- Language: Spanish
- Language: English w/ interpreter
- Type: Workshop (Used for Field Marketing Hands-on workshops)
- Type: Webcast (only used when another type is not used)
- Type: ABM Webcast (Used for events designed for a single or small subset of specific accounts)
- Type: GTM Webcast (A webcast aligned with a GTM, produced by the GTM team.)
- Type: Technical Demo Series (Used for the weekly Technical Demo Series)
- Audience: Partners
- Audience: Customers - Practitioners
- Audience: Customers - Managers
- Audience: Customers - Execs
- Audience: Prospects - Practitioners
- Audience: Prospects - Managers
- Audience: Prospects - Execs
- Audience: Channel (Directly targeting the channel partner, any member of the partner organization)
- Audience: Channel Marketing (Any activity directly targeting the marketing people within the channel/partner organization)
- Global
- APAC
- EMEA
- AMER
- US Public Sector
- All Segments
- SMB
- MM
- ENT
- Case Study (Used on any webcast that presents a customer story)
- Partner Involved (Used on any webcast that is co-branded or has a partner speaking on the webcast)

## Marketo Program Setup

The primary Marketo program template to use is named `YYYYMMDD_EventName_Webcast_Goldcast_template` and is found in the [Templates - Goldcast Webcasts folder](https://engage-ab.marketo.com/?munchkinId=194-VVC-221#/classic/ME21842A1). Goldcast can auto-clone Marketo programs based on a template, as long as the Goldcast template is synced to a Marketo program. The Marketo program created will have the same name as the Goldcast event, ending with a time stamp. The program will appear in the same folder as the original Marketo program.

When working correctly, the Marketo program's tokens will auto-populate - either on program creation (via Goldcast's program cloning feature) or when manually connected to a Goldcast event. The relevant tokens for this process are:

- {{my.goldcast_eventEndDate}}
- {{my.goldcast_eventEndTime}}
- {{my.goldcast_eventId}}
- {{my.goldcast_eventSeriesID}}
- {{my.goldcast_eventSeriesName}}
- {{my.goldcast_eventStartDate}}
- {{my.goldcast_eventStartTime}}
- {{my.goldcast_eventTimezone}}
- {{my.goldcast_eventTitle}}
- {{my.goldcast_formId}}

Users have the option of starting event creation within either platform. 

## Event Creation within Goldcast 

## Event Creation within Marketo

When starting event creation in Marketo, make a duplicate of [YYYYMMDD_EventName_Webcast_Goldcast_template](https://engage-ab.marketo.com/?munchkinId=194-VVC-221#/classic/ME21842A1) and move it to the appropriate folder for the quarter and using the standard naming convention.

Once the program is up, grab the program ID number. The program ID number can be found at the end of the program's URL and between the letters,  i.e. `classic/ME**00000**A1`. The program ID will be placed into your Goldcast event.

To place the Marketo program ID in Goldcast, go to and click into your event. Within the event, click in this order `Integrations` -> `Marketo` -> `Settings`. Place your Marketo program ID into the `Connected Program ID` field and click connect. The Goldcast event and Marketo program are now linked.

Once the Goldcast event and Marketo program are connected the Marketo program tokens will populate.