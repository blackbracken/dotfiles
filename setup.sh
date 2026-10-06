#!/bin/bash
cd `dirname $0`

link() {
  mkdir -p "$(dirname "$2")"
  ln -sf "$PWD/$1" "$2"
}

brew bundle --file=Brewfile

link config/mise/config.toml ~/.config/mise/config.toml
mise install

link config/neovim/init.vim ~/.config/nvim/init.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

link config/starship/starship.toml ~/.config/starship.toml

link config/wezterm/.wezterm.lua ~/.wezterm.lua

cp config/git/.gitconfig ~/.gitconfig

line="source $PWD/config/zsh/common.zsh"
grep -qF "config/zsh/common.zsh" ~/.zshrc 2>/dev/null || echo "$line" >> ~/.zshrc
