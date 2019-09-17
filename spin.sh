#!/bin/bash -eu
cd `dirname $0`

readonly GEAR_ROOT="$HOME/.gear"

if [ "`whoami`" == "root" ]; then
  echo "Gear must be spun without the privilege."
  exit 1
fi

rm -rf $GEAR_ROOT
git clone https://github.com/blackbracken/gear.git $GEAR_ROOT

for dotfile in $(ls -A $GEAR_ROOT/dotfiles); do
  rm -f $HOME/$dotfile
  ln -sf $GEAR_ROOT/dotfiles/$dotfile $HOME
done

sh ./packages/install.sh

base64 -d > $HOME/Pictures/wallpaper.jpg < $GEAR_ROOT/resources/wallpaper.b64
gsettings set org.gnome.desktop.background picture-uri $HOME/Pictures/wallpaper.jpg

gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
