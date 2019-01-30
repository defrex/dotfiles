export NODE_ENV

function remove_path (){
    export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`;
}

function cd (){
    cur_files="$(ls -la | awk '{print $9}')"
    if [[ $cur_files = *.exit* ]]; then
        source .exit
    fi

    builtin cd $@

    cur_files="$(ls -la | awk '{print $9}')"

    # if [ -n "$VIRTUAL_ENV" ]; then
    #     deactivate
    # fi
    # if [[ $cur_files = *venv* ]]; then
    #     source venv/bin/activate
    # fi

    if [ -n "$NODE_ENV" ]; then
        remove_path "$NODE_ENV/node_modules/.bin"
        unset NODE_ENV
    fi

    if [[ $cur_files = *node_modules* ]]; then
        export NODE_ENV=`pwd`
        export PATH="$NODE_ENV/node_modules/.bin:$PATH"
    fi

    if [[ $cur_files = *.enter* ]]; then
        source .enter
    fi
}
