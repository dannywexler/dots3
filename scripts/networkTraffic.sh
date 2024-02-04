#!/bin/bash

interface='enp5s0'

function rawNetworkBytes() {
    awk '{i++; recv[i]=$1; up[i]=$2}; END{print (recv[2]-recv[1]) " " (up[2]-up[1])}' <(cat /proc/net/dev | grep ${interface} | awk -F' ' '{print $2 " " $10}'; sleep 1; cat /proc/net/dev | grep ${interface} | awk -F' ' '{print $2 " " $10}')
}

function formatItem() {
    item=$(echo "$1 8" | awk '{print $1 * $2}')
    suffix="b"
    if [[ $item -gt 1000000 ]]; then
        # item=$(( $item/1000000 ))
        item=$(echo "$item 1000000" | awk '{print $1 / $2}')
        suffix="Mb"
    elif [[ $item -gt 1000 ]]; then
        item=$(echo "$item 1000" | awk '{print $1 / $2}')
        suffix="Kb"
    fi
    printf '%6.2f%s' $item $suffix
}

function formatNetworkBytes() {
    down=$(formatItem $1)
    up=$(formatItem $2)
    upOrDown=$3
    if [[ "$upOrDown" == "up" ]]; then
        # echo "UL $up    "
        printf '%9s' $up
    elif [[ "$upOrDown" == "down" ]]; then
        # echo "DL $down   "
        # echo $down
        printf '%9s' $down
    fi
}

formatNetworkBytes $(rawNetworkBytes) $1
