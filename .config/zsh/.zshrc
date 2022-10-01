export TERM=xterm-256color


source $XDG_CONFIG_HOME/zsh/vi.zsh
source $XDG_CONFIG_HOME/zsh/completion.zsh
source $XDG_CONFIG_HOME/zsh/history.zsh
source $XDG_CONFIG_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $XDG_CONFIG_HOME/zsh/aliases.zsh
source $XDG_CONFIG_HOME/zsh/zsh-artisan/artisan.plugin.zsh

# settings
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden -g "!{node_modules,.git,vendor}"'
export BAT_THEME="OneHalfDark"
export MANPAGER="nvim +Man!"

# shell theme
export PURE_GIT_PULL=0
fpath+=$XDG_CONFIG_HOME/zsh/pure
autoload -U promptinit; promptinit
prompt pure

source $XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
