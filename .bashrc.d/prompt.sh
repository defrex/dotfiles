# Prompt!

BLACK="\[\e[0;30m\]"
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"
GRAY="\[\e[0;37m\]"
OFF="\[\e[m\]"

USERNAME_COLOR="$BLUE"
PATH_COLOR="$BLUE"
ENV_COLOR="$CYAN"
GIT_COLOR="$YELLOW"
TIME_COLOR="$GRAY"

# [ -z "$PROMPT_COLOR" ] && export PROMPT_COLOR="$BLUE"

function git_changes {
    changes="`git status --porcelain 2> /dev/null | wc -l`"
    [ $changes -ne 0 ] && echo -n "!$changes"
}

function git_branch {
    branch="`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`"
    [ "${#branch}" -ne 0 ] && echo -n ":"$branch
}

function virtualenv {
    # local e=`basename $VIRTUAL_ENV 2>/dev/null`
    # [ ! -z "$e" ] && echo -n "penv:$e "

    [ -n "$VIRTUAL_ENV" ] && echo -n "venv "
}

# Node.js env
function nenv {
    # local e=`basename $NODE_ENV 2>/dev/null`
    # [ ! -z "$e" ] && echo -n "nenv:$e "

    [ -n "$NODE_ENV" ] && echo -n "node "
}

function directory {
    current="`pwd -P`"
    echo -n "${current/$HOME/'~'}"
}

function border_color {
    if [ "`whoami`" == "root" ]; then echo -n $RED; else echo -n $PROMPT_COLOR; fi
}

function extender_line {
    line="`printf -vch "%$($1)s" ""; printf "%s" "${ch// /═}"`"
}

function get_extender_length() {
    prompts="$@"
    colour_used="$(border_color)${USERNAME_COLOR}$(border_color)${ENV_COLOR}${PATH_COLOR}${GIT_COLOR}${TIME_COLOR}"
    prompt_length="$((${#prompts}))"
    printable_length="$((${prompt_length} - ${#colour_used}))"
    echo -n "$((${COLUMNS} - ${printable_length} - 1))" # I don't know where the 1 comes from -_-
}
function prompt() {
    # History Mutherfucker!
    history -a; history -c; history -r;

    dir=$(directory)
    prompt_right="${TIME_COLOR}`date +"%I:%M:%S"`"
    prompt_left="$(border_color)╔══ ${USERNAME_COLOR}`whoami`@$(border_color)`hostname` ${ENV_COLOR}$(nenv)$(virtualenv)${PATH_COLOR}$dir${GIT_COLOR}$(git_branch)$(git_changes) "

    extender_length=`get_extender_length $prompt_left $prompt_right`
    if [ "$extender_length" -lt -9 ]; then
        # Put an elipsis in the dir name, eg. ~/one/two/three/four -> ~/one/.../four

        first_dir=`echo $dir | cut -d '/' -f 1`
        [ "$first_dir" == "~" ] && first_dir=\~/`echo $dir | cut -d '/' -f 2`

        last_dir=`echo $dir | tr '/' '\n' | tail -n 1`
        replaces_dir="$first_dir/.../$last_dir"

        prompt_left=${prompt_left//$dir/$replaces_dir}
        extender_length=`get_extender_length $prompt_left $prompt_right`
    fi

    if [ "$extender_length" -lt 0 ]; then
        extender_length="0"
        prompt_right=""
    fi
    prompt_extender="$(border_color)`printf -vch "%${extender_length}s" ""; printf "%s" "${ch// /═}"`╡${OFF}"

    prompt_line2="$(border_color)╚╡${OFF}"

    PS1=$(printf "%s%s%s\n%s" \
        "$prompt_left" \
        "$prompt_extender" \
        "$prompt_right" \
        "$prompt_line2")
}

PROMPT_COMMAND=prompt