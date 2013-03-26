
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

BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
PURPLE="\e[0;35m"
CYAN="\e[0;36m"
GRAY="\e[0;37m"
OFF="\e[m"

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

function user_color {
    if [ "`whoami`" == "root" ]; then echo $RED; else echo $CYAN; fi
}

function prompt() {
    # A full width line of ═s
    line="`printf -vch "%${COLUMNS}s" ""; printf "%s" "${ch// /═}"`"

    prompt_left="$(user_color)╔══${OFF} `whoami` ${BLUE}$(virtualenv)${OFF}`pwd`${YELLOW}$(git_branch)$(git_changes)${OFF} "
    prompt_right="${GRAY}`date +"%I:%M:%S"`${OFF}"
    # used to subtract from length in expander
    prompt_colour="$(user_color)${OFF}${BLUE}${OFF}${YELLOW}${OFF}${GRAY}${OFF}"
    prompt_expender="$(user_color)${line:$((${#prompt_left}-${#prompt_colour}+${#prompt_right}+2))}╡${OFF}"
    prompt_line2="$(user_color)╚╡${OFF}"

    PS1=$(printf "%s%s%s\n%s" \
        "$prompt_left" \
        "$prompt_expender" \
        "$prompt_right" \
        "$prompt_line2")
}

PROMPT_COMMAND=prompt


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

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
alias s='workon shopcaster'

# arrows search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

eval `ssh-agent` > /dev/null 2>&1
ssh-add > /dev/null 2>&1

source /usr/bin/virtualenvwrapper.sh

export BROWSER=/usr/bin/google-chrome
export TERM=xterm

export PATH=$HOME/.gem/ruby/1.9.1/bin:$HOME/bin:"${PATH}"
