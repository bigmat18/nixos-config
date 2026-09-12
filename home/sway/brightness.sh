#!/usr/bin/env bash

if [[ "$1" != "+" && "$1" != "-" ]]; then
    echo "Must be: [+|-]"
    exit 1
fi

ACTIVE_MONITOR=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
DBUS_OUTPUT=$(echo "$ACTIVE_MONITOR" | tr '-' '_')
CURRENT_BRIGHTNESS=$(busctl --user -- get-property rs.wl-gammarelay "/outputs/$DBUS_OUTPUT" rs.wl.gammarelay Brightness | awk '{print $2}')

if [ -z "$CURRENT_BRIGHTNESS" ]; then
    CURRENT_BRIGHTNESS=1.0
fi

STEP=0.1

if [ "$1" == "+" ]; then
    NEW_BRIGHTNESS=$(awk "BEGIN {v=$CURRENT_BRIGHTNESS+$STEP; if(v>1.0) v=1.0; print v}")
else
    NEW_BRIGHTNESS=$(awk "BEGIN {v=$CURRENT_BRIGHTNESS-$STEP; if(v<0.1) v=0.1; print v}")
fi

busctl --user -- set-property rs.wl-gammarelay "/outputs/$DBUS_OUTPUT" rs.wl.gammarelay Brightness d "$NEW_BRIGHTNESS"
