---
description: Execute a prompt and copy the response to clipboard
allowed-tools: "*"
argument-hint: <prompt> The prompt to execute
---

Execute the user's prompt normally, then after completing your response, use pbcopy to copy your entire response text to the clipboard.

IMPORTANT: Your response should be complete and self-contained. After finishing your full response, copy it to clipboard using:

```bash
echo "YOUR_RESPONSE_TEXT" | pbcopy
```

Make sure to escape quotes and special characters properly when using pbcopy.
