#!/bin/bash
set -e
cd `dirname $0`

link() {
  mkdir -p "$(dirname "$2")"
  ln -sfn "$PWD/$1" "$2"
}

step() {
  echo "==> $1"
}

brew bundle --file=Brewfile
step "brew bundle done"

link config/mise/config.toml ~/.config/mise/config.toml
mise install
step "mise done"

link config/neovim ~/.config/nvim
step "neovim done"

link config/starship/starship.toml ~/.config/starship.toml
step "starship done"

link config/wezterm/.wezterm.lua ~/.wezterm.lua
step "wezterm done"

cp config/git/.gitconfig ~/.gitconfig
step "git done"

link config/claude/CLAUDE.md ~/.claude/CLAUDE.md
link config/claude/statusline.sh ~/.claude/statusline.sh
settings=~/.claude/settings.json
[ -f "$settings" ] || echo '{}' > "$settings"
jq -s '.[0] * .[1]' "$settings" config/claude/settings.json > "$settings.tmp"
mv "$settings.tmp" "$settings"
step "claude done"

mkdir -p ~/Library/Application\ Support/Rectangle
cp config/rectangle/RectangleConfig.json ~/Library/Application\ Support/Rectangle/RectangleConfig.json
step "rectangle done"

line="source $PWD/config/zsh/common.zsh"
grep -qF "config/zsh/common.zsh" ~/.zshrc 2>/dev/null || echo "$line" >> ~/.zshrc
step "zsh done"
