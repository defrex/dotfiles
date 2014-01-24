
# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

. ~/.bash_prompt

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

export BROWSER=/usr/bin/chromium
export CHROME_BIN=$BROWSER
export TERMINAL=terminator

LOCAL=$HOME/bin
RUBY_19=$HOME/.gem/ruby/1.9.1/bin
RUBY_20=$HOME/.gem/ruby/2.0.0/bin
export PATH=$LOCAL:$RUBY_19:$RUBY_20:"${PATH}"

