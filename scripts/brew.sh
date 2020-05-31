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
brew update git

echo "Installind CLI software"
brew install exiftool

echo "Installing desktop software"
brew cask install chrome
brew cask install homebrew/cask-versions/firefox-developer-edition
brew cask install github
brew cask install flycut
brew cask install rectangle
brew cask install slack
brew cask install licecap
brew cask install rescuetime

brew install zsh zsh-completions
brew install diff-so-fancy
brew cask install font-fira-code

# Optional software
# brew cask install gimp
# brew cask install skitch
# brew cask install virtualbox
# brew install webp
# brew cask install vnc-viewer

# Remove outdated versions from the cellar.
brew cleanup
