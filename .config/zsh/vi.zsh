# vi mode
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select {
if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
fi
}

zle -N zle-keymap-select
zle-line-init() {
zle -K viins
echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q'

