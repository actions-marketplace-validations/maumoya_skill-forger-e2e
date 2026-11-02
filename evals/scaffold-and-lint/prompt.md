---
tags: [skill-end-to-end]
max_turns: 20
timeout_seconds: 600
allowed_tools: [Read, Write, Edit, Glob, Grep, Skill, Bash]
---

I checked and there is no good skill for this, so let's build it. Make a skill called meeting-notes that turns a pasted meeting transcript into decisions, owners and due dates, and never invents an owner who was not named. Triggers: "meeting notes", "action items", "who owns what". Done when: every action item has an owner from the transcript or "unassigned", and every decision is quoted. Put the repo in ./meeting-notes, owner name "Test Owner", GitHub user testowner. Get it to pass the linter.
