#!/usr/bin/env bash

# Install command-line tools using Homebrew.

echo "Updating brew and already installed software"
# Make sure we’re using the latest Homebrew.
brew update
# Upgrade any already-installed formulae.
brew upgrade

echo "Installing more recent versions of macOS tools"
brew install vim --with-override-system-vi
brew install grep
brew install openssh

echo "Installing desktop software"
brew cask install github
brew cask install flycut
brew cask install spectacle

brew tap caskroom/fonts
brew cask install font-fira-code

# Remove outdated versions from the cellar.
brew cleanup