#!/bin/bash
# filename: fcm
# Description: Navigate and copy multiple file contents to clipboard using fzf

if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed. Install it with 'brew install fzf'"
    exit 1
fi

# Use the global fzf-preview script with multi-select enabled
selected_files=$(find . -type f -not -path '*/\.*' 2>/dev/null | fzf -m)

# Clear any remaining image after fzf exits
kitten icat --clear

if [ -n "$selected_files" ]; then
    # Count total files
    total_files=$(echo "$selected_files" | wc -l)
    current_file=1
    
    echo "Selected $total_files files:"
    
    # Process each file
    while IFS= read -r file; do
        # Get absolute path
        absolute_path=$(realpath "$file")
        
        # Copy file content using Finder
        osascript <<EOF
            tell application "Finder"
                set sourceFile to POSIX file "$absolute_path"
                set the clipboard to contents of sourceFile
            end tell
EOF
        
        # Small delay to allow clipboard manager to detect the change
        sleep 0.4
        
        # Get file info for the message
        file_type=$(file --mime-type -b "$file")
        file_size=$(ls -lh "$file" | awk '{print $5}')
        uti=$(mdls -name kMDItemContentType -raw "$file")
        
        echo "[$current_file/$total_files] Copied contents of '$file' to clipboard"
        echo "    Type: $file_type"
        echo "    UTI: $uti"
        echo "    Size: $file_size"
        
        ((current_file++))
    done <<< "$selected_files"
    
    echo "All selected files have been copied to clipboard"
else
    echo "No files selected"
    exit 1
fi
