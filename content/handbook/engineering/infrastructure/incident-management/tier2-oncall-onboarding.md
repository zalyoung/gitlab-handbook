---
title: "Tier-2 Oncall"
---
The Tier-2 SME on-call program enhances incident response by establishing a second tier of specialized support to complement the existing SRE EOC (Engineering On-Call) rotation. Subject Matter Experts (SMEs) provide domain-specific knowledge to help resolve complex incidents faster, improve MTTR (Mean Time To Recover), and increase ownership and accountability for service reliability.

## Expectations

- Respond when paged by:
  - Tier-1 SRE EOC
  - Security
  - Self-Managed Support
- Assist with complex, domain-specific incidents that Tier-1 cannot resolve independently
- Maintain a 24/7/365 rotation with reliable coverage across time zones
- Acknowledge pages within 15 minutes and have a clear escalation path if the primary responder is unavailable
- Help define and maintain:
  - Escalation rules for your domain
  - Documentation and runbooks

## Onboarding Process for Teams

1. **Define SME group**
   - Identify team members who will participate in the rotation
   - Consider legal and employment restrictions for out-of-hours coverage
2. **Create onboarding issue**
   - Use the [Team incident onboarding template](https://gitlab.com/gitlab-com/gl-infra/production-engineering/-/issues/new?description_template=team-incident-onboarding)
   - Document escalation criteria and severity levels
3. **Set up on-call rotation**
   - Configure schedules in incident.io
   - Ensure pager settings and notification rules are set for each member of the new rotation.
4. **Document escalation procedures**
   - Define escalation chain for unacknowledged pages (who is escalated to if no one responds within 15-minute period)
5. **Complete training**
   - Ensure all participants understand their role
   - Review incident response procedures

## Next Steps

1. Double check your schedule to ensure coverage during holidays and team events
