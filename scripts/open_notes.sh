#!/bin/bash

# Notes automation script
# Save to ~/dotfiles/notes-automation.sh
# Make executable with: chmod +x ~/dotfiles/notes-automation.sh

# Check if Kitty is running
if ! pgrep -q "kitty"; then
    # If Kitty is not running, switch to Desktop 1 and open Kitty
    osascript -e 'tell application "System Events" to key code 18 using {control down, shift down, option down, command down}'
    open -a Kitty
    echo "Opening Kitty on Desktop 1..."
    # Wait for Kitty to fully open
    sleep 1
else
    # If Kitty is running, switch to Desktop 1 where Kitty should be
    osascript -e 'tell application "System Events" to key code 18 using {control down, shift down, option down, command down}'
    echo "Switching to Desktop 1 where Kitty is running..."
    # Ensure Kitty is frontmost
    osascript -e 'tell application "Kitty" to activate'
    sleep 0.5
fi


# Create a new tab with Command+T
osascript -e 'tell application "System Events" to keystroke "t" using command down'
sleep 0.5

# Send the kitten command to rename the tab via keystrokes
osascript -e 'tell application "System Events" to keystroke "kitten @ set-tab-title notes"'
osascript -e 'tell application "System Events" to keystroke return'
sleep 0.5

# Change to notes directory
osascript -e 'tell application "System Events" to keystroke "cd notes"'
osascript -e 'tell application "System Events" to keystroke return'
sleep 0.5

# Open Neovim with current directory
osascript -e 'tell application "System Events" to keystroke "nvim ."'
osascript -e 'tell application "System Events" to keystroke return'
sleep 1

# Send leader + no (space + no)
osascript -e 'tell application "System Events" to keystroke " "'
sleep 0.2
osascript -e 'tell application "System Events" to keystroke "no"'
