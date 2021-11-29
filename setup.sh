#!/bin/bash

nvim -v || (echo "neovim not installed"; exit 1)
node -v || (echo "nodejs not installed"; exit 1)
pyenv --version || (echo "pyenv not installed"; exit 1)

# PyEnv

grep 'eval "$(pyenv init --path)"' ~/.zprofile || echo 'eval "$(pyenv init --path)"'  >> ~/.zprofile
grep 'eval "$(pyenv init -)"' ~/.zshrc || echo 'eval "$(pyenv init -)"'  >> ~/.zshrc

pyenv install 2.7.18
pyenv install 3.10.0

pyenv global 2.7.18 3.10.0

export PATH="$(pyenv init --path):$PATH"
eval "$(pyenv init -)"

pip install -U pip
pip install neovim

pip3 install -U pip
pip3 install neovim

# NodeJs
npm install -g neovim

# NeoVim
mkdir -p swp
mkdir -p undodir
mkdir -p plugins
mkdir -p autoload

rm -rf ~/.config/nvim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vim/ideavimrc ~/.ideavimrc

wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O autoload/plug.vim

nvim +PlugInstall +qall

#nvim +CocInstall coc-json
#nvim +CocInstall coc-go
