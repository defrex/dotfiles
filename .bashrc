
# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

function mk(){ mkdir -p `dirname $1` && touch $1; }
function pcat (){ pygmentize "$@" 2>/dev/null || cat "$@"; }

alias gst='git status'
alias gca='git commit -av'
alias gpr='git pull --rebase'
alias open='xdg-open'
alias packer='packer --noedit'
alias subl='subl3'

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

if [ -f ~/.dir_colors ]; then
    eval `dircolors ~/.dir_colors`

    alias ls='ls --color=auto --human-readable'
    alias grep='grep --color=auto'
fi

export BROWSER=/usr/bin/google-chrome-stable
export CHROME_BIN=$BROWSER
export TERMINAL=terminator
export PYTHONSTARTUP="$HOME/.python_startup.py"

LOCAL=$HOME/bin
export PATH=$LOCAL:"${PATH}"

for rc in ~/.bashrc.d/* ; do
    source "$rc"
done
