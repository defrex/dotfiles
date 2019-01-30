
function mk(){ mkdir -p `dirname $1` && touch $1; }
function mksb(){ mk $1; subl3 $1; }
function pcat(){ pygmentize "$@" 2>/dev/null | cat --number || cat --number "$@"; }

#alias ls='ls --color --human-readable'
alias gst='git status'
alias gca='git commit -av'
alias gpr='git pull --rebase'
#alias rake='bundle exec rake'
alias rails='bundle exec rails'
#alias cap='bundle exec cap'
#alias spring='bundle exec spring'
alias rspec='bundle exec rspec'
alias git-trim='git checkout master && git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d'
alias fwd='echo "
rdr pass inet proto tcp from any to any port 443 -> 127.0.0.1 port 8080
" | sudo pfctl -ef -'
