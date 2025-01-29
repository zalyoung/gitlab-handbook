---
title: "Red Team"
no_list: true
---

GitLab’s internal Red Team conducts security exercises that emulate real-world threats. We do this to help assess and improve the effectiveness of the people, processes, and technologies used to keep our organization secure. We follow the GitLab Values as much as possible to transparently collaborate with teams within Security Division, and the wider company, for the best possible result.

Malicious actors are not constrained by the narrow focus of traditional security testing. We must take on this adversarial mindset in order to challenge our own assumptions and identify areas for improvement across our entire organization. We do this by emulating the real-world tactics, techniques, and procedures (TTPs) of threats that are most relevant to our environment.

## What are you looking for? (GitLab team members)

- "**Is this the Red Team? / Is the activity I'm seeing part of a red team operation?**" Did you find something potentially malicious and you think it might be us? :point_right: [Is this the Red Team?](how-we-operate/#is-this-the-red-team)
- "**I have some attacker related ideas that could be quite interesting!**" :point_right: [Contact us](#contact-us)
- "**Do you do penetration testing?**" :point_right: No. :smile: We don't do vulnerability enumeration. See [Services we offer](#services-we-offer)
- "**I want to upskill in Red Teaming**" :point_right: See [resources](#additional-resourcesfurther-reading), [Club Red](opportunistic-attacks#club-red)
- "**Can you hack me?**" :point_right: GitLab team members can sign up to our [laptop opt-in programme](https://forms.gle/kMTJEjzktcjAbTVn9)
- "**Can you help us with an incident?** Does this look like hacker stuff in these logs?" :point_right: [Contact us](#contact-us)
- "**Can you help find bugs in GitLab the product?**" :point_right: You're better off asking [Security Research](../../product-security/security-research/)

## Contact Us

- GitLab team members: Come chat with us on Slack in `#sd_security_redteam` or via Direct Message.
- General public: _email?_

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

Further details about Red Team roles can be found in the [job family description](/job-families/security/red-team).

## Services we offer

In everything we do, we follow our [rules of engagement (RoE)](how-we-operate/rules-of-engagement).

We do not perform penetration tests (vulnerability enumeration) or product vulnerability research (see [Security Research](../../product-security/security-research/)).

### Stealth operations

Our primary service. Stealth operations are typically 3-9 months in length and are focused on emulation of relevant threats to GitLab. We work closely with the Threat Intelligence team to identify an adversary that might pose a security risk to GitLab. Using tools we've developed similar to those of the adversary, we carry out the attack on GitLab's systems. We use stealth, testing the defenses realistically and without introducing unnecessary risk. [Read more...](stealth-operations)

### Opportunistic attacks

These are short (a few days), more spontaneous attacks against GitLab systems when a potential initial access vector comes to our attention. Depending on what we find, we can either raise an incident ourselves, or continue as attackers would until discovery. We're looking to formalise this to a framework for discovering initial access more efficiently and iteratively. [Read more...](opportunistic-attacks/)

### Purple teaming

Purple team represents a collaborative exercise between the Red team and Blue team (our defensive teams, usually [SIRT](../sirt/) or [Signals Engineering](../signals-engineering)). These can be:

- flash operations which are short (1-2 weeks) exercises to test our defenses against a tool or technique used by an emerging threat or
- longer-term collaborations such as [Atomic Testing](purple-teaming/atomic-testing)

[Read more...](purple-teaming/)

### Research

Understanding emerging technologies and tools helps us anticipate adversaries' evolving tactics. It also means we can more effecively emulate those attackers.

Formalized operations and opportunistic attacks both require extensive research, and we factor that in when planning these activities. Outside of that context, the Red Team may conduct research with an intent to provide helpful information to others in the security industry and the wider GitLab community.

Examples include:

- social engineering techniques
- stealth and defense evasion techniques
- AI for offensive security
- tools such as enumeration/scanning tools, command and control (C2) frameworks
- malware found in the wild

We publish tech notes that summarise some of our research as part of responsible disclosure. Explore our [list of tech notes, blogs and other research](https://gitlab-com.gitlab.io/gl-security/security-tech-notes/red-team-tech-notes/) and [public Git repository of some past tooling and techniques](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-public/).

## How We Operate

The Red Team operates under a predefined set of [rules of engagement](how-we-operate/rules-of-engagement). These rules provide guidelines for determining scope, the ethics we employ during our engagements, how we collaborate as a security team, and how we escalate vulnerabilities and exploits we discover during those engagements.

We also track results via metrics which are available internally, including MITRE heatmap to ensure coverage of relevant attacker activity.

[Read more...](how-we-operate/)

## Additional Resources/Further Reading

- [Public Red Team repository](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-public)
  - Contains tools, scripts/proofs of concept and tech notes that have been made public
- [Internal Red Team repository](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-internal) (Available for GitLab team members only)
- Link to blogs, tech notes, etc.

## Is This the Red Team?

GitLab team members: See something potentially suspicious and want to check in with us? We won't answer this question. Read more about why in [_Is This the Red Team?_](how-we-operate/#is-this-the-red-team)

**All suspicious activity should be treated as potentially malicious and acted upon accordingly**.