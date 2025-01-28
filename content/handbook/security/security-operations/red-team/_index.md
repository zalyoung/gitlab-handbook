---
title: "Red Team"
---

# Red Team

GitLab’s internal Red Team conducts security exercises that emulate real-world threats. We do this to help assess and improve the effectiveness of the people, processes, and technologies used to keep our organization secure. We follow the GitLab Values as much as possible to transparently collaborate with teams within Security Division, and the wider company, for the best possible result.

## What are you looking for? (GitLab team members)

- "**Is this the red team?**" Did you find something potentially malicious and you think it might be us? :point_right: [Is this the Red Team?](#is-this-the-red-team)
- "**I have some attacker related ideas that could be quite interesting!**" :point_right: [Contact us](#contact-us)
- "**Do you do penetration testing?**" :point_right: No. :smile: We don't do vulnerability enumeration. See [Services we offer](#services-we-offer)
- "**I want to upskill in Red Teaming**" :point_right: See [resources](#additional-resourcesfurther-reading), [Club Red](opportunistic-attacks.md#club-red)
- "**Can you hack me?**" :point_right: GitLab team members can sign up to our [laptop opt-in programme](https://forms.gle/kMTJEjzktcjAbTVn9)
- "**Can you help us with an incident?** Does this look like hacker stuff in these logs?" :point_right: [Contact us](#contact-us)
- "**Can you help find bugs in GitLab the product?**" :point_right: You're better off asking [Security Research](../../product-security/security-research/)

GitLab’s internal Red Team conducts security exercises that emulate real-world threats. We do this to help assess and improve the effectiveness of the people, processes, and technologies used to keep our organization secure. We follow the GitLab Values as much as possible to transparently collaborate with teams within Security Division, and the wider company, for the best possible result.

## Contact Us

- GitLab team members: Slack :point_right: `#sd_security_redteam` or Direct Message.
- General public :point_right: _email?_

## General Information

### Vision

Improve GitLab's security posture and sharpen our defenses against constantly-evolving tools, techniques and procedures (TTPs) used by real-world adversaries. Continue to be a leader in the offensive security space with demonstrated transparency, collaboration and technical skill.

### Mission

- Leverage relevant threat intelligence to emulate realistic threats to our organisation. Do so ethically, safely, and collaboratively with the wider organisation.
- Demonstrate the risk and impact of misconfigurations and security gaps.
- Create recommendations to improve GitLab's security posture.
- Collaborate with industry peers and customers to share relevant techniques as appropriate.

## The Team

The Red Team is part of the Security Operations department. [See GitLab’s organizational chart in Workday and meet our team members](https://www.myworkday.com/gitlab/d/home.htmld).

Further details can be found in the [job family description](/job-families/security/red-team).

## Services we offer

In everything we do, we follow our [rules of engagement (RoE)](red-team-roe/)

### Stealth operations

Our primary service. Stealth operations are typically 3-9 months in length and are focused on emulation of relevant threats to GitLab. We work closely with the Threat Intelligence team to identify an adversary that might pose a security risk to GitLab. Using tools we've developed similar to those of the adversary, we carry out the attack on GitLab's systems. We use stealth, testing the defenses realistically and without introducing unnecessary risk. [Read more...](stealth-operations.md)

### Opportunistic attacks

These are short (a few days), more spontaneous attacks against GitLab systems when a potential initial access vector comes to our attention. Depending on what we find, we can either raise an incident ourselves, or continue as attackers would until discovery. We're looking to formalise this to a framework for discovering initial access more efficiently such as IAB or Club Red. [Read more...](opportunistic-attacks/)

### Purple teaming

Purple team represents a collaborative exercise between the Red team and Blue team (our defensive teams, usually [SIRT](../sirt/) or [Signals Engineering](../signals-engineering)). These can be:

- flash operations which are short (1-2 weeks) exercises to test our defenses against a tool or technique used by an emerging threat or 
- longer-term collaborations such as [Atomic Testing](purple-teaming/atomic-testing.md).

[Read more...](purple-teaming/)

### Research

We research upcoming technological trends and tools so we are familiar with them to keep current with the TTPs used by adversaries. Examples include:

- social engineering techniques
- stealth and defense evasion techniques
- AI for offensive security
- tools such as enumeration/scanning tools, command and control (C2) frameworks
- malware found in the wild

Formalized operations and opportunistic attacks both require extensive research, and we factor that in when planning these activities. Outside of that context, the Red Team may conduct research with an intent to provide helpful information to others in the security industry and the wider GitLab community. This includes blogs, vulnerability disclosures, conference talks, tech notes, and so on. Explore our [public repository of some past research](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-public/). _(also blogs?)_

[Read more...](research.md)

## How We Operate

The Red Team operates under a predefined set of [rules of engagement](how-we-operate/rules-of-engagement.md). These rules provide guidelines for determining scope, the ethics we employ during our engagements, how we collaborate as a security team, and how we escalate vulnerabilities and exploits we discover during those engagements.

We also track results via metrics which are available internally, including MITRE heatmap to ensure coverage of relevant attacker activity.

[Read more...](how-we-operate/)

## Additional Resources/Further Reading

- Public Red Team repository :point_right: redteam-public
  - Contains tools, scripts/proofs of concept and tech notes that have been made public
- Internal Red Team repository :point_right: https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-internal (Available for GitLab team members only)
- Link to blogs, tech notes, etc.

## Is This the Red Team?

### Why we don't answer this question

The goal of a Red Team operation is often to test our policies and procedures when reacting to an actual threat. This includes identifying suspicious activity and following the appropriate runbook to investigate and respond to that threat.

If any team member, at any time, could simply ask *"Hey, this looks suspicious. Is this our Red Team?"* then this opportunity would be lost. **Instead, all suspicious activity should be treated as potentially malicious and acted upon accordingly**.

We have private Slack channels in place where designated team members can ask the Red Team if a certain activity belongs to them. This helps us to provide realistic opportunities to practice detection and response without escalating too far. For example, we would not want an emulated attack to affect production operations or escalate to third parties.

Managers at GitLab can also [submit a "Red Team Disclosure Request"](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-internal/red-team-operations/-/issues/new?issuable_template=request-for-disclosure) at any time. If the request contains evidence related to an ongoing Red Team operation, we will discuss next steps in the Slack channels mentioned above.

You can read more about this process in the ["Requests for Disclosure" section]({{< ref "red-team-roe#requests-for-disclosure" >}}) of our rules of engagement.

### How the Red Team will respond to this question

If the Red Team is ever asked *"Is this you?"* by someone other than the designated team members mentioned above, they will respond with the following text:

> Thanks for your vigilance! Any suspicious activity should be treated as potentially malicious. If you'd like to contact security, you can follow the process [here](../engaging-security-on-call).
>
> Red Team operations provide an opportunity to practice detecting and responding to real-world attacks, and revealing an operation early might mean we miss out on that opportunity. Because of this, we have a policy to neither confirm nor deny whether an activity belongs to us. You can read more about this policy here: [{{< ref ".#is-this-the-red-team" >}}]({{< ref ".#is-this-the-red-team" >}}).

### How others should respond to this question

Because we want to treat all activity as potentially malicious, anyone else receiving this question should also use a consistent response. Feel free to use your own words. The following can be a guide:

> We want to treat any suspicious activity as potentially malicious. Let's continue following our normal procedures to report and investigate this. Any Red Team operation will have controls in place to keep things from escalating too far. You can read more about this here: [{{< ref ".#is-this-the-red-team" >}}]({{< ref ".#is-this-the-red-team" >}}).

If the person receiving this question happens to be a Security Director or a trusted participant in an ongoing stealth operation, they can then use established channels to communicate with the Red Team.
