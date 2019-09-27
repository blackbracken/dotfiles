#!/bin/bash -u
cd `dirname $0`

readonly GEAR_ROOT="$HOME/.gear"

curl -sL https://raw.githubusercontent.com/blackbracken/.gear/master/res/gear_art | cat

if [ "`whoami`" == "root" ]; then
  echo ".gear must be spun without the privilege."
  exit 1
elif [ -e $GEAR_ROOT ]; then
  echo ".gear has already been installed."
  exit 1
fi

sudo -v

rm -rf $GEAR_ROOT
git clone https://github.com/blackbracken/.gear.git $GEAR_ROOT

cd $HOME/.gear

make minimal
