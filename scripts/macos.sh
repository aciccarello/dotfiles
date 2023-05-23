#!/usr/bin/env bash

echo 'Configuring macOS...'

defaults write "Apple Global Domain" "AppleInterfaceStyle" "Dark"
# Show all files in finder
defaults write com.apple.finder AppleShowAllFiles true
# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true
# echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Disable the dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES
# Disable automatically rearranging spaces based on most recent use
defaults write com.apple.dock mru-spaces -boolean NO
# Adjust date format
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM h:mm a"
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Set a key repeat.
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 35
# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# "Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2
# See https://github.com/Microsoft/vscode/issues/51132#issuecomment-424299892
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
# See https://tonsky.me/blog/monitors/#turn-off-font-smoothing
defaults -currentHost write -g AppleFontSmoothing -int 0

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "Opening Firefox to set as default browser. Feel free to close or login"
/Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/firefox -setDefaultBrowser -preferences

echo "Done. Note that some of these changes require a logout/restart to take effect."
