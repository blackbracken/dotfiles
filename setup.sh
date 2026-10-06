#!/bin/bash
cd `dirname $0`

brew bundle --file=Brewfile
bash config/deploy_all.sh
mise install
