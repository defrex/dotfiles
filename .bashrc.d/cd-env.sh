

export NODE_ENV

function remove_path (){
    IFS=:
    # convert PATH to an array
    path_array=($PATH)
    # remove old bin path
    path_array=( "${path_array[@]/$1}" )
    # output the new array
    PATH="${path_array[*]}"
    unset IFS
}

function cd (){

    cur_files="$(ls -la | awk '{print $9}')"
    if [[ $cur_files = *.exit* ]]; then
        source .exit
    fi

    builtin cd $@

    cur_files="$(ls -la | awk '{print $9}')"

    if [ -n "$VIRTUAL_ENV" ]; then
        deactivate
    fi
    if [[ $cur_files = *.env* ]]; then
        source .env/bin/activate
    fi

    if [ -n "$NODE_ENV" ]; then
        remove_path "$NODE_ENV/node_modules/.bin"
        export NODE_ENV=''
    fi

    if [[ $cur_files = *node_modules* ]]; then
        export NODE_ENV=`pwd`
        export PATH="$NODE_ENV/node_modules/.bin:$PATH"
    fi

    if [[ $cur_files = *.enter* ]]; then
        source .enter
    fi
}
