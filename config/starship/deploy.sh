#!/bin/bash
cd `dirname $0`

mkdir -p $HOME/.config
ln -sf `pwd`/starship.toml $HOME/.config/starship.toml
