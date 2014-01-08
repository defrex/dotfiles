
# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

# Prompt!

BLACK="\[\e[0;30m\]"
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"
GRAY="\[\e[0;37m\]"
OFF="\[\e[m\]"

function git_changes {
    changes="`git status --porcelain 2> /dev/null | wc -l`"
    [ $changes -ne 0 ] && echo -n "!$changes"
}

function git_branch {
    branch="`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`"
    [ "${#branch}" -ne 0 ] && echo -n ":"$branch
}

function virtualenv {
    local e=`basename $VIRTUAL_ENV 2>/dev/null`
    [ ! -z "$e" ] && echo -n "env:$e "
}

# Node.js env
function nenv {
    local e=`basename $NODE_ENV_NAME 2>/dev/null`
    [ ! -z "$e" ] && echo -n "nenv:$e "
}

function directory {
    current="`pwd`"
    echo -n "${current/$HOME/~}"
}

function user_color {
    if [ "`whoami`" == "root" ]; then echo -n $RED; else echo -n $CYAN; fi
}

function extender_line {
    line="`printf -vch "%$($1)s" ""; printf "%s" "${ch// /═}"`"
}

function get_extender_length() {
    prompts="$@"
    colour_used="$(user_color)${OFF}${BLUE}${OFF}${YELLOW}${OFF}${GRAY}${OFF}"
    prompt_length="$((${#prompts}))"
    printable_length="$((${prompt_length} - ${#colour_used}))"
    echo -n "$((${COLUMNS} - ${printable_length} - 1))" # I don't know where the 1 comes from -_-
}
function prompt() {
    # History Mutherfucker!
    history -a; history -c; history -r;

    dir=$(directory)
    prompt_right="${GRAY}`date +"%I:%M:%S"`${OFF}"
    prompt_left="$(user_color)╔══${OFF} `whoami` ${BLUE}$(nenv)$(virtualenv)${OFF}$dir${YELLOW}$(git_branch)$(git_changes)${OFF} "

    extender_length=`get_extender_length $prompt_left $prompt_right`
    if [ "$extender_length" -lt -9 ]; then
        # Put an elipsis in the dir name, eg. ~/one/two/three/four -> ~/one/.../four

        first_dir=`echo $dir | cut -d '/' -f 1`
        [ "$first_dir" == "~" ] && first_dir=\~/`echo $dir | cut -d '/' -f 2`

        last_dir=`echo $dir | tr '/' '\n' | tail -n 1`
        replaces_dir="$first_dir/.../$last_dir"

        prompt_left=${prompt_left//$dir/$replaces_dir}
        extender_length=`get_extender_length $prompt_left $prompt_right`
    fi

    if [ "$extender_length" -lt 0 ]; then
        extender_length="0"
        prompt_right=""
    fi
    prompt_extender="$(user_color)`printf -vch "%${extender_length}s" ""; printf "%s" "${ch// /═}"`╡${OFF}"

    prompt_line2="$(user_color)╚╡${OFF}"

    PS1=$(printf "%s%s%s\n%s" \
        "$prompt_left" \
        "$prompt_extender" \
        "$prompt_right" \
        "$prompt_line2")
}

PROMPT_COMMAND=prompt

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize


export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# arrows search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
set show-all-if-ambiguous on
set completion-ignore-case on


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

node_workon (){
    PROJECT_DIR=$1
    cd $PROJECT_DIR
    export PATH="$PROJECT_DIR/node_modules/.bin:${PATH}"
    export NODE_ENV_HOME=$PROJECT_DIR
    export NODE_ENV_NAME=$2
}

wres (){
    node_workon ~/code/resume res
    cd ~/code/resume
}


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto --human-readable'
    alias grep='grep --color=auto'
fi

alias pcat='pygmentize'
alias gst='git status'
alias gca='git commit -av'
alias gpr='git pull --rebase'
alias open='xdg-open'
alias packer='packer --noedit'
alias s='workon shopcaster'

eval `ssh-agent` > /dev/null 2>&1
ssh-add > /dev/null 2>&1

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

export BROWSER=/usr/bin/chromium
export CHROME_BIN=$BROWSER
export TERMINAL=terminator

LOCAL=$HOME/bin
RUBY_19=$HOME/.gem/ruby/1.9.1/bin
RUBY_20=$HOME/.gem/ruby/2.0.0/bin
export PATH=$LOCAL:$RUBY_19:$RUBY_20:"${PATH}"
