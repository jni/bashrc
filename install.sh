#!/bin/bash

fn_bash=~/.bashrc

if [ -f $fn_bash ]; then
    bakfn=${fn_bash}.bak
    mv $fn_bash $bakfn
fi

cp `dirname $0`/bashrc $fn_bash

