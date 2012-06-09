# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="defrex"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github npm command-not-found)

source $ZSH/oh-my-zsh.sh

eval `ssh-agent`
ssh-add

source virtualenvwrapper.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH=/home/defrex/bin:/home/defrex/lib/phantomjs-1.1.0/bin:/opt/amazon/ses/bin/:/var/lib/gems/1.8/bin/:/home/defrex/lib/phonegap-android/bin:/home/defrex/lib/android-sdk/tools:/home/defrex/lib/android-sdk/platform-tools:"${PATH}"

alias android-disconnect="fusermount -u /media/NexusS"
alias android-connect="mtpfs -o allow_other /media/NexusS"
alias ack=ack-grep

export TERM=rxvt-unicode-256color # for a colorful rxvt unicode session

eval `dircolors ~/.dir_colors`

