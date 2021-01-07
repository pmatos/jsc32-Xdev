#! /bin/bash

DATESTART=$(date +%s%N)

progress()
{
    local now
    now=$(date +%s%N)
    echo "=== $(( (now - DATESTART) / 1000000 )): $*"
}

error()
{
    echo "$@" 1>&2
    usage_and_exit 1
}

usage_and_exit()
{
    usage
    exit "$1"
}

version()
{
    local p
    local v
    p="$1"
    v="$2"
    echo "$p version $v"
}

findtoolchainfile()
{
    # Looking for toolchain file
    # Location varies in BRPATH, depending if we used sdk for installation
    local brpath="$1"
    local f=$(find "${brpath}" -name toolchainfile.cmake -print -quit)
    if [[ -z "${f}" ]]; then
        error "could not find toolchain file"
    fi
    echo "${f}"
}
