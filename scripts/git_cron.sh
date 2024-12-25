#!/bin/bash

# Navigate to the repository directories and push changes
cd ~/dotfiles && git add . && git commit -m "Automated nightly commit" && git push
cd ~/notes && git add . && git commit -m "Automated nightly commit" && git push

# Brew update
brew upgrade
