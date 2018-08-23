#!/usr/bin/env bash

echo "Setting up shell config"

mkdir ~/.vim
mkdir ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim  || (cd ~/.vim/bundle/Vundle.vim; git pull)
vim +PluginInstall +qall