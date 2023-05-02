#!/usr/bin/env bash

bold=$(tput bold)
normal=$(tput sgr0)

function process_line(){
    line="$1"
    words=($1)
    location=${words[0]}
    file=$(echo "$location" | cut -d":" -f 1)
    linenr=$(echo "$location" | cut -d":" -f 2)
    column=$(echo "$location" | cut -d":" -f 3)
    let "column = $column - 2"
    type=${line#*‘}
    type=${type%%’*}
    type=" ($type)"
    sed_arg="$linenr""s/^\([^=]*=*\)/\1$type/"
    sed_command="sed -i '$sed_arg' $file"
    eval "$sed_command"
    echo "${bold}$file:$linenr:$column: ${normal}Added cast to${bold}$type"
}

function process(){
    while IFS= read -r line; do
        if [[ "$line" == *"without a cast"* ]]; then
            process_line "$line"
        fi
    done
}

build_command="$*"
$build_command 2>&1 >/dev/null | process
