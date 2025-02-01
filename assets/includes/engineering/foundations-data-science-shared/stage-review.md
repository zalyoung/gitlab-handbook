The Engineering Stage Review is a monthly Engineering Manager meeting designed to evaluate team productivity, technical progress, and key metrics across the stage groups. In this meeting, we assess team productivity metrics and trends at a stage-wide level, review technical roadmap progress and align initiatives across teams, identify areas for improvement and discuss action plans, and connect related technical work across different teams.

**Format:**
- 50-minute monthly sessions, split into two parts:
	- Data Science Session (covering AI Framework, Custom Models, MLOps, Duo Chat)
	- AI Powered & Foundations Session (covering Duo Workflow, Global Search, Design System, Personal Productivity, Import & Integrate)
- Each team has approximately 10 minutes for review
- Metrics and updates are submitted 24 hours before the meeting for async review

#### How to report

<details markdown=1>
<summary>Metrics</summary>

**MR Rate Analysis**
* Pull individual contributor MR rates from the [MR Rates Dashboard](#metrics)
* Calculate team average, accounting for role differences (e.g., senior engineers may have lower MR rates due to higher review loads or much higher MR rates due to more seniority)
* Note significant deviations from team's historical average
* Identify and document factors affecting the rate, such as:
  * Team PTO patterns
  * Incident response time
  * Large technical initiatives requiring extensive review

**Mean Time to Merge (MTTM)**
* Review individual MTTM from the [Mean Time To Merge Dashboard](#metrics)
* Calculate team average
* Document any notable changes and their causes, such as:
  * Changes in review processes
  * Complex feature implementations
  * Cross-team dependencies

**Average (Review) Approval Time to Merge**
* Pull individual Approval Time to Merge times from the [Review Rate Dashboard](#metrics)
* Calculate team Approval Time to Merge from those numbers
* Document factors impacting review speed, such as:
  * Code complexity
  * Context switching costs
  * Review load distribution

**Review Volume Analysis**
* Track number of [reviewed MRs per team member](#metrics) to get the teams Review Rate average
* Analyze review load distribution across the team
* Note patterns affecting review capacity:
  * Review bottlenecks
  * Cross-team review requirements
  * Technical specialty dependencies

**Say/Do Ratio**
* Track committed vs. delivered work items based on the previous milestone
* Document reasons for any significant gaps between commitments and delivery
* Include context about scope changes or unexpected challenges

**Error Budget**
* Review the [Stage Group Error Budget dashboard](#metrics) for the previous 28 days
* Document:
  * Current error budget consumption
  * Trends since last review
  * Any significant incidents or reliability issues
</details>

<details markdown=1>
<summary>Technical Roadmap Updates</summary>

**Progress**
* Link each initiative to relevant epics
* Provide clear progress indicators wherever possible (e.g., 0%, 25%, 50%, 75%, 100%)
* Include status of key milestones
* Note any dependencies or blockers

**Impact**
* Document the impact of completed technical work
* Highlight cross-team benefits or dependencies
* Note any learnings or process improvements
</details>

##### Prioritize discussion points
- Label and lead with 🔺 items requiring immediate attention
  - **When to use**: Metrics show concerning trends, technical initiatives are behind schedule, unresolved blockers or dependencies, team is missing targets without clear action plans 
- Follow with 🟨 items if time permits
  - **When to use**: Metrics are off-track but have identified solutions, technical initiatives have known delays with mitigation plans, resource constraints exist but are being addressed, process improvements are in progress
