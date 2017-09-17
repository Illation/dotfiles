#!/bin/sh

display(){
    VOL=`~/.bin/pacvol.sh display | sed "s/[^1-9]//" | sed "s/%//"`
    OUT=`yad --text="Volume" --text-align=center --scale --value $VOL --horizontal --no-buttons --timeout=1 --geometry=300x70 --class "YADWIN" --title "yad display" --on-top --undecorated | awk 'END {print $NF}'` &> /dev/null
}

input(){
    VOL=`~/.bin/pacvol.sh display | sed "s/[^1-9]//" | sed "s/%//"`
    OUT=`yad --text="Volume" --text-align=center --scale --value $VOL --vertical --button gtk-ok:0 --response=0 --geometry=x300 --class "YADWIN" --on-top --undecorated | awk 'END {print $NF}'` &> /dev/null
    if [[ $? -ne 1 ]];then
        TARGET="$((655*$OUT))"
        ~/.bin/conkexec.sh pacmd set-sink-volume 0 $TARGET
    fi
}

case $1 in
display)
	display;;
input)
	input
	exit 0;;
esac
