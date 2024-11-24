#!/bin/bash
# filename: fzf_preview for "fp" binary
# Description: Enhanced preview script for fzf with Kitty image/PDF support

# Check if we're running inside fzf
is_in_fzf() {
    [ -n "$TMUX" ] || [ -n "$FZF_PREVIEW_COLUMNS" ]
}

# Function to clear kitty image
# note the following github issue where someone found this workaround for not being able to run
# "kitten icat --clear" from within FZF:    https://github.com/junegunn/fzf/issues/3228
# this printf is what that kitten cmd runs under the hood
clear_kitty_image() {
    printf "\x1b_Ga=d,d=A\x1b\\"
}

# Function to preview files based on their type
preview_file() {
    local file="$1"
    local mime_type=$(file --mime-type -b "$file")
    local file_size=$(ls -lh "$file" | awk '{print $5}')
    
    # Clear any existing image first
    clear_kitty_image
    
    echo "File: $file"
    echo "Type: $mime_type"
    echo "Size: $file_size"
    echo "-------------------"
    
    case $mime_type in
        image/*)
            if is_in_fzf; then
                kitty +kitten icat --transfer-mode file --stdin no --place "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" "$file"
            else
                kitten icat "$file"
            fi
            ;;
        application/pdf)
            if is_in_fzf; then
                # Try pdftoppm first
                local tmp_dir=$(mktemp -d)
                if pdftoppm -png -f 1 -l 1 "$file" "$tmp_dir/preview" >/dev/null 2>&1 && [ -f "$tmp_dir/preview-1.png" ]; then
                    kitty +kitten icat --transfer-mode file --stdin no --place "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" "$tmp_dir/preview-1.png"
                    rm -rf "$tmp_dir"
                else
                    # Fall back to direct PDF preview if pdftoppm fails
                    rm -rf "$tmp_dir"
                    kitty +kitten icat --transfer-mode file --stdin no --place "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" "$file"
                fi
            else
                kitten icat "$file"
            fi
            ;;
        video/*)
            # Get video thumbnail using your vtp script and display with icat
            thumb_path=$(vtp "$file")
            if [ -f "$thumb_path" ]; then
                if is_in_fzf; then
                    kitty +kitten icat --transfer-mode file --stdin no --place "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" "$thumb_path"
                else
                    kitten icat "$thumb_path"
                fi
            else
                echo "[Video preview not available]"
            fi
            ;;
        text/*)
            # For text files, show content
            bat --color=always "$file" --line-range :200 2>/dev/null || cat "$file"
            ;;
        application/json)
            # Pretty print JSON
            jq -C '.' "$file" 2>/dev/null || cat "$file"
            ;;
        *)
            # For other files, try to use bat for syntax highlighting, fallback to head
            bat --color=always "$file" --line-range :200 2>/dev/null || head -n 200 "$file"
            ;;
    esac
}

# If script is called directly, preview the file passed as argument
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    preview_file "$1"
fi
