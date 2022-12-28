#!/bin/bash

rm -rf $HOME/.config/nvim
rm -rf $HOME/.local/share/nvim
rm -rf $HOME/.cache/nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
cp ./nvim $HOME/.config/nvim -r
sudo add-apt-repository ppa:neovim-ppa/unstable
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\
sudo apt-get install -y nodejs neovim fd-find ripgrep
sudo snap install universal-ctags
