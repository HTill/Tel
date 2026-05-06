-- Create tables for inputs and projects
CREATE TABLE IF NOT EXISTS inputs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  file_path TEXT UNIQUE,
  group_name TEXT,
  content TEXT,
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  entities TEXT,
  project TEXT,
  status TEXT
);

CREATE TABLE IF NOT EXISTS projects (
  name TEXT PRIMARY KEY,
  status TEXT,
  owners TEXT,
  blockers TEXT,
  last_updated DATETIME
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_inputs_project ON inputs(project);
CREATE INDEX IF NOT EXISTS idx_inputs_group ON inputs(group_name);
CREATE INDEX IF NOT EXISTS idx_inputs_timestamp ON inputs(timestamp);
