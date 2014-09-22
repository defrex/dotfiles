
if [ -f ~/.dir_colors ]; then
    eval `dircolors ~/.dir_colors`

    alias ls='ls --color=auto --human-readable'
    alias grep='grep --color=auto'
fi
