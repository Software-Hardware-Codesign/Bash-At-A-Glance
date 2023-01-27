#!/bin/bash

# get command parameters
name=${1}
age=${2}
job=${3}

##
# Logs passed parameters and the root command name.
# @param name 
# @param age
# @param job
# @return the state
##
function LOG() {
    local command=${0}
    local name=${1}
    local age=${2}
    local job=${3}
    
    printf "%s\n" "${command}"
    printf "%s\n" "${name}"
    printf "%s\n" "${age}"
    printf "%s\n" "${job}"
    
    return $?
}

# pass command parameters to function parameters
LOG $name $age $job
