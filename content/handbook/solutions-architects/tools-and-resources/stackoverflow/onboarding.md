---
title: Onboarding Users on StackOverflow
description: Onboarding Users on StackOverflow
---

The process and workflow to onboard and offboard SAs, CS, PSEs and SMBs onto and off Stack Overflow is described here.

## Onboarding

### SA, CS and Professional Services Team Members

When a new GitLab Team member joins one of these teams, they are automatically added to the appropriate Okta group for accessing Stack Overflow.  The Stack Overflow tile will be present in thier lists of accessbile applications due to their role. 

### SMB Team Members

When joining the SMB Team, the current process is to have the SMB [Community Manager](/handbook/solutions-architects/tools-and-resources/stackoverflow/administration/#community-managers) add the new team member(s) directly to the [Stack Overflow Google group](https://groups.google.com/a/gitlab.com/g/okta-stackoverflow-users) as a "Member".  Adding a name to that group will allow the SMB team members to access the Stack Overflow Okta tile. 

## Offboarding

When a team member is being Offboarded, access to their Okta groups will be will revoked as part of the regular GitLab [Offboarding](/handbook/people-group/engineering/offboarding/) process. However, due to the nature of the way it's currently set up, the user will need to be manually deactivated within Stack Overflow. 

### Addtional steps for Stack Overflow Admim to Deactivate a User

1. Log into Stack Overflow
2. Click on "Users" in the left nav bar
3. Click "Manage Users" in the upper right of that screen
4. Search for the members name that has recently left GitLab
5. Click the "..." button under Actions and select "Deactivate" (do not select Delete)

Deactivating a user will keep thair name and contribution history but free up a license for others to use in the future. 
