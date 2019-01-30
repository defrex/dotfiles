# Prompt!

# Foreground Colors
BLACK="\[\e[0;30m\]"
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"
LIGHT_GRAY='\e[0;37m'
GRAY="\[\e[0;37m\]"

DARK_GRAY="\[\e[1;30m\]"
LIGHT_BLUE="\[\e[1;34m\]"
LIGHT_GREEN="\[\e[1;32m\]"
LIGHT_CYAN="\[\e[1;36m\]"
LIGHT_RED="\[\e[1;31m\]"
LIGHT_PURPLE="\[\e[1;35m\]"
LIGHT_YELLOW="\[\e[1;33m\]"
WHITE="\[\e[1;37m\]"

INTENSE_BLACK='\[\e[0;90m\]'
INTENSE_RED='\[\e[0;91m\]'
INTENSE_GREEN='\[\e[0;92m\]'
INTENSE_YELLOW='\[\e[0;93m\]'
INTENSE_BLUE='\[\e[0;94m\]'
INTENSE_PURPLE='\[\e[0;95m\]'
INTENSE_CYAN='\[\e[0;96m\]'
INTENSE_WHITE='\[\e[0;97m\]'

# Background Colors
BG_BLACK='\[\e[40m\]'
BG_RED='\[\e[41m\]'
BG_GREEN='\[\e[42m\]'
BG_YELLOW='\[\e[43m\]'
BG_BLUE='\[\e[44m\]'
BG_PURPLE='\[\e[45m\]'
BG_CYAN='\[\e[46m\]'
BG_WHITE='\[\e[47m\]'

# High Intensity backgrounds
BG_INTENSE_BLACK='\e[0;100m'   # BLACK
BG_INTENSE_RED='\e[0;101m'     # Red
BG_INTENSE_GREEN='\e[0;102m'   # Green
BG_INTENSE_YELLOW='\e[0;103m'  # Yellow
BG_INTENSE_BLUE='\e[0;104m'    # Blue
BG_INTENSE_PURPLE='\e[0;105m'  # Purple
BG_INTENSE_CYAN='\e[0;106m'    # Cyan
BG_INTENSE_WHITE='\e[0;107m'   # White

OFF="\[\e[m\]"

USERNAME_COLOR="$BLUE"
PATH_COLOR="$BLUE"
ENV_COLOR="$CYAN"
GIT_COLOR="$GREEN"
GIT_CHANGE_COLOR="$YELLOW"
TIME_COLOR="$GRAY"
PROMPT_COLOR="$BLUE"

function git_changes {
    changes="`git status --porcelain 2> /dev/null | wc -l | sed 's/^[ \t]*//;s/[ \t]*$//'`"
    [ $changes -ne 0 ] && echo -n "!$changes"
}

function git_branch {
    branch="`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`"
    [ "${#branch}" -ne 0 ] && echo -n ":$branch"
}

function git_color {
    changes="`git status --porcelain 2> /dev/null | wc -l`"
    if [ $changes -ne 0 ];
        then echo -n $GIT_CHANGE_COLOR;
        else echo -n $GIT_COLOR;
    fi
}

function virtualenv {
    [ -n "$VIRTUAL_ENV" ] && echo -n "venv "
}

# Node.js env
function nenv {
    [ -n "$NODE_ENV" ] && echo -n "node "
}

# rails env
function test_rails {
    [ -n "$RAILS_ENV" ] && echo -n "rails "
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
    colour_used="$(border_color)${USERNAME_COLOR}$(border_color)${ENV_COLOR}${PATH_COLOR}$(git_color)${TIME_COLOR}"
    prompt_length="$((${#prompts}))"
    printable_length="$((${prompt_length} - ${#colour_used}))"
    echo -n "$((${COLUMNS} - ${printable_length} - 1))" # I don't know where the 1 comes from -_-
}
function prompt() {
    # History Mutherfucker!
    # history -a; history -c; history -r;

    dir=$(directory)
    prompt_right="${TIME_COLOR}`date +"%I:%M:%S"`"
    prompt_left="$(border_color)╔══ ${USERNAME_COLOR}`whoami`@$(border_color)`hostname` ${ENV_COLOR}$(nenv)$(virtualenv)$(test_rails)${PATH_COLOR}$dir$(git_color)$(git_branch)$(git_changes) "

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
