
function index
  set i 0
  for item in $argv[2]
    if [ $item = $argv[1] ]
      echo -ne i
    end
    set i i+1
  end
end

function fish;/usr/bin/python2 -m fish; end
