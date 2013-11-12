#!/bin/bash

fn_bash=~/.bashrc
fn_input=~/.inputrc

if [ -f $fn_bash ]; then
    bakfn=${fn_bash}.bak
    mv $fn_bash $bakfn
fi

if [ -f $fn_input ]; then
    bakfn=${fn_input}.bak
    mv $fn_input $bakfn
fi

cp `dirname $0`/bashrc $fn_bash
cp `dirname $0`/inputrc $fn_input

