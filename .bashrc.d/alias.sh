
function mk(){ mkdir -p `dirname $1` && touch $1; }
function mksb(){ mk $1 && subl $1; }
function pcat (){ pygmentize "$@" 2>/dev/null || cat "$@"; }

alias ls='ls --color --human-readable'
alias gst='git status'
alias gca='git commit -av'
alias gpr='git pull --rebase'
alias open='xdg-open'
alias aura='sudo aura'
alias subl='subl3'
alias rake='bundle exec rake'
alias rails='bundle exec rails'
alias cap='bundle exec cap'
alias spring='bundle exec spring'
alias rspec='bundle exec rspec'
alias git-trim='git checkout master && git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d'

command -v ack-grep >/dev/null 2>&1 && alias ack='ack-grep'
