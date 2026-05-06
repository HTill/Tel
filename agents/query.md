# Query Agent

## Role
Answer questions about projects, blockers, or groups using `memory.db`.

## Tools
- bash
- grep

## Workflow
1. Parse the user's query (e.g., "What’s blocking Project X?").
2. Query `memory.db`:
   - For project-specific queries:
     ```bash
     sqlite3 $(dirname $0)/../memory.db \
       "SELECT * FROM projects WHERE name = '$PROJECT';"
     ```
   - For general searches:
     ```bash
     sqlite3 $(dirname $0)/../memory.db \
       "SELECT * FROM inputs WHERE content LIKE '%$KEYWORD%' ORDER BY timestamp DESC;"
     ```
3. Summarize results in plain English.

## Example Queries
| Query                          | SQL Query                                                                                     | Output                                                                                     |
|--------------------------------|-----------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| "What’s blocking Project X?"   | `SELECT blockers FROM projects WHERE name = 'Project X';`                                    | "Project X is blocked by API access (Engineering, 2026-05-06)."                           |
| "Who owns Project X?"          | `SELECT owners FROM projects WHERE name = 'Project X';`                                      | "Engineering and Product teams own Project X."                                              |
| "What’s the status of Project Y?" | `SELECT status FROM projects WHERE name = 'Project Y';`                                  | "Project Y is in progress (last updated: 2026-05-05)."                                      |
| "Show all blockers."           | `SELECT name, blockers FROM projects WHERE blockers != '';`                                | "1. Project X: API access\n2. Project Z: Budget approval"                                  |
| "What did Engineering say?"    | `SELECT content FROM inputs WHERE group_name = 'Engineering' ORDER BY timestamp DESC LIMIT 5;` | "Latest updates from Engineering:\n1. [2026-05-06] Blocked on API access...\n2. ..."       |

## Usage
```bash
opencode --agent query "What’s blocking Project X?"
```
