#!/usr/bin/bash
sshot="/tmp/swaylockscreen.png"
blurred="/tmp/swaylockscreen-blurred.png"
grim $sshot && \
  ffmpeg -i $sshot -filter_complex boxblur=lr=8:lp=2 -y $blurred && \
  swaylock -i $blurred \
    --font "Hack Nerd Font Mono" \
    --text-color ffffffff \
    --ring-color c678dd \
    --key-hl-color 6eaafb \
    --text-color abb2bf \
    --ring-ver-color 98c379 \
    --inside-ver-color 98c379 \
    --line-color 00000000 \
    --inside-color 282c34 \
    --separator-color 00000000 \

rm -rf $image $blurred
