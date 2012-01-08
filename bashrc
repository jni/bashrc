# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTIGNORE="&:ls:[bf]g:exit"
export HISTSIZE=10000
export HISTCONTROL=ignoredups
export SVN_REPO=https://zhousvn.cmb.usc.edu/svn
export SVN_EDITOR=vim

# Matlab compiler variables
# use the latest version of Matlab, if available, otherwise the default
matlabroot=/usr/local/matlab-2010a
# matlabroot=/usr/local/matlab
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$matlabroot/runtime/glnxa64:$matlabroot/bin/glnxa64:$matlabroot/sys/os/glnxa64:$matlabroot/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:$matlabroot/sys/java/jre/glnxa64/jre/lib/amd64/server:$matlabroot/sys/java/jre/glnxa64/jre/lib/amd64"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/groups/chklovskii/home/nuneziglesiasj/Projects/em_denoising/extsrc/SPAMS/libs_ext/mkl64"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/groups/chklovskii/home/nuneziglesiasj/Projects/em_denoising/extsrc/SPAMS/libs_ext/mkl64"
export MCR_INHIBIT_CTF_LOCK=1
export PATH=$PATH:/usr/local/matlab-2010a/bin:/usr/local/matlab/bin:/opt/local/matlab/bin

# OpenCV support in the cluster
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/OpenCV/lib"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/OpenCV/lib/pkgconfig"

# EM reconstruction pipeline setup
export EMROOT="$HOME/Projects/em_recon"
export EM_CODE_DIR=$EMROOT/code
export EM_BIN_DIR=$EMROOT/bin
export EMBIN=$EM_BIN_DIR
export PYTHONPATH=$PYTHONPATH:$EM_CODE_DIR/lib
export PATH=${PATH}:$EM_BIN_DIR

export PATH=${PATH}:/groups/chklovskii/home/nuneziglesiasj/bin

# Setting prompt
parse_git_branch() {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1='\n\[\e[32;1m\]\u\[\e[0m\]\[\e[32m\]@\[\e[36m\]\h\[\e[33m\] \d \A \n\[\e[36m\] \w \[\e[33m\]$(parse_git_branch)\$\[\e[0m\] '
# export PS1='\n\u@\h \d \A \n \w \$ '

# git autocomplete
source /Volumes/Projects/git-completion/git-completion.bash

export LSCOLORS=gxfxcxdxbxegedabagacad

export KMP_DUPLICATE_LIB_OK=true

export GITDIR=/groups/flyem/proj/code/git-repos/
export VTK_DIR=/usr/lib64/vtk-5.4/

# Vigra LD Library path
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#    ;;
#*)
#    ;;
#esac

# export PS1="\u@\h,\w\$ "

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

alias cluster='ssh -Y nuneziglesiasj@login2.int.janelia.org'
alias hpc='ssh -Y nunezigl@hpc-cmb.usc.edu'
alias gcv='g++ `pkg-config --cflags opencv` `pkg-config --libs opencv`'
alias mvim='open -a MacVim'

# some more ls aliases
alias ls='ls -G'
alias ll='ls -lG'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
