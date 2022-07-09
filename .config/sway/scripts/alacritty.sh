#!/bin/bash

if [ `pgrep alacritty` != 0 ]
then
    alacritty
else
    alacritty msg create-window
fi;

