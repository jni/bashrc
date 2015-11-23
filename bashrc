# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history, or simple ls commands.
# See bash(1) for more options

export HISTIGNORE="&:ls:[bf]g:exit"
export HISTCONTROL=ignoredups
# keep 10,000 lines of history, instead of the usual 1,000
export HISTSIZE=10000

### Setting path ###

# Use home bin dir for some small utilities
export PATH=$PATH:~/bin

# Use virtualenv and virtualenvwrapper if available
if [ `command -v virtualenvwrapper.sh` ]; then
    export WORKON_HOME=$HOME/venv
    export PROJECT_HOME=$HOME/projects
    source `which virtualenvwrapper.sh`
fi

# If the Anaconda Python distribution is installed, use it
if [ -d ~/anaconda ]; then
    export PATH="${HOME}/anaconda/bin:$PATH"
fi

### Setting prompt ###

# In git repositories, add the current branch to the prompt
parse_git_branch() {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# pretty string that includes a timestamp and two-line prompt
export PS1='\n\[\e[32;1m\]\u\[\e[0m\]\[\e[32m\]@\[\e[36m\]\h\[\e[33m\] \d \A \n\[\e[36m\] \w \[\e[33m\]$(parse_git_branch)\$\[\e[0m\] '

# git autocomplete
git_completion=~/projects/git-completion/git-completion.bash
if [ -f $git_completion ]; then
    source $git_completion
elif [ -d $HOME/Projects.sparsebundle ]; then
    open $HOME/Projects.sparsebundle
    sleep 1
    source $git_completion
fi

# git function: sprout
function sprout {
    git checkout -b "$1" origin/master
}

export LSCOLORS=gxfxcxdxbxegedabagacad

### Alias definitions ###

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

alias mvim='open -a MacVim'

# some more ls aliases
alias ls='ls -hG'
alias ll='ls -lhG'
alias la='ls -hA'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# enable searching through history with already-typed string (Matlab style)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

### ssh-agent setup code from github. ###
# See http://help.github.com/ssh-key-passphrases/

SH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
    test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    else
        start_agent
    fi
fi


# Add directory marking and jumping commands from
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
# also noted in Evernote
export MARKPATH=$HOME/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}


export RSTUDIO_WHICH_R=/Users/nuneziglesiasj/anaconda/envs/R/bin/R
