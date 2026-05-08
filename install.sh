#!/bin/bash
# Install the RSS Reader plasmoid
set -e

echo "==> Installing RSS Reader widget..."
plasmapkg2 -i .

echo "==> Done! Right-click desktop -> Add Widget -> search 'RSS Reader'"
echo ""
echo "To remove: plasmapkg2 -r org.kde.plasma.rssreader"
echo "To update: ./install.sh"
