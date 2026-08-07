#!/usr/bin/env bash

set -euo pipefail

echo "Setting up shell config"
if command -v vim >/dev/null 2>&1; then
    vim +PluginInstall +qall
else
    echo "vim not found; skipping PluginInstall step"
fi

OMZ_DIR="$HOME/.oh-my-zsh"
if [ -d "$OMZ_DIR" ]; then
    echo "$OMZ_DIR directory already exists on your filesystem."
else
    if ! command -v curl >/dev/null 2>&1; then
        echo "curl is required to install oh-my-zsh" >&2
        exit 2
    fi

    echo "Installing oh-my-zsh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
