
function mk(){ mkdir -p `dirname $1` && touch $1; }
function pcat (){ pygmentize "$@" 2>/dev/null || cat "$@"; }

alias gst='git status'
alias gca='git commit -av'
alias gpr='git pull --rebase'
alias open='xdg-open'
alias packer='packer --noedit'
alias ack='ack-grep'
