---
title: "Impartner"
description: "PRM and Partner Portal"
---

GitLab uses Impartner as our primary Partner Relationship Management (PRM) platform, partner portal, MDF requests and marketing center for both Alliance and Channel Partners.

## PRM MDF Approval/ Process

The Channel Marketing team offers Market Development Funds to support the Partner's marketing campaigns and events. Channel Partners submit the MDF request and claim to the Partner Portal, and they must be approved before being reimbursed. 

### Step 1 - MDF Request Submission

On the MDF Request Form, Partners are required to provide the following:

1. Activity Name
2. Type of Marketing Activity
3. In Person or Virtual Event
4. Description
5. Expected Start Date of Activity
6. Expected End Date of Activity
7. Total Cost of Activity (USD)
8. Target Number of Contacts
9. Estimated Pipeline Created (USD)
10. Partner Investment (Your Investment in USD)
11. Total Amount Required (From GitLab MDF Program in USD)
12. Vertical Industry Target Type
13. Segment Target Type

Once submitted, the Partner will receive a confirmation email indicating that their MDF request has been received.

### Step 2 - MDF Request Approval

The MDF Request Approval process will kick off as soon as the Partner submits the MDF Request.

The GitLab team member of the Activity Location will receive a notification requesting to accept or reject the MDF Request. This means if global Partner runs an event in AMER, the approval will be routed to the AMER CMM, and if they run an event in EMEA, the approval will be routed to EMEA CMM.

The GitLab team member must use the links below to review the MDF request submission, however, you can only approve or deny directly from the email notification.

Should you want to review all your requests, [see section](/handbook/marketing/marketing-operations/impartner/#prm-mdf).

Note that, when you have a planned PTO, Marketing Ops will need to add your manager as a secondary approver. Previously, you can do this in Salesforce, however, you’ll need to create an issue request for support from MktgOps.

### Step 3 - MDF Claim Submission

Once the MDF Event End Date has been reached, the Partner will receive reminder notification on the 2nd, 14th and 28th day since the End Date to submit their MDF Claim.

On the MDF Claim Form, Partners are required to provide the following:

1. Claim Title
1. Claim Amount
1. Paid Date
1. Proof of Performance attachment
1. Lead List attachment

Once submitted, the Partner will receive a confirmation email indicating that their MDF request has been received. If the Partner doesn't upload more than 2 attachments, the Partner will be notified to ensure they have provided all the necessary attachments.

### Step 4 - Check Attachments

When the Partner has uploaded the Proof of Performance and Lead List attachments, the GitLab team member will be asked to check to ensure they are infact the right attachment.

   - If they are missing an attachment, the GitLab team member is required to update the field, `Missing POP` with the missing item. This will trigger an automated message to Partner will add the selected item to the Claim.
   - If all attachments are received, the GitLab team member will update the check box to `POP Received`. This will trigger the MDF Claim Approval Process.

### Step 5 - MDF Claim Approval



## MFB MDF Request Form

We can make edits to the form, which is built using  the Module Form Builder (MFB). This dynamic page is editable by GitLab by anyone with the correct permissions in PRM.

1. From the PRM, you will want to access the CMS editor using the red pen icon on the top right.

    ![Impartner PRM CMS Editor](/sites/handbook/source/handbook/marketing/marketing-operations/impartner/impartner-prm-cms-editor.png)

2. Click on the hamburger menu in the top left of the page and select `Edit Forms`.

    ![Impartner CMS Editor Edit Forms](/sites/handbook/source/handbook/marketing/marketing-operations/impartner/impartner-cms-editor-edit-form.png)
3. Under the Select a Module to Edit section choose `SFDC - Marketing Development Funds`.

    ![Impartner CMS Editor Module](/sites/handbook/source/handbook/marketing/marketing-operations/impartner/impartner-cms-editor-modules.png)

4. Select the MDF forms, you wish to update. You can edit the following form:

    - Create - Funds Request
    - Edit - Funds Request
    - Create - Funds Request - Funds Claim
    - Edit - Funds Request - Fund Claim.

5. When you've clicked any of the MDF forms, you will be able to add, remove and update the form fields and layout.

    ![Impartner CMS Form Editor](/sites/handbook/source/handbook/marketing/marketing-operations/impartner/impartner-cms-editor-form.png)

6. Save and Publish.

## PRM MDF 

To access your MDF request, go to PRM, and retrieve the `MDF` tab. If you do not see it, go to the `More` tab, there you'll be able to see the hidden tabs.

The preset filter will display all MDF requests that are Pending, Approved and Denied.

Should you wish to have a customized view, following the instructions below.

1. Go to the `Pending` tab 
1. Select the three dots in a circle, and `Create From Current View`
1. Update the Name to "My Pending Requests"
1. Set Visibility: "Private - can only be seen by me"
1. In Manage Filters, Click on `+Add` 
     1. Field: `Activity Location - Region`
     1. Operator: `equals`
     1. Type: `Value`
     1. Value: Select the region that applies to you
1. In Column Configuration, add any additional fields.
1. Save and repeat for the other statuses - Approved and Denied.

## Salesforce - PRM Integration

