export TERM=xterm-256color
eval "$(dircolors)"

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

source $XDG_CONFIG_HOME/zsh/vi.zsh
source $XDG_CONFIG_HOME/zsh/completion.zsh
source $XDG_CONFIG_HOME/zsh/history.zsh
zinit load "zsh-users/zsh-autosuggestions"
bindkey '^l' autosuggest-accept
source $XDG_CONFIG_HOME/zsh/aliases.zsh

# node version manager
# source /usr/share/nvm/init-nvm.sh

# settings
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden -g "!{node_modules,.git,vendor}"'
export BAT_THEME="OneHalfDark"
export MANPAGER="nvim +Man!"

# don't let url-quote-magic & autosuggestions conflict
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic 
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# shell theme
export PURE_GIT_PULL=0
fpath+=$XDG_CONFIG_HOME/zsh/pure
autoload -U promptinit; promptinit
prompt pure

source ~/.config/zsh/zsh-artisan/artisan.plugin.zsh
zinit load "zsh-users/zsh-syntax-highlighting"
