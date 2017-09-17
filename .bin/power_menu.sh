#! /bin/bash

action=$(yad --width 300 --entry --title "System Logout" --class "YADWIN" --undecorated \
    --image=gnome-shutdown \
    --button="Switch User:2" \
    --button="gtk-ok:0" --button="gtk-close:1" \
    --text "Choose action:" \
    --entry-text \
    "Power Off" "Reboot" "Suspend" "Logout")
ret=$?

[[ $ret -eq 1 ]] && exit 0

if [[ $ret -eq 2 ]]; then
    gdmflexiserver --startnew &
    exit 0
fi

case $action in
    Power*) cmd="shutdown now" ;;
    Reboot*) cmd="reboot" ;;
    Suspend*) cmd="sudo /bin/sh -c 'echo disk > /sys/power/state'" ;;
    Logout*) cmd="i3-msg exit" ;;
    *) exit 1 ;;    
esac

eval exec $cmd
