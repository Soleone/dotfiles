---
name: session-ummary
description: Generate session summary with timeline, impact, and slack message
---

Analyze this conversation and provide a structured summary.

## Data Collection Steps

### Step 1: Get User's Timezone

`readlink /etc/localtime | sed 's|.*/zoneinfo/||'`

Returns timezone like "America/Toronto" or "America/New_York

Step 2: Get Today's Date and Midnight Epoch

# Current date in YYYY-MM-DD format
TODAY=$(date +%Y-%m-%d)

# Today at midnight in local time (seconds since epoch)
date -d "$TODAY 00:00:00" +%s 2>/dev/null || date -j -f "%Y-%m-%d" "$TODAY" +%s 2>/dev/null

Note: First command works on Linux, second on macOS

Step 3: Read Git Commits from Today

git log --all --pretty=format:"%ai | %s" | grep "$(date +%Y-%m-%d)"
Git timestamps are already in local timezone.

Step 4: Read Conversation History

Read session history from agent
- timestamp: Unix epoch in milliseconds (UTC)
- display: User's message
- project: Working directory

Critical: Timestamps are in UTC, need to subtract 5 hours (18000 seconds) for EST

Step 5: Filter Today's Messages with Timezone Conversion

# Get today's start in epoch seconds
TODAY_START=$(date +%s -d "$(date +%Y-%m-%d) 00:00:00" 2>/dev/null || echo "1762232400")

# Filter and convert UTC to e.g. EST (subtract 5 hours = 18000 seconds)
tail -1000 ~/.claude/history.jsonl | jq -r "select(.timestamp/1000 >= $TODAY_START) | [(.timestamp/1000 - 18000 | gmtime | strftime(\"%H:%M\")), .display[0:120]] | @tsv"

Step 6: Build Timeline

Match message timestamps to git commits. Group messages into topic phases.

Output Format

## Timeline of Topics and Major Events

Group prompts by topic/phase. For each phase:
- HH:MM-HH:MM - Topic description (Xmin)
- List 2-4 key prompts/activities as bullets
- End with Commit HH:MM: message if applicable

All times in local timezone (EST). Calculate durations from message timestamps.

## Impact Delivered

3-5 bullets on concrete deliverables and breakthroughs

## Time Spent Without Direct Impact

3-5 bullets honestly assessing inefficiencies

## Final State

What Works: (✅/⚠️/❌)Current Limitations:Path Forward:Commands:

## Slack update

Generate a bulleted list suitable for a daily update. Format:

**[Project/Area] - [Date] Session**

Bulleted list (3-5 items):
- Focus on what was built/improved TODAY (not pre-existing functionality)
- Be direct and factual, avoid marketing language
- Include specific metrics where relevant
- Note blockers or current limitations

Keep it concise. Avoid jargon like "breakthrough", "game-changer", etc.

Guidelines

- Avoid python, ruby for timezone calculations
- Convert UTC to correct local timezone
- Filter messages for current project working directory
- Group related prompts into logical topic phases
- Calculate durations: (end_timestamp - start_timestamp) / 60 seconds = minutes
- Be specific and honest about inefficiencies
- For the top level don't use numbered lists, use h2 headers. Don't use h1 headers at all.
- Make sure to surround code or terminal sections with code formatting (e.g. a # comment should not accidentally be a markdown headder)