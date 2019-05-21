
function mk(){ mkdir -p `dirname $1` && touch $1; }
function mksb(){ mk $1; subl3 $1; }
function pcat(){ pygmentize "$@" 2>/dev/null | cat --number || cat --number "$@"; }

alias ls='ls --color --human-readable'
alias gst='git status'
alias gca='git commit -av'
alias gpr='git pull --rebase'
alias open='xdg-open'
alias subl='subl3'
alias git-trim='git checkout master && git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d'
alias lst='tree -CshDftia --dirsfirst --filelimit 100 -I .next\|.git\|__pycache__\|node_modules '
