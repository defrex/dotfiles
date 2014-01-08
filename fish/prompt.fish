
function fish_prompt
  if [ (whoami) = 'root' ]
    set base_color red
  else
    set base_color blue
  end
  set env_color cyan
  set git_color yellow

  set_color $base_color
  printf "╔══ $USER"

  if test "$VIRTUAL_ENV" != '' -o "$NODE_BIN" != ''
    set_color $env_color
    printf " "
  end
  if test $VIRTUAL_ENV
    printf "venv"  (basename $VIRTUAL_ENV)
    if test $NODE_BIN
      printf ','
    end
  end
  if test $NODE_BIN
    printf "node"
  end

  set_color $base_color
  printf " %s" (pwd | sed -e "s#$HOME#~#i")

  set branch (git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' -e 's/\n//g')
  if test $branch
    set_color $git_color
    printf ":%s" $branch

    set changes (git status --porcelain 2> /dev/null | wc -l)
    if [ $changes != '0' ]
      printf ".%s" $changes
    end
  end

  echo
  set_color $base_color
  printf "╚╡"
  set_color normal
end

function fish_right_prompt
  set_color blue
  printf "%s" (date +"%I:%M:%S")
end
