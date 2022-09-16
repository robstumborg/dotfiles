# config
alias mitmproxy="mitmproxy --set confdir=$XDG_CONFIG_HOME/mitmproxy"
alias mitmweb="mitmweb --set confdir=$XDG_CONFIG_HOME/mitmproxy"
alias mbsync="mbsync -c $XDG_CONFIG_HOME/mbsync/config"
alias wget="wget --hsts-file=/tmp/.wget-hsts"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias g="git"
alias music="ncmpcpp"
alias rm="rm -i"
alias ls="ls --color"
alias l="ls -lah"
alias grep="grep --color"
alias task="dstask"
alias fd="fd --color=auto"
alias tomb="tomb -f"
alias campv="mpv av://v4l2:/dev/video0"
alias tb="nc termbin.com 9999"
alias cl="curl -F 'clbin=<-' https://clbin.com"
alias ip='ip -color=auto'
alias busy="cat /dev/urandom | hexdump -C | grep '1a cc'"
alias tz="php ~/scripts/time.php"
alias checkencoding="ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1"
alias clip2qr="wl-paste | qrencode -t ANSI"
alias sshfs="sshfs -oauto_cache,reconnect"
alias studev="sshfs -oauto_cache,reconnect stu:/home/stu ~/mount/stu"
alias mp3='yt-dlp -f bestaudio --extract-audio --audio-format mp3 --add-metadata -o "%(title)s.%(ext)s"'
alias mp3tor='mp3 --proxy socks5://127.0.0.1:9050'
alias mp3album='yt-dlp -f bestaudio --extract-audio --audio-format mp3 --split-chapters -o "chapter:%(section_title)s.%(ext)s" --add-metadata --parse-metadata "title:%(artist)s - %(album)s"'
alias password="</dev/urandom tr -dc '123450!@#$%6789qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c34"
alias passgen="pass generate -c"
alias sc="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias mail="$XDG_CONFIG_HOME/email/check-email.sh"

urlencode() {
    php -r "echo urlencode('$1');"
}
urldecode() {
    php -r "echo urldecode('$1');"
}

# xbps
alias xbi="sudo xbps-install"
alias xbr="sudo xbps-remove"
alias xbq="xbps-query"

for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "${method}"="curl -X '${method}'"
done


ipi() {
    curl -s https://ipinfo.io/$1
}

upload() {
    if [ $# -lt 1 ]; then
        echo "filename parameter required"
        return
    fi

    if [ $1 = "img" ]; then
        file="$HOME/img/sshot/$(/usr/bin/ls -Art $HOME/img/sshot | tail -n 1)"
    elif [ $1 = "vid" ]; then
        file="$HOME/vid/screencast/$(/usr/bin/ls -Art $HOME/vid/screencast | tail -n 1 )"
    else
        file=$1
    fi

    filename=$(basename $file)

    curl -fsSL -F "file=@${file}" http://0x0.st
}
alias up=upload

androidproxy() {
    if [ $# -lt 1 ]; then
        echo "parameter required: on/off"
        return
    fi

    if [ $1 = "on" ]; then
        adb shell settings put global http_proxy 192.168.0.10:8080
    elif [ $1 = "off" ]; then
        adb shell settings put global http_proxy :0
    else
        echo "parameter required: on/off"
    fi
}
alias ap=androidproxy

function calc() {
    echo "$@" | bc -l
}

function cur() {
    php $HOME/scripts/cur.php $1 $2 $3 $4
}
