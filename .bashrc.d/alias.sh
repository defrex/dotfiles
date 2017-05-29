
function mk(){ mkdir -p `dirname $1` && touch $1; }
function mksb(){ mk $1; subl3 $1; }
function pcat(){ pygmentize "$@" 2>/dev/null | cat --number || cat --number "$@"; }

function dc-rspec(){
    app=$1
    shift
    docker-compose run $app bundle exec rspec $*
}

function dc-rake(){
    app=$1
    shift
    docker-compose run $app bundle exec rake $*
}

function dc-rails(){
    app=$1
    shift
    docker-compose run $app bundle exec rails $*
}

function dc-npm(){
    app=$1
    shift
    docker-compose run $app npm $*
}

function dc-logs(){
    app=$1
    shift
    docker-compose logs $app -f --tail=100 $*
}

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
alias dc-run='docker-compose run'

command -v ack-grep >/dev/null 2>&1 && alias ack='ack-grep'
