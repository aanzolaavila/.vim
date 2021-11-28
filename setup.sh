#!/bin/bash

mkdir -p swp
mkdir -p undodir
mkdir -p plugins
mkdir -p autoload

ln -s ~/.vim/ideavimrc ~/.ideavimrc

# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O autoload/plug.vim

# nvim +PluginInstall +qall
