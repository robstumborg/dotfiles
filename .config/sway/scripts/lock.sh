#!/usr/bin/bash
sshot="/tmp/swaylockscreen.png"
blurred="/tmp/swaylockscreen-blurred.png"
grim $sshot && \
  ffmpeg -i $sshot -filter_complex boxblur=lr=8:lp=2 -y $blurred && \
  swaylock -i $blurred -n

rm -rf $image $blurred
