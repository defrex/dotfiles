# Prompt!

setopt PROMPT_SUBST

# Foreground Colors
BLACK="%{%F{black}%}"
WHITE="%{%F{white}%}"
GRAY="%{%F{7}%}"
RED="%{%F{red}%}"
GREEN="%{%F{green}%}"
YELLOW="%{%F{yellow}%}"
BLUE="%{%F{blue}%}"
CYAN="%{%F{cyan}%}"
MAGENTA="%{%F{magenta}%}"

# Background Colors
BG_BLACK="%{%K{black}%}"
BG_WHITE="%{%K{white}%}"
BG_GRAY="%{%K{7}%}"
BG_RED="%{%K{red}%}"
BG_GREEN="%{%K{green}%}"
BG_YELLOW="%{%K{yellow}%}"
BG_BLUE="%{%K{blue}%}"
BG_CYAN="%{%K{cyan}%}"
BG_MAGENTA="%{%K{magenta}%}"

OFF="%{%f%}"

USERNAME_COLOR="$BLUE"
PATH_COLOR="$BLUE"
ENV_COLOR="$CYAN"
GIT_COLOR="$GREEN"
GIT_CHANGE_COLOR="$YELLOW"
TIME_COLOR="$GRAY"
PROMPT_COLOR="$BLUE"

function prompt_git_changes {
    changes="$(git status --porcelain 2>/dev/null | wc -l)"
    [ $changes -ne 0 ] && echo -n "!$(echo -e "$changes" | tr -d '[:space:]')"
}

function prompt_git_branch {
    branch="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
    [ "${#branch}" -ne 0 ] && echo -n ":$branch"
}

function prompt_git_color {
    changes="$(git status --porcelain 2>/dev/null | wc -l)"
    if [ $changes -ne 0 ]; then
        echo -n $GIT_CHANGE_COLOR
    else
        echo -n $GIT_COLOR
    fi
}

function prompt_virtualenv {
    [ -n "$VIRTUAL_ENV" ] && echo -n "venv "
}

function prompt_nenv {
    [ -n "$NODE_ENV" ] && echo -n "node "
}

function prompt_directory {
    current="$(pwd -P)"
    echo -n "${current/$HOME/~}"
}

function prompt_border_color {
    if [ "$(whoami)" = "root" ]; then echo -n $RED; else echo -n $PROMPT_COLOR; fi
}

function get_prompt() {
    # hostname removed: @$(prompt_border_color)`hostname`
    echo -n '$(prompt_border_color)╔══ ${USERNAME_COLOR}`whoami` ${ENV_COLOR}$(prompt_nenv)$(prompt_virtualenv)${PATH_COLOR}$(prompt_directory)$(prompt_git_color)$(prompt_git_branch)$(prompt_git_changes)\n$(prompt_border_color)╚╡${OFF}'
}

PROMPT=$(get_prompt)
