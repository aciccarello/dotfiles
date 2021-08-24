#!/usr/bin/env bash

echo "Setting up shell config"
vim +PluginInstall +qall

OMZ_DIR="$HOME/.oh-my-zsh"
if [ -d "$OMZ_DIR" ]; then
    echo "$OMZ_DIR directory already exists on your filesystem."
else
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
