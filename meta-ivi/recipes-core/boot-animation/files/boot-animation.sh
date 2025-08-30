#!/bin/sh
FBDEV="/dev/fb0"
FRAME_DIR="/usr/share/boot-animation/frames"

i=1
while [ $i -le 30 ]; do
    FRAME=$(printf "%s/frame%d.raw" "$FRAME_DIR" "$i")
    if [ -f "$FRAME" ]; then
        cat "$FRAME" > "$FBDEV"
        sleep 0.1
    fi
    i=$((i+1))
done
