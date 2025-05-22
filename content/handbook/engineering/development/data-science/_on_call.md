---
title: Data Science stage on-call process
description: "T Data Science stage on-call process definition and explanation."
---

## Tier-2 on-call rotation

Our clients need support during incidents, and GitLab as a product has grown too big to expect any engineer to know everything about it. Because of those two factors, we need to have Subject Matter Experts (called further SMEs) to be able to help during incidents. This coverage needs to be reliable at all times, and cover 24x7x365.

### Eligibility

All Engineers (frontend and backend) level 6 (intermediate) and higher are eligible to participate in the rotation based on their knowledge level of the subject matter area.
The following exceptions apply:

- Engineers who have been at GitLab for less than 6 months
- Engineers who are on a performance improvement plan
- Engineers who are on extended leave (parental, medical, etc.)
- Engineers who have not completed the required on-call training

Engineers who participate in an on-call rotation have demonstrated strong technical expertise and incident response capabilities, and have received guidance from their manager.

### SME on call duties

The SME on-call is responsible for:

1. Being available to respond to incidents within 15 minutes during their shift
1. Providing technical expertise and guidance during incident investigations
1. Assisting with troubleshooting and resolving issues related to their area of expertise
1. Documenting incident findings and contributing to post-mortems
1. Identifying patterns and suggesting improvements to prevent similar incidents
1. Participating in handoff meetings with the next on-call SME

### Rotation cycles

The on-call rotation operates on a weekly basis, with shifts starting and ending on Wednesday at 00:00 UTC. There are 3 shifts: 1) 00:00-08:00 UTC 2) 08:00 - 16:00 UTC 3) 16:00-24:00 UTC. This schedule allows for:

- Adequate coverage across all time zones
- Reasonable workload distribution
- Sufficient time for knowledge transfer between rotations
- Flexibility to accommodate team members' schedules

Each engineer is typically scheduled for one week of on-call duty in their preferred shift every 3-8 weeks, depending on the size of the rotation pool.

(Alternatively, we can offer divide week into two: Wednesday/Thursday/Friday/Saturday and Sunday/Monday/Tuesday - this way noone needs to cover the whole weekend). 

### Rotation pool limitations

We require a minimum number of SMEs across all three regions, Asia-Pacific-Japan(APJ), Europe-Middle-East-Africa(EMEA), and Americas(AMER) to provide sufficient on-call coverage. When a team does not have enough eligible on-call engineers, they should consider partnering with another team to ensure comprehensive coverage. They need to make sure knowledge transfer between the teams to maintain effective incident response capabilities.

- Minimum 3 team members per SME group per region (e.g. 3 Americas + 3 APJ + 3 EMEA)

- Maximum 8 team members per SME group per region. 9+ team members will rotate to fill the 3 person minimum in another region.

Not all engineers are eligible for weekend shifts due to local labour law restrictions. Those SMEs won't be covering weekend shifts. Rotation coordinator is required to identify those individuals and create schedules that are compliant with local laws, also taking into consideration fair distribution of duties among all SMEs. 

### Weekend shifts, outside of working hours shifts

During on-call, there is no expectation for SME to be sitting at their laptop for the whole shift. They are required to be in a position to acknowledge a page and to join the Slack or Zoom call within 15 minutes. We still want to offer time-in-lieu for this disruption of making themselves available during the weekend and holidays.

Everyone is encouraged to explore options that work best for their personal
situations in lieu of weekend shifts. When on-call you have the following
possibilities:

1. Swap weekend days and weekdays.
1. Swap hours between weekend days and weekdays.
1. Take up to double the time off for any time worked during the weekend when the
above two options don't work with your personal schedule.

- When a SME is in standby mode (e.g. not paged) during the weekend shift, they can take 1.25x time-off.
- When a SME is in call-back mode (e.g. being paged) during the weekend shift, they can take double the time-off.

For those who reside in Australia, please refer to [these guidelines](https://handbook.gitlab.com/handbook/total-rewards/benefits/general-and-entity-benefits/pty-benefits-australia/#on-call-engineering-only) of time in lieu in the handbook.

Other alternatives that promote work-life balance and have the least impact to SME's personal schedule.

Please create an OOO event in Workday and choose On-Call Time in Lieu.

It is important to abide by local labor laws and you are encouraged to understand if there are restrictions around SME working time. The purpose of this information is to encourage SMEs to take time off according to their schedule to account for the interruption to their weekends/time off-work.

### Shift swapping

If SME on call cannot cover some hours/days of their shift, they should ask for coverage in the #.... Slack channel. In case there is no volunteer to swap shift, this should be escalated to the Rotation coordinator so they can decide of further course of action.

### Special coverage periods

During periods when majority of team members is taking time off (end of year holidays, holidays in one part of the world) the Rotation coordinator should create "Special coverage issue" in advance and make sure that there is enough SMEs to cover all shifts. That may require changing week-long shifts to one-day rotation or any other solution that provides team members opportunity to live our "Family and friends first, work second" value without affecting the integrity of on-call duties.

### System to alert SMEs

We use PagerDuty as our primary alerting system. SMEs will be notified through:

1. PagerDuty mobile app notifications
1. SMS messages
1. Phone calls (for critical incidents)
1. Slack notifications in the #incident-management channel

SMEs should acknowledge alerts within 15 minutes and begin investigation.

### Opting-out of rotation

Engineers may request to opt-out of the rotation for the following reasons:

1. Personal circumstances requiring extended time off
1. Medical conditions or reasonable accommodations
1. Temporary work arrangements that prevent on-call duties
1. Other exceptional circumstances

All opt-out requests must be approved by the Rotation coordinator (and engineering manager if different) and should be submitted at least 4 weeks in advance when possible.

### Cross-training

To ensure high-quality incident response, we maintain a robust cross-training program:

1. Monthly incident response workshops
1. Basic trainings for team members from other teams to grow the pool of SMEs
1. Shadow rotations for team members
1. Regular review of past incidents and lessons learned
1. Documentation updates and knowledge sharing sessions
1. Mock incident exercises and drills

Engineers must complete all required training before joining the rotation.

