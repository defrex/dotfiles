
# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Prompt!

function git_changes {
    changes="`git status --porcelain 2> /dev/null | wc -l`"
    [ $changes -ne 0 ] && echo "!$changes"
}

function git_branch {
    branch="`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`"
    [ "${#branch}" -ne 0 ] && echo ":"$branch
}

function virtualenv {
    local e=`basename $VIRTUAL_ENV 2>/dev/null`
    [ ! -z "$e" ] && echo "env:$e "
}

function root {
    if [ "`whoami`" == "root" ]; then
        echo "╔══root"
    fi
}
function root_bottom {
    if [ "`whoami`" == "root" ]; then
        echo "╚╡"
    fi
}
function user {
    if [ "`whoami`" != "root" ]; then
        echo "╔══`whoami`"
    fi
}
function user_bottom {
    if [ "`whoami`" != "root" ]; then
        echo "╚╡"
    fi
}

RED="\e[0;31m"
GREEN="\e[0;32m"
BLUE="\e[0;34m"
YELLOW="\e[0;33m"
OFF="\e[m"

PS1="${RED}\$(root)${OFF}\$(user) ${BLUE}\$(virtualenv)${OFF}\w${YELLOW}\$(git_branch)\$(git_changes)${OFF}
${RED}\$(root_bottom)${OFF}$(user_bottom)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto --human-readable'
    alias grep='grep --color=auto -n'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias pcat='pygmentize'
alias gst='git status'
alias gca='git commit -av'
alias gpr='git pull --rebase'

# arrows search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

eval `ssh-agent` > /dev/null 2>&1
ssh-add > /dev/null 2>&1

source /usr/bin/virtualenvwrapper.sh

export BROWSER=/usr/bin/google-chrome
export TERM=xterm

export PATH=$HOME/.gem/ruby/1.9.1/bin:$HOME/bin:"${PATH}"
