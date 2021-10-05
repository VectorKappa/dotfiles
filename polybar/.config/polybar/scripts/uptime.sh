#!/bin/zsh

seconds=$(cat /proc/uptime | awk '{print $1}' | xargs printf "%.*f\n" "$p")

function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%dd ' $D
  (( $H > 0 )) && printf '%dh ' $H
  (( $M > 0 )) && printf '%dm' $M
  printf '\n'
}

displaytime $seconds