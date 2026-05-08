#!/bin/bash
# Install the RSS Reader plasmoid
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing RSS Reader widget..."
plasmapkg2 -i "$SCRIPT_DIR"

echo "==> Done! Right-click desktop → Add Widget → search 'RSS Reader'"
echo ""
echo "To remove: plasmapkg2 -r org.kde.plasma.rssreader"
echo "To update: plasmapkg2 -u $SCRIPT_DIR"
