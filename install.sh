#!/bin/bash

if [ $# -eq 1 ]; then
    fn=$1
else fn=~/.bashrc
fi

if [ -f $fn ]; then
    bakfn = ${fn}.bak
    mv $fn $bakfn
fi

mv `dirname $0`/bashrc $fn
