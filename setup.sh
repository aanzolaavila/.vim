#!/bin/bash

mkdir -p swp
mkdir -p undodir
mkdir -p plugins

ln -s ~/.vim/ideavimrc ~/.ideavimrc

vim +PluginInstall +qall
