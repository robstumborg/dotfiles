#!/bin/bash

if [ $(pgrep wf-recorder) != 0 ]; then
    dimensions=$(slurp)
    audio=$(echo -e "desktop\nmicrophone\nnone\ncancel" | rofi -dmenu -p 'screencast audio')
    file="$HOME/vid/screencast/screencast-$(date +%F-%H-%M-%S).mp4"
    cmd="wf-recorder -f \"${file}\" -g \"${dimensions}\" -c h264_vaapi -d /dev/dri/renderD128"

    case $audio in
        desktop)
            cmd+=" --audio=\"alsa_output.usb-Generic_Blue_Microphones_LT_201028234628D70F0609_111000-00.analog-stereo.monitor\""
            bash -c "${cmd}"
        ;;
        microphone)
            cmd+=" --audio=\"alsa_card.usb-Generic_Blue_Microphones_LT_201028234628D70F0609_111000-00\""
            bash -c "${cmd}"
        ;;
        none)
            bash -c "${cmd}"
        ;;
        cancel)
            exit
        ;;
    esac
else
    pkill --signal SIGINT wf-recorder
    notify-send "wf-recorder" "screencast saved!"
fi

