#!/bin/sh

echo "{ \"version\": 1, \"stop_signal\": 10, \"cont_signal\": 12, \"click_events\": true }"
echo "["
echo "[],"
conky -d

IFS="}"
while read;do
  IFS=" "
  STR=`echo $REPLY | sed -e s/[{}]//g -e "s/ \"/\"/g" | awk '{n=split($0,a,","); for (i=1; i<=n; i++) {m=split(a[i],b,":"); if (b[1] == "\"name\"") {NAME=b[2]} if (b[1] =="\"x\"") {X=b[2]} if (b[1] =="\"y\"") {Y=b[2]} } print NAME " " X " " Y}'`

  read NAME X Y <<< $STR

  X=$(($X-50))
  case "${NAME}" in
    \"temp\")
      yad --no-buttons --text-info --geometry=500x260+$X+20 --class "YADWIN" --margins=10 --filename=<(acpi -V)
      ;;
    \"date\")
        yad --no-buttons --geometry=+$X+20 --class "YADWIN" --calendar
      ;;
    \"volume\")
        ~/.bin/app_volume.sh input
      ;;
    \"off\")
        oblogout
      ;;
    *)
      ;;
  esac
  IFS="}"
done
