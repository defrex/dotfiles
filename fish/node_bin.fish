
set -x NODE_BIN ''
function __set_node_bin --on-variable PWD --description 'Set a node bin'
  status --is-command-substitution; and return
  if test (ls -l | grep node_modules)
    set -x NODE_BIN "$PWD/node_modules/.bin/"
    set -x PATH $PATH $NODE_BIN
  else if test $NODE_BIN
    set new_path
    for dir in $PATH
      if not [ $dir = $NODE_BIN ]
        set new_path $new_path $dir
      end
    end
    set -x NODE_BIN ''
    set -x PATH $new_path
  end
end
