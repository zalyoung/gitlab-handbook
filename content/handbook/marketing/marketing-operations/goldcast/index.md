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

### Official Goldcast Recommended Resources

- [Permissions breakdown for Team vs Org admins](https://goldcastlearn.helpjuice.com/teams/22128904258715-organization-admin-vs-team-admin-who-can-do-what)
- [User Roles and Permissions](https://goldcastlearn.helpjuice.com/about-goldcast/roles-permissions-in-goldcast-studio?from_search=162470793&swifty_search_highlight=team+admin)
- [Design and Branding](https://help.goldcast.io/en_US/design)
- [Registration Page and Forms](https://help.goldcast.io/en_US/registration-page-form)
- [Email Customization](https://help.goldcast.io/en_US/emails)
- [Event Settings](https://help.goldcast.io/en_US/event-settings)
- [Event Setup](https://help.goldcast.io/en_US/event-setup)
- [Captions and Subtitles](https://help.goldcast.io/en_US/event-settings/16696845638683-captions-and-translated-subtitles)

## Random Things to Know

- Test events are no longer test events if the registrant number reaches 10 people
- When an event is set to convert to an on demand capable event, the transition occurs around the 35 minute mark after the event ends
- While users can create custom fields within their events as needed, the data syncing into Marketo is set by Marketing Ops. **Do not add any fields into the Goldcsat -> Marketo sync without consulting Marketing Ops**
- By default, `English` is set as the primary language in the event template. Captions and subtitles are also toggled on by default, but will only work correctly if the presenters are speaking in the set primary language
- The `Enter Event` button on the registration landing page is recommended to be disabled, if it is not already. If enabled, registrants can enter the event earlier than 1 hour prior to event start. Instructions on disabling the button [here](https://help.goldcast.io/en_US/event-settings/4583663517211-disabling-the-enter-event-button#how-to-turn-off-the-enter-event-button-1)
- Run on the assumption that settings cannot be changed within an hour of your event start time 

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

## Marketo Program Cloning and Tokens

The primary Marketo program template to use is named `YYYYMMDD_EventName_Webcast_Goldcast_template` and is found in the [Templates - Goldcast Webcasts folder](https://engage-ab.marketo.com/?munchkinId=194-VVC-221#/classic/ME21842A1). Goldcast can auto-clone Marketo programs based on a template, as long as the Goldcast template is synced to a Marketo program. The Marketo program created will have the same name as the Goldcast event, ending with a time stamp. The new program will appear in the same folder as the original Marketo program.

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

Additionally, there are tokens within the program that are _not_ updated by Goldcast but are still relevant for various aspects of the program, like the Marketo landing page or Marketo-sent follow up emails.

Marketo email tokens

- {{my.utm}}
- {{my.ondemandUrl}}
- {{my.epic link}}
- {{my.landingPageURL}}
- {{my.pfslidelink}}
- {{my.event owner}}

Follow up Emails

- {{my.zzfollow up slides or recording link}}
- {{my.zzFollow up CTA link}}
- {{my.zzFollow up event or asset description}}
- {{my.zzFollow-up short event description}}
- {{my.zzFollow up Event or Asset name}}
- {{my.zzfollow up slides or recording link}}
- {{my.zzFollowup - trial bullets}}

Marketo landing page tokens

- {{my.webcastSubtitle}}
- {{my.introParagraph}}
- {{my.bullet1}}
- {{my.bullet2}}
- {{my.bullet3}}
- {{my.bullet4}}
- {{my.speaker1Name}}
- {{my.speaker1JobTitle}}
- {{my.speaker1Company}}
- {{my.speaker2Name}}
- {{my.speaker2JobTitle}}
- {{my.speaker2Company}}

## Users have the option of starting event creation within either platform

### Event Creation within Goldcast 

When starting event creation in Goldcast, start by clicking the `+` icon in the top right of the platform. If you are starting a standard webcast, select `New Webinar` from the selections.

Fill in your `Title`, `Pick a Date`, `Start Time`, `End Time`, `Timezone`, and `Type`. GitLab as an org will likely stick with `Live` and `Pre-recorded` types. The `RTMP` type is a feature that allows embedding to or from external tools.

Select the template for your event. This covers a range of things, including the registration landing page, automated registration/reminder emails, the event console look & feel and the registration form format. 

Tag your events based on region, topic, team, etc criteria for better event reporting. 

Standard GitLab events will be within the `GitLab Inc` Team Workspace.

Select a repeating event schedule, if desired. Note this functionality has not been fully tested with Marketo in mind. 

If the event is for testing, toggle off the `Test Event` toggle. Test events max out at 10 registrants within the event. Test events also do not record and cannot be converted for `on-demand` viewing.

If the Marketo program cloning feature worked correctly, Goldcast will have created a new Marketo program based on your Goldcast event within the `Templates - Goldcast Webcasts` folder or within whichever folder the program template lives in Marketo. The name given to the new Marketo program will match the Goldcsat event, plus a timestamp. Rename the Marketo program to fit the regular naming convention (`YYYYMMDD_EventName_Webcast_Goldcast_template`) and move the program to the appropriate folder for the FY/quarter within Marketo. 

### Event Creation within Marketo

When starting event creation in Marketo, make a duplicate of [YYYYMMDD_EventName_Webcast_Goldcast_template](https://engage-ab.marketo.com/?munchkinId=194-VVC-221#/classic/ME21842A1) and move it to the appropriate folder for the quarter and using the standard naming convention.

Once the program is up, grab the program ID number. The program ID number can be found at the end of the program's URL and between the letters,  i.e. `classic/ME**00000**A1`. The program ID will be placed into your Goldcast event.

To place the Marketo program ID in Goldcast, go to and click into your event. Within the event, click in this order `Integrations` -> `Marketo` -> `Settings`. Place your Marketo program ID into the `Connected Program ID` field and click connect. The Goldcast event and Marketo program are now linked.

Once the Goldcast event and Marketo program are connected the Marketo program tokens will populate.

## Program Member Status Processing

When the Goldcast event and Marketo program are connected, Goldcast will automatically change the program status for all members without the need for a smart campaign. However, processing smart campaigns are still needed for other data appending requirements:

### Smart campaigns for Marketo landing page based registration

- `01a Marketo Form Registration`: This smart campaign **must** be active for Marketo LP registrations. Without this smart campaign, registrants will not be added to the Goldcast event and will not receive a registration confirmation email. Once the event is over, turn this smart campaign off
- `01c Marketo Form Fill Waitlist`: If registration has maxed out for the event, deactivate the `Registration` smart campaign and turn this one on to add regsitrants to the waitlist
- `01e Waitlist to Registered`: If you plan to change registrants who are currently listed as `Waitlisted` to `Registered`, turn this smart campaign on first. It refreshes the `Interesting Moment` and calls the Goldcast webhook 

### Additional smart campaigns

- `02 Goldcast Form Registration and Live`: Goldcast automatically changes program statuses when events and Marketo programs are connected. This smart campaign watches for program status changes for `Attended`, `No Show`, `Canceled`, `Rejected`, `Waitlisted` and `Registered`. If the event's registration is started on a Goldcast landing page, this smart campaign needs to be turned on immediately and before invite emails are sent out to invitees. This smart campaign needs to be active before the event, regardless of registration landing page location
- `03 Goldcast Processing - On Demand - Goldcast/Pathfactory`: This smart campaign is designed to process `on-demand` attendees based on either Goldcast post-event viewing or Pathfactory viewing. Needs to be turned on within 30 minutes of the webcast ending to work correctly for Goldcast on demand attendees
- `04 Goldcast Processing - Engagement`: Under construction - Intention is to mark leads with the `Follow Up Requested` status. 

## Navigating Inside a Goldcast Event, pre-live

From within a Goldcast event, there are a four primary tabs most will utilize: `Event`, `Registration`, `Analytics` and `Edit Event`. The `Email` and `Integrations` tabs are likely to go unused by most, as those deal with email schedules and the Marketo integrations --which are already set--. However, in the event of the Marketo token sync failing, the FORM ID and EVENT ID are located in the Integrations menu 

### Edit Event Menu

Multiple ways to edit your event are within this menu, including but not limited to: 

- Changing the name, description, time and tags of the event
- Toggling on/off waitlist, captions, registration limit, test event and convert to on-demand functionalties
- Upload functionality for your event's assets, such as slides, videos, polls, post-event surveys and downloaded content
- Changing your events from Live to Pre-recorded broadcast types. RTMP is also available (broadcasting to or from a separate webcast service) but as an org GitLab is unlikely to use this 
- Attendee privacy and attendee chat settings

### Event Menu

Much of the primary look and feel + external facing event information is found in this menu

- Inviting speakers and staff to your event takes place in this menu - which automatically send invite emails to those individuals
- Upload information about your event's speakers and staff on this menu, such as names, titles and photos
- Renaming the speakers tab and supplying a description in this section also an option

Viewing as an registrant or making changes to your emails, event stage and registration page also occur on this menu. Changes to email are likely unneeded due to the schedule and template already being set, however,

To make changes to the registration page or event stage, hover over either and select `Design`. Landing pages are customized via a block system, where blocks can be added, hidden or entirely removed. Note that Speaker info will be added to landing pages once Speakers are loaded into the event. The included templates for the landing page and event stage are the suggested starting place and are customizable from there. It's a good idea to explore and customize the Event Stage so producers know what features to expect during the live event. 

Lastly, AI created content based on your even can be sorted and viewed here. This section only occurs after the event has concluded and the platform has had time to process the recording.

### Registration Menu

This menu is where registrant management occurs

- Program and Event Statuses can be controlled from this menu or from within Marketo. Statuses will sync automatically between the systems. From within Goldcast, the only statuses available for manual change are `Registered`, `Canceled` and `Rejected`. 
- `Waitlisted` is assigned automatically by changing the event settings and may cause an error in Marketo to change registrants manually from `Registered` to `Waitlisted`
- `Canceled` disables access to the event whereas `Rejected` is treated more like `blocked`
- Tracking Pixels and Tags are applied via the template and should not be tampered with without discussing with Marketing Ops/Analytics
- `Form` allows changes to the registration form, like adding or removing fields. If there is a need to have more custom field data in Marketo, consult Marketing Ops and do not make such a change yourself

### Analytics

This section allows for viewing of data directly collected by Goldcast, such as email send rates, survey+polls results and engagement stats. Not all of this information is shared to Marketo at launch and plans to export some of this data will come later

This section also gives access to see registrants' `Magic Links`. A magic link is the link emailed directly to registrants that allows them to access the event. In the event a user reaches out about not getting access to the event, this is the custom link they need 

## Content Hub

under construction
