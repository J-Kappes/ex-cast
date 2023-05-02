#!/usr/bin/env bash

function process_line(){
    line="$1"
    words=($1)
    location=${words[0]}
    file=$(echo "$location" | cut -d":" -f 1)
    linenr=$(echo "$location" | cut -d":" -f 2)
    column=$(echo "$location" | cut -d":" -f 3)
    echo "$file"
    # echo "$linenr"
    # echo "$column"
    let "column = $column - 2"
    # echo "$column"
    type=${line#*‘}
    type=${type%%’*}
    type=" ($type)"
    # echo "$type"
    sed_arg="$linenr""s/^\([^=]*=*\)/\1$type/"
    # echo "$sed_arg"
    command="sed -i '$sed_arg' $file"
    # echo "$command"
    eval "$command"
}

function process(){
    while IFS= read -r line; do
        if [[ "$line" == *"without a cast"* ]]; then
            # echo "$line"
            process_line "$line"
        fi
    done
}

command="$*"
$command 2>&1 >/dev/null | process
