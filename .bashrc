
# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

shopt -s checkwinsize

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export BROWSER=/usr/bin/google-chrome-stable
export CHROME_BIN=$BROWSER
export TERMINAL=gnome-terminal
export PYTHONSTARTUP="$HOME/.python_startup.py"
export EDITOR='vim'

# The following will figure out what directory this file is in, resolving syms
CUR_SOURCE="${BASH_SOURCE[0]}"
while [ -h "$CUR_SOURCE" ]; do
  CUR_DIR="$( cd -P "$( dirname "$CUR_SOURCE" )" && pwd )"
  CUR_SOURCE="$(readlink "$CUR_SOURCE")"
  [[ $CUR_SOURCE != /* ]] && CUR_SOURCE="$CUR_DIR/$CUR_SOURCE"
done
CUR_DIR="$( cd -P "$( dirname "$CUR_SOURCE" )" && pwd )"

export PATH=$HOME/bin:$CUR_DIR/bin:"${PATH}"

alias ssh-raw='ssh'
# alias ssh='sshrc'

for rc in ~/.bashrc.d/* ; do
    source "$rc"
done

export NVM_DIR="/home/defrex/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
