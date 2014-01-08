# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="defrex"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github npm)

export PAGER=most

source $ZSH/oh-my-zsh.sh

bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[Oc" forward-word
bindkey "^[Od" backward-word

eval `ssh-agent` > /dev/null 2>&1
ssh-add > /dev/null 2>&1

alias pcat=pygmentize

source /usr/bin/virtualenvwrapper.sh

function pless() {
    pcat "$1" | less -R
}

export BROWSER=/usr/bin/google-chrome

# Customize to your needs...
#export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH=$HOME/.gem/ruby/1.9.1/bin:$HOME/bin:"${PATH}"

#export TERM=rxvt-unicode-256color # for a colorful rxvt unicode session
export TERM=xterm

eval `dircolors ~/.dir_colors`
