
# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

. ~/.bash_prompt

export WORKON_HOME="$HOME/.virtualenvs"

export NODE_ENV

function cd (){
    builtin cd $@

    cur_files="$(ls -la | awk '{print $9}')"

    if [[ $cur_files = *.venv* ]]; then
        source "$WORKON_HOME/$(cat .venv)/bin/activate"
        [ -f "$VIRTUAL_ENV/bin/postactivate" ] && source "$VIRTUAL_ENV/bin/postactivate"
    elif [ -n "$VIRTUAL_ENV" ]; then
        deactivate
        [ -f "$VIRTUAL_ENV/bin/postdeactivate" ] && source "$VIRTUAL_ENV/bin/postdeactivate"
    fi

    if [ -n "$NODE_ENV" ]; then
        IFS=:
        # convert PATH to an array
        path_array=($PATH)
        # remove old NODE_ENV
        old_bin="$NODE_ENV/node_modules/.bin"
        path_array=(${path_array[@]%%$old_bin})
        # output the new array
        PATH="${path_array[*]}"
        unset IFS

        export NODE_ENV=''
    fi

    if [[ $cur_files = *node_modules* ]]; then
        export NODE_ENV=`pwd`
        export PATH="$PATH:$NODE_ENV/node_modules/.bin"
    fi
}

function mk(){ mkdir -p `dirname $1` && touch $1; }

function jump(){ eval "$(~/code/jump/bin/jump.dart $@)"; }
alias jp='jump'

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto --human-readable'
    alias grep='grep --color=auto'
fi

# eval `ssh-agent` > /dev/null 2>&1
# ssh-add > /dev/null 2>&1

export BROWSER=/usr/bin/google-chrome-stable
export CHROME_BIN=$BROWSER
export TERMINAL=terminator
export PYTHONSTARTUP="$HOME/.python_startup.py"

LOCAL=$HOME/bin
RUBY_19=$HOME/.gem/ruby/1.9.1/bin
RUBY_20=$HOME/.gem/ruby/2.0.0/bin
export PATH=$LOCAL:$RUBY_19:$RUBY_20:"${PATH}"

