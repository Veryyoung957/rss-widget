#!/bin/bash
# Install or update the RSS Reader plasmoid
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if plasmapkg2 -u "$SCRIPT_DIR" 2>/dev/null; then
    echo "==> Updated RSS Reader widget"
else
    plasmapkg2 -i "$SCRIPT_DIR"
    echo "==> Installed RSS Reader widget"
fi

echo "==> Done! Right-click desktop -> Add Widget -> search 'RSS Reader'"
echo ""
echo "To remove: plasmapkg2 -r $SCRIPT_DIR"
echo "To update: ./install.sh"
