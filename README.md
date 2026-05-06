# Company Memory

A lightweight agent-based system to ingest, organize, and query company communications. Groups can drop files (emails, docs, notes) into an ingestion folder, and agents process them into a structured memory system.

## Features
- **Ingestion**: Drop files into `ingestion/` to automatically extract structured data.
- **Organization**: Agents link related items and update project statuses.
- **Querying**: Ask questions like "What’s blocking Project X?" to get summaries.

## Setup
1. Clone the repo:
   ```bash
   git clone /home/till/projects/company-memory
   cd company-memory
   ```
2. Initialize the database:
   ```bash
   sqlite3 memory.db < schema.sql
   ```
3. Start the watcher:
   ```bash
   ./scripts/watcher.sh
   ```

## Usage
- **Drop files** into `ingestion/` (e.g., emails, Slack exports, meeting notes).
- **Query the system** with OpenCode:
  ```bash
  opencode --agent query "What’s blocking Project X?"
  ```

## Structure
- `ingestion/`: Drop files here for processing.
- `memory.db`: SQLite database for structured data.
- `agents/`: OpenCode agent configurations.
- `scripts/`: Helper scripts (e.g., watcher).
- `archive/`: Processed files are moved here.
