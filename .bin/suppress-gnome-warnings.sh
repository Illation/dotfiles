#!/bin/sh

# solution adapted from: http://askubuntu.com/questions/505594
# TODO: use a list of warnings instead of cramming all of them to a single grep.
# TODO: generalize gedit() to allow the same treatment for several commands
#       without duplicating the function with only a different name
# output filter. takes: name_for_history some_command [arguments]
# the first argument is required both for history, but also when invoking to bg
# such that it shows Done <name> ... instead of e.g. Done /usr/bin/gedit ...
suppress-gnome-warnings() {
    # $1 is the name which should appear on history but is otherwise unused.
    historyName=$1
    shift

    if [ -n "$*" ]; then
        # write the real command to history without the prefix
        # syntax adapted from http://stackoverflow.com/questions/4827690
        history -s "$historyName ${@:2}"

        # catch the command output
        errorMsg=$( $* 2>&1 )

        # check if the command output contains not a (one of two) GTK-Warnings
        if ! $(echo $errorMsg | grep -q 'Gtk-WARNING\|connect to accessibility bus'); then
            echo $errorMsg
        fi
    fi
}
yad() {
  suppress-gnome-warnings $FUNCNAME $(which $FUNCNAME) $@
}
