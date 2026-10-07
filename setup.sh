#!/bin/bash
cd `dirname $0`

link() {
  mkdir -p "$(dirname "$2")"
  ln -sf "$PWD/$1" "$2"
}

brew bundle --file=Brewfile

link config/mise/config.toml ~/.config/mise/config.toml
mise install

link config/neovim ~/.config/nvim

link config/starship/starship.toml ~/.config/starship.toml

link config/wezterm/.wezterm.lua ~/.wezterm.lua

cp config/git/.gitconfig ~/.gitconfig

link config/claude/CLAUDE.md ~/.claude/CLAUDE.md
link config/claude/statusline.sh ~/.claude/statusline.sh
settings=~/.claude/settings.json
[ -f "$settings" ] || echo '{}' > "$settings"
jq -s '.[0] * .[1]' "$settings" config/claude/settings.json > "$settings.tmp" && mv "$settings.tmp" "$settings"

mkdir -p ~/Library/Application\ Support/Rectangle
cp config/rectangle/RectangleConfig.json ~/Library/Application\ Support/Rectangle/RectangleConfig.json

line="source $PWD/config/zsh/common.zsh"
grep -qF "config/zsh/common.zsh" ~/.zshrc 2>/dev/null || echo "$line" >> ~/.zshrc
