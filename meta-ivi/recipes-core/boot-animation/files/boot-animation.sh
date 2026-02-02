#!/bin/sh

FBDEV="/dev/fb0"
FRAME_DIR="/usr/share/boot-animation/frames"

[ -e "$FBDEV" ] || exit 0

i=1
while [ $i -le 30 ]; do
    FRAME="${FRAME_DIR}/frame${i}.raw"
    [ -f "$FRAME" ] && cat "$FRAME" > "$FBDEV"
    sleep 0.1
    i=$((i + 1))
done

exit 0
