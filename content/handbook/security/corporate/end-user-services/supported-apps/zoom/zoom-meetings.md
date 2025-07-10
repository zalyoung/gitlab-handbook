---
title: Zoom Meetings
description: Schedule and host meetings
---

## Setting up a Zoom Meeting

*To set up a Zoom meeting, sign in via Okta and share the link for your "personal meeting room" with your participants.*

### Using your personal link versus a unique/random link

Your personal link is a great way to provide a consistent, easy-to-read-and-remember meeting room for colleagues and customers.
However, there are some drawbacks to reusing the same meeting, such as participants joining an ongoing meeting when two are scheduled back to back.
In some cases it may be better to use a unique meeting link.

Here are some good use cases for the personal link:

- Recurring or standing meetings, especially those with a large or frequently changing attendee list.
- First meeting with a customer, where a simple and readable link is helpful for ease of participation and branding.
- Webinar or training session where your Zoom link may be shared in a display (non-clickable) format, and will need to be typed in manually by attendees.
- Interviews so the candidate can see your name for the meeting link, not a random number. Keep in mind candidates may be scheduled for 3-5 interviews all at once and we don't want to create confusion.

Here are some good use cases for a unique link:

- Meetings scheduled in rapid succession or back-to-back, to ensure only the invitees for each meeting arrive to the right session.
- A meeting where privacy is a principal concern (this dovetails with the first bullet point)
- A meeting where most attendees will be joining via a shared link or calendar invite, and will not need to type the link manually.

Use your best judgement on when to use each type of link.
Not all situations will fit cleanly into any of the given scenarios, and your needs may vary.

### Allow for browsers

Not everyone has a Zoom client, so you can allow for invitees to choose to use Zoom from the browser.
Go to **Settings > In Meeting (Advanced)** and click next to "Show a 'Join from your browser' link" to make this option available in your meeting invites.
The browser version of Zoom is not as full-featured as the regular client, but it doesn't force an invitee to download the Zoom client.
This also mitigates the issue of potential weak communication encryption since the browser uses HTTPS instead of Zoom's proprietary encryption scheme.

### Large meeting considerations

It can be distracting when a call with a large number of attendees has folks joining unmuted. For [Assembly](/handbook/company/gitlab-all-company-meetings/), CEO [AMAs](/handbook/communication/ask-me-anything), and other meetings in which we expect an attendance of over 25 folks, meetings should be scheduled, so that folks enter on mute. These folks can then opt to unmute as required to participate in the conversation.

If a team member in a meeting is not on mute but creating sound that is distracting, any other team member should feel empowered to put this person on mute. A person must be a co-host or host to put someone on mute. If you are the host and you'd like help with muting people, ensure that "co-host" is enabled in your Zoom settings. During meetings, you can click on individuals in the meeting and designate them as "co-hosts."

---

## During your Zoom Meeting

*Zoom can be [minimized](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0063672#h_29171b3b-71eb-4b42-8bc4-30bf2f778d95) during a meeting (`cmd-m` on macOS) to a small window staying on top of all applications.
This tip is very handy when using a small screen: it allows to see the participant(s) and use other applications at the same time without worrying about the screen layout.*

### Recording in Zoom

In order to be able to record your Zoom meetings you must first enable recordings in your Zoom profile.
You can access this page at [Recording Settings](https://zoom.us/profile/setting?tab=recording).
You need to be signed in to have the ability to record.

To auto-record meetings set up [cloud recording](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0067954).
You can also configure Zoom to save to the cloud automatically.
Go to "My Meeting Settings" and find the "Recording" section, then click on "Cloud Recording".
Setting the topic of the meeting is important, otherwise all meetings will be recorded with a generic name.
Once recording is complete, your videos will not appear in the "Recordings" section of your Zoom account.

If the meeting topic in Zoom (editable by logging into <https://zoom.us/>) contains the text `[REC]`, these recordings will
automatically be saved to a folder on Google Drive under `GitLab Videos Recorded` (accessible from [Google Hidden shared drives](https://drive.google.com/drive/shared-drives-hidden)).
The name of the folder will be prefixed by the host's e-mail
address. For example, if the host is `someuser@gitlab.com` and the
meeting title is `Company Training [REC]`, the folder will appear as
`someuser@gitlab.com-Company Training`. [The script](https://gitlab.com/gitlab-com/zoom-sync/-/blob/a73aee8f5921ac3fec16b74232ac17add4e33afb/zoom-sync.rb) (from [the zoom-sync project](https://gitlab.com/gitlab-com/zoom-sync)) will sync the recordings every hour.

To make it easier for meetings to be uploaded automatically without
changing the title, the sync script also uses an [allow list](https://gitlab.com/gitlab-com/zoom-sync#allow-list).
If a meeting title matches the provided regex with the given host's e-mail address, the
meeting will also be uploaded to Google Drive. File a merge request
to change [the current list](https://gitlab.com/gitlab-com/zoom-sync/-/blob/master/zoom_sync.yml).

Consider setting your default recording view to "Gallery view".

To do this:

1. Login to zoom.us.
1. Click the Settings tab on the left side bar, then the Recording tab on the top horizontal options.
1. Make sure you have `Record gallery view with shared screen` selected
1. Unselect `Record active speaker with shared screen` and `Record active speaker, gallery view and shared screen separately`.
   Remember to save.

You can also read through General information on recording on the zoom support [here](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0059856)

### How to identify the meeting host with the permission to record

You can use one of the below methods to find this information after joining the meeting.

1. Via participants sidebar.
   1. Navigate to the participants icon on the bottom of the window.
   1. You will be presented with the list of participants on the right panel of the window.
   1. The host will be listed in parentheses at the end of their name. (A resize of the participants window may be needed).
1. Via meeting info pop-up.
   1. Navigate to the upper left corner, where you will be presented with an i icon.
   1. Select the icon to locate the meeting host who will have the ability to record the call.
