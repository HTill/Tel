#!/bin/bash

# Watcher Script for Company Memory
# Watches the ingestion/ folder for new files and triggers OpenCode to process them.

INGESTION_DIR="$(dirname "$0")/../ingestion"
OPENCODE_CMD="opencode --agent ingest --input"

# Ensure inotifywait is installed
if ! command -v inotifywait &> /dev/null; then
  echo "Error: inotify-tools is not installed. Install it with:"
  echo "  sudo apt-get install -y inotify-tools"
  exit 1
fi

# Create ingestion and archive directories if they don't exist
mkdir -p "$INGESTION_DIR"
mkdir -p "$(dirname "$0")/../archive"

echo "Watching $INGESTION_DIR for new files..."
echo "Press Ctrl+C to stop."

inotifywait -m -e create -e moved_to --format "%f" "$INGESTION_DIR" | while read FILE
do
  FILE_PATH="$INGESTION_DIR/$FILE"
  echo "[$(date)] New file detected: $FILE_PATH"

  # Use OpenCode to process the file
  $OPENCODE_CMD "$FILE_PATH"

done
