
function mk(){ mkdir -p `dirname $1` && touch $1; }
# function mksb(){ mk $1; subl3 $1; }
function pcat(){ pygmentize "$@" 2>/dev/null | cat --number || cat --number "$@"; }

# -G means "colorize" on BSD/macOS ls but "hide the group column" on GNU ls,
# so pick the flag that actually colorizes on this platform.
if ls --color=auto . >/dev/null 2>&1; then
    alias ls='ls --color=auto -ha'  # GNU coreutils (Linux)
else
    alias ls='ls -Gha'              # BSD (macOS)
fi
alias gst='git status'
alias gca='git commit -av'
alias gpr='git pull --rebase'
# alias open='xdg-open'
# alias subl='subl3'
# alias git-trim='git checkout master && git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d'
alias lst='tree -CshDftia --dirsfirst --filelimit 100 -I .next\|.git\|__pycache__\|node_modules '

# Default Claude Code to "danger mode" (no permission prompts), and name the
# session after the directory it was started in. Without the prefix every chat
# in the remote/Claude.ai session list is `<hostname>-<random-words>`, i.e.
# `membox-clever-otter` for all of them; with it you get `sysadmin-clever-otter`
# and can tell at a glance which project a chat belongs to. Claude slugifies the
# prefix (lowercase, non-alphanumerics -> `-`) and still appends its own random
# words, so the pseudo-random half is unchanged.
# ${PWD##*/} is expanded when the alias RUNS, not when it is defined, so it
# tracks whatever directory you launch from. At `/` it is empty, and Claude
# falls back to the hostname.
# Alias expansion isn't recursive in zsh/bash, so this doesn't loop.
# Use `command claude` to get the un-flagged binary.
alias claude='claude --dangerously-skip-permissions --remote-control-session-name-prefix "${PWD##*/}"'
