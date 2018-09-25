#!/usr/bin/env bash

echo 'Configuring macOS...'

# Show all files in finder
defaults write com.apple.finder AppleShowAllFiles YES
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Adjust date format
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM h:mm a"
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################
echo 'Restarting apps...'

for app in "Dock" \
	"Finder" \
    "SystemUIServer" \
	"Safari"
	"Terminal"; do
	killall "${app}" &> /dev/null
done
# kill -9 $(pgrep Electron) # VS Code
echo "Done. Note that some of these changes require a logout/restart to take effect."