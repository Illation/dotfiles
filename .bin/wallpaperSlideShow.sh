#!/bin/bash
# This turns on xscreensaver using xwinwrap on one (or both) screens

#print usage
usage() { echo "Usage: $0 [-d <duration>] [-f <fade>] [-i <image dir>]" 1>&2; exit 1; }
#parse arguments
while getopts ":d:a:t:i:" o; do
    case "${o}" in
        d)
            DURATION=${OPTARG}
            ;;
        f)
            FADE=${OPTARG}
            ;;
        t)
            TIME=${OPTARG}
            ;;
	i)
	    IMAGEDIR=${OPTARG}
	    ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))
#default parameters
if [ -z "${DURATION}" ]; then
    DURATION=10
fi
if [ -z "${FADE}" ]; then
    FADE=2
fi
if [ -z "${TIME}" ]; then
    TIME=1
fi

#set image directory
#if ! [ -z "${IMAGEDIR}" ]; then
#	echo setting xScreensaver image directory to $IMAGEDIR
#	sed -i "s|^imageDirectory: .*$|imageDirectory: $IMAGEDIR|pw" "/home/illation/.xscreensaver"
#fi

#make sure xrandr already was set up
sleep $TIME
#get screen resolutions of active monitors with offset
RESOLUTIONS=$(xrandr | egrep '*\+' | sed -n 's/.*connected\|.*primary //p' | awk '{print $1;}')
#create command with glslideshow and xwinwrap for each screen
(for RES in $RESOLUTIONS
do
	echo xwinwrap -b -sp -st -nf -ni -ov -g $RES -- /usr/lib/xscreensaver/glslideshow -root -window-id WID -zoom 100 -duration $DURATION -fade $FADE -clip; 
done) | parallel #run those commands simultaneously using gnu parallel
