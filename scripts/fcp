#!/bin/bash
# filename: fcp
# Description: Navigate and copy file path to clipboard using fzf

if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed. Install it with 'brew install fzf'"
    exit 1
fi

if ! command -v pbcopy >/dev/null 2>&1; then
    echo "Error: pbcopy is not available on this system"
    exit 1
fi

# Use the global fzf-preview script
selected_file=$(find . -type f -not -path '*/\.*' 2>/dev/null | fzf)

# Clear any remaining image after fzf exits
kitten icat --clear

if [ -n "$selected_file" ]; then
    # Get absolute path
    absolute_path=$(realpath "$selected_file")
    echo "$absolute_path" | pbcopy
    echo "Path '$absolute_path' copied to clipboard"
else
    echo "No file selected"
    exit 1
fi
