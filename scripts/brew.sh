#!/usr/bin/env bash

# Install xcode
# sudo xcode-select --install

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
brew cask install slack
brew cask install licecap
brew cask install krisp

brew install zsh zsh-completions
brew tap caskroom/fonts
brew cask install font-fira-code

# Optional software
# brew cask install gimp
# brew cask install skitch
# brew cask install virtualbox

# Remove outdated versions from the cellar.
brew cleanup