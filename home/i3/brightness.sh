#!/bin/bash

 if [[ "$1" != "+" && "$1" != "-" ]]; then
    echo "Must be: [+|-]"
    exit 1
fi

eval $(xdotool getmouselocation --shell)

SCREEN_NAME=""
while read -r line; do
    name=$(echo $line | cut -d' ' -f1)
    geom=$(echo $line | grep -o '[0-9]\+x[0-9]\++[0-9]\++[0-9]\+')
    width=$(echo $geom | cut -d'x' -f1)
    rest=$(echo $geom | cut -d'x' -f2)
    height=$(echo $rest | cut -d'+' -f1)
    xoff=$(echo $rest | cut -d'+' -f2)
    yoff=$(echo $rest | cut -d'+' -f3)

    if [ "$X" -ge "$xoff" ] && [ "$X" -lt $((xoff + width)) ] && \
       [ "$Y" -ge "$yoff" ] && [ "$Y" -lt $((yoff + height)) ]; then
        SCREEN_NAME="$name"
        break
    fi
done < <(xrandr | grep ' connected')

CURRENT_BRIGHTNESS=$(xrandr --verbose | awk -v screen="$SCREEN_NAME" '
    $1 == "Brightness:" && found {print $2; exit}
    $1 == screen {found=1}
')

if [ -z "$CURRENT_BRIGHTNESS" ]; then
    CURRENT_BRIGHTNESS=1.0
fi

 STEP=0.1

if [ "$1" == "+" ]; then
    NEW_BRIGHTNESS=$(awk "BEGIN {v=$CURRENT_BRIGHTNESS+$STEP; if(v>1.0) v=1.0; print v}")
else
    NEW_BRIGHTNESS=$(awk "BEGIN {v=$CURRENT_BRIGHTNESS-$STEP; if(v<0.1) v=0.1; print v}")
fi

xrandr --output "$SCREEN_NAME" --brightness "$NEW_BRIGHTNESS"