#!/usr/bin/env bash

echo 'Configuring macOS...'

# Show all files in finder
defaults write com.apple.finder AppleShowAllFiles YES
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Adjust date format
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM h:mm a"

# Restarting apps:
echo 'Restarting apps...'
killall Finder Dock



###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Dock" \
	"Finder" \
    "SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."