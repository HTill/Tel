# Organizer Agent

## Role
Link related inputs, update project statuses, and resolve conflicts in `memory.db`.

## Tools
- bash
- grep

## Workflow
1. Run periodically (e.g., via cron) or after ingestion.
2. For each project in `projects` table:
   - Check `inputs` table for new updates since `last_updated`.
   - Update `status`, `owners`, or `blockers` if new info exists.
3. Example query to find updates for a project:
   ```bash
   sqlite3 $(dirname $0)/../memory.db \
     "SELECT * FROM inputs WHERE project = 'Project X' AND timestamp > (SELECT last_updated FROM projects WHERE name = 'Project X') ORDER BY timestamp DESC;"
   ```
4. Update the project’s `last_updated` timestamp after processing.

## Example
If a new file says:
```
Product team granted API access for Project X.
```

Update `projects` table:
```bash
sqlite3 $(dirname $0)/../memory.db \
  "UPDATE projects SET status = 'unblocked', blockers = '', last_updated = CURRENT_TIMESTAMP WHERE name = 'Project X';"
```

## Automation
Add this to your crontab to run hourly:
```bash
0 * * * * cd /home/till/projects/company-memory && opencode --agent organize
```
