

export NODE_ENV

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
        IFS=:
        # convert PATH to an array
        path_array=($PATH)
        # remove old NODE_ENV
        old_bin="$NODE_ENV/node_modules/.bin"
        path_array=(${path_array[@]%%$old_bin})
        # output the new array
        PATH="${path_array[*]}"
        unset IFS

        export NODE_ENV=''
    fi

    if [[ $cur_files = *node_modules* ]]; then
        export NODE_ENV=`pwd`
        export PATH="$PATH:$NODE_ENV/node_modules/.bin"
    fi

    if [[ $cur_files = *.enter* ]]; then
        source .enter
    fi
}
