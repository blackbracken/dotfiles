#!/bin/bash
cd `dirname $0`

grep -qF "config/zsh/rc_util.sh" $HOME/.zshrc 2>/dev/null || echo "source `pwd`/rc_util.sh" >> $HOME/.zshrc
