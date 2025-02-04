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

## Marketo Program Setup

The primary Marketo program Goldcast template to use is named `YYYYMMDD_EventName_Webcast_Goldcast_template` and is found in the [Templates - Goldcast Webcasts folder](https://engage-ab.marketo.com/?munchkinId=194-VVC-221#/classic/ME21842A1). Goldcast can auto-create Marketo programs based on this template, but tokens will still need to be updated. 

## Fields syncing between Marketo and Goldcast

List of sync fields in draft currently. Let MOps know of any more fields to consider. 

| Goldcast Field Name | Marketo Field Name | Update Cadence |
| ------ | ------ | ------ |
|   First Name     |   First Name     | Only update if target is empty |
|   Last Name     |  Last Name     | Only update if target is empty |
| Email| email | Lookup Field |
|Job Title | Job Title| Only update if target is empty |
| Company | Company Name| Only update if target is empty|
|City | City| Only update if target is empty|
| State |State |Only update if target is empty|
| Country | Country|Only update if target is empty|
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