---
title: "Working with Professional Services"
description: "Discover how to work with the GitLab Professional Services Team."

---

### How to Contact Professional Services

Questions that the field (AE, SA, CSM or other support roles) have for specific customers or engagements should be routed to the GitLab Professional Services (PS) Engagement Manager supporting that account. You can find the [EM to account team mapping here](https://docs.google.com/document/d/1sdehii3Eqp_CiYsGT3dDb0nKbbtwpxKQlni7t3ZgfCs/edit?tab=t.0#heading=h.1er41qhhpoj5) (internal team members only). You can collaborate with your EM in the [workflow listed below](For-Sales-Reps-How-to-request-support-from-Professional-Services-on-an-Account)  For general questions outside specific opportunity cycles, please  uses the [#professional-services](https://gitlab.slack.com/archives/CFRLYG77X) slack channel. The private [#professional-services-us-pubsec](https://gitlab.slack.com/archives/C025UHLTR50/p1625778195002900) slack channel is used for US Public Sector services.  Please request access to [#professional-services-us-pubsec](https://gitlab.slack.com/archives/C025UHLTR50/p1625778195002900) in [#professional-services](https://gitlab.slack.com/archives/CFRLYG77X).

#### Requesting training for GitLab team members

**For team leads**

Internal GitLab team leads can request training sessions delivered by Professional Services for their teams. Here are the steps for making a request.

1. [Create a new issue](https://gitlab.com/gitlab-com/customer-success/professional-services-group/education-services/-/issues/new?issue%5Bassignee_id%5D=&issue%5Bmilestone_id%5D=#) in the Education Services namespace using the internal_trainer_request issue template. or internal-team-member-training-request
1. Complete the Requestor Tasks in the issue description.
1. The PS Project Coordinator will reach out to plan and schedule the training session(s).

**For individual team members**

Individual GitLab team members can request to audit a customer-facing training sessions delivered by Professional Services. Here are the steps for making a request to attend.

1. [Create a new issue](https://gitlab.com/gitlab-com/customer-success/professional-services-group/education-services/-/issues/new?issue%5Bassignee_id%5D=&issue%5Bmilestone_id%5D=#) in the Education Services namespace using the internal-team-member-training-request template.
1. Complete the Requestor Tasks in the issue description.
1. The PS Project Coordinator will confirm the date(s) with you and provide you with a registration link.

### For Sales Reps: How to request support from Professional Services on an Account

1. To work with Professional Services, Account Executives should create a `Professional Services Only` Opportunity in SFDC from the parent subscription opportunity. This triggers automation to create a [scoping issue](https://gitlab.com/gitlab-com/customer-success/professional-services-group/ww-consulting/ps-plan/-/boards/5968112?label_name[]=Services%20Calculator) (internal team members only), from which wider collaboration will take place. 
2. Depending on the complexity of the customer situation, we can offer standard packaged services (e.g. SKU) or a custom tailored approach. Regardless of this approach, Account Teams should incorporate PS Engagement Managers to help determine best path forward. Below is a quick diagram that

**Process for Sales Reps and SAs**

```mermaid
graph LR;
  s-->a["AE talks with EM about PS"]
  a["Only SKU Services?"]-- Yes ---b["Add SKU to Order Form"];
  a-- No ---c["AE Creates PS Only Opportunity in SFDC"];
  c-->d["EM runs discovery with Customer"];
  d-->e["EM build estimate and proposal"]
  e-->f["EM reviews feedback, iterates, then moves to SOW]
  z["Send customer OF/SOW"];
  f-->z;
  b-->z;
```

For more details on selling professional services, see [Selling Professional Services](/handbook/customer-success/professional-services-engineering/selling).

For information on how to position Professional Services to your customer, see [Positioning Professional Services](/handbook/customer-success/professional-services-engineering/positioning).

#### SLAs during presales

1. Once the E has discussed with account team and has held the discovery call (or set of calls) with the Customer, EM will strive to turn around an estimate and proposal within 3 business days. Often times this can be shorter and in rare (very complex cases) it will be longer. On cases where we're expecting to break through the 3 day SLA, EMs will notify account team and customer to set expectations appropriately. 
1. Once the customer agrees to price and scope (note these are hard prerequisites to move to SOW), the EM will strive to have SOW drafted and approved to be sent to customer withing 3 business days. Keep in mind, this requires revenue and PS leadership approval. The larger the engagement, the longer this process will take. Again, if EM thinks it will take longer than 3 days, we will set expectations approirately with Account team and Customer.  

#### Lead time for starting a Professional Services Engagement

Often we are asked "what is your lead time for getting started with a project" or a customer may have a specific timeframe in which they want a project delivered.
As there may be many projects and proposals in flight at any time, there are a few rules we use when prioritizing and scheduling engagements:

- No engagement schedule can be committed to until the PS Opportunity is closed/ won and the PS Operations team has scheduled the project. While we can make a good faith effort to try and match a schedule ahead of that time, to be fair to customers who have committed to a services engagement we must prioritize those first.
- Please, check with the PS Operations Team by tagging the group `@ps-scheduling` for the latest lead time details in the [professional services slack channel](https://gitlab.enterprise.slack.com/archives/CFRLYG77X) if you need a more accurate estimate.
- The PS Operations team does review projects that are SFDC Stage 5.  As we strive to start the projects within days of the SFDC Stage of closed/won.

##### SOW Proposal Approval Board

![SOW proposal board screenshot](/handbook/customer-success/professional-services-engineering/sow-approvals-board.png)

The [SOW Proposal Approval Board](https://gitlab.com/groups/gitlab-com/customer-success/professional-services-group/-/boards/1353982?label_name[]=Services%20Calculator) is used to progress all SOWs through the scoping and approval process before sending them to a customer for review and signature.

**SOW approval workflow labels**

The labels are (from left to right):

- `Open`: This issue has been created by the Services Calculator and waiting for the Engagement Manager to confirm
- `proposal::Awaiting_Discovery`: Gathering information from the account team and customer required to scope the engagement
- `proposal::Strawman_WIP`: The Engagement Manager is drafting an initial estimate for review
- `proposal::Estimate_Feedback`: The Estimate is with the account team and/or Customer for review. The Engagement Manager is awaiting feedback and confirmation prior to moving to SOW.
- `proposal::SOW_WIP`: The Engagement Manager is drafting the SOW and preparing a [Cost Estimate](/handbook/customer-success/customer-success-vision/#professional-services-standard-cost) using the [SOW Cost Estimate Calculator](https://docs.google.com/spreadsheets/d/16KFNRFe4E_oaqU7_ZGivoO7eU3-65dkMgVvK5Jvb7ZQ/edit#gid=158441360) for margin calculation purposes
- `proposal::Ready For Approval`: The Engagement Manager has prepared the required SOW, and triggered the approval requests. Approvals are now required prior to releasing the SOW.
- `proposal::Approved`: The SOW is now approved, and ready for execution. The SAE/AE should gain a Legal stamp via a Legal Case in SFDC before releasing the SOW for signature.

### Scheduling Professional Services

Currently, customer projects are scheduled in order as the opportunity is Closed-Won.  Please discuss any concern about scheduling the project during the Discovery phase of the scoping process. As part of the Discovery phase, please update the Project Scheduling Intake issue. The Project Coordinator will use this information to review staffing. If there are lead time or availability questions, please ask the Enagagement Manager or Project Coordinator by tagging the group @ps-scheduling in the [professional services slack channel](https://gitlab.enterprise.slack.com/archives/CFRLYG77X).
Please do not commit any project start dates prior to the SOW/contracts being signed without confirming with the PS Project Coordinator.

Once the opportunity is updated to Close/ Won, here are the next steps:

- The PS Project Coordinator will review the SOW and Order Form and work to set up the project in Kantata
- The PS Project Coordinator will reach out the account team for the customer contacts if the information has not been provided in the Project Scheduling Intake issue.
- The PS Project Coordinator will send a Welcome to PS email within 72 business hours of the opportunity booking to the customer and copy the account team and Professional Services leaders.
