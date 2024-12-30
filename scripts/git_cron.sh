#!/bin/bash

# Navigate to the repository directories and push changes
cd ~/dotfiles && git add . && git commit -m "Automated nightly commit" && git push
cd ~/notes && git add . && git commit -m "Automated nightly commit" && git push


# Source .bashrc to load PATH and other environment variables
# this is required for some commands to work because this script
# is run from a non-interactive shell
source ~/.bashrc

# Brew update
brew upgrade
