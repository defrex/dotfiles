
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
export PATH=$HOME/bin:/usr/local/heroku/bin:"${PATH}"

alias ssh-raw='ssh'
# alias ssh='sshrc'

for rc in ~/.bashrc.d/* ; do
    source "$rc"
done

export NVM_DIR="/home/defrex/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
