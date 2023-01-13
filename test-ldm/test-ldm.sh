#!/bin/bash

echo "Test ldm (Last Date of Modification) for incremental building units"

source="./source.c"

function getFormatedFileLdm() {
    local target=$1
    local format=$2
    stat ${target} --format=${format}
    local ldm=$?
    return $ldm
}

function getFileLdm0() {
    local target=$1
    getFormatedFileLdm ${target} %Y
    local ldm=$?
    return $ldm
}

function saveFileLdm() {
    local target="${1}-ldm.txt"
    local ldm=$2
    echo "${ldm}" > "${target}"
    return $?
}

function loadFileLdm() {
    local target="${1}-ldm.txt"
    cat $target
    return $?
}

function isModified() {
    local ldm0=$1
    local ldm1=$2
    let elapsed_ldm=$ldm1-$ldm0
    
    if (( $elapsed_ldm > 0 )); then
        echo "Compiling now ...."
        gcc $source --debug -o "${source}.o"
    elif (( $elapsed_ldm == 0 )); then
        echo "File not changed, leaving now ...."
    else 
        echo "State undefined ...."
    fi
}

# prepare LDMs (Last-Dates-Of-Modifications)
current_ldm=`getFileLdm0 $source`
last_ldm=`loadFileLdm $source`

# test if the file is modified 
isModified $last_ldm $current_ldm

# update the file ldm with current new ldm
saveFileLdm $source $current_ldm
