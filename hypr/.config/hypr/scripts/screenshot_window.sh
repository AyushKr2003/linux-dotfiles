#!/bin/bash
# .config/hypr/scripts/screenshot_window.sh
# Screenshot a window Ctrl+Print

# Create a filename with a timestamp to ensure uniqueness
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
filename="$HOME/Pictures/screenshot_$timestamp.png"

# Capture the screenshot and save it to the generated filename
grim -g "$(hyprctl -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)" "$filename"

# Open the screenshot in swappy for editing
swappy -f "$filename"


