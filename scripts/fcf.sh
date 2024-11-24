#!/bin/bash
# filename: fcf
# Description: Navigate and copy file content to clipboard using fzf

if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed. Install it with 'brew install fzf'"
    exit 1
fi

# Use the global fzf-preview script
selected_file=$(find . -type f -not -path '*/\.*' 2>/dev/null | fzf)

# Clear any remaining image after fzf exits
kitten icat --clear

if [ -n "$selected_file" ]; then
    # Get absolute path
    absolute_path=$(realpath "$selected_file")
    
    # Use AppleScript to copy the file content to clipboard
    osascript <<EOF
        tell application "Finder"
            set sourceFile to POSIX file "$absolute_path"
            set the clipboard to contents of sourceFile
        end tell
EOF
  
    # Small delay to allow clipboard manager to detect the change
    sleep 0.4

    # Get file info for the message
    file_type=$(file --mime-type -b "$selected_file")
    file_size=$(ls -lh "$selected_file" | awk '{print $5}')
    uti=$(mdls -name kMDItemContentType -raw "$selected_file")
    
    echo "Copied contents of '$selected_file' to clipboard"
    echo "Type: $file_type"
    echo "UTI: $uti"
    echo "Size: $file_size"
else
    echo "No file selected"
    exit 1
fi
