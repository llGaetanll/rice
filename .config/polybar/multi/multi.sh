#!/bin/bash

## ARRRGG A BASH SCRIPT GET OUTTT
## EVERY SCRIPT SHOULD BE POSIX SHELL

## This script starts the multi-monitor polybar setup

# kill all running polybar instances
killall polybar
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# load each desktop's polybar
i=1
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar -c "${XDG_CONFIG_HOME:-$HOME/.config}/polybar/multi/$i.ini" bar &
    ((i++))
done
