zmodload -i zsh/complist
zstyle :compinstall filename $XDG_CONFIG_HOME.'/zsh/.zshrc'
zstyle ':completion:*' menu select
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS} "ma=48;5;153;1"
bindkey -M menuselect '^[[Z' reverse-menu-complete

autoload -Uz compinit
compinit

# dstask completions
_dstask() {
    compadd -- $(dstask _completions "${words[@]}")
}
compdef _dstask dstask
