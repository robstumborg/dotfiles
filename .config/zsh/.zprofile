# xdg
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

# dbus
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

# runit
export SVDIR=$XDG_CONFIG_HOME/runit/services

# zsh config
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# wayland / desktop
export QT_SCALE_FACTOR=1
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME=qt5ct
export XDG_SESSION_TYPE=wayland
export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland
export XDG_CURRENT_DESKTOP=sway
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_SESSION_DESKTOP=sway
export GTK_THEME=Adwaita:dark

# etc
export EDITOR=nvim
export VISUAL=nvim
export GPG_TTY=$(tty)
export CHROME_EXECUTABLE=/usr/bin/chromium
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export DSTASK_GIT_REPO=$XDG_DATA_HOME/dstask
export PASSWORD_STORE_DIR=$XDG_DATA_HOME/pass
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export PASSWORD_STORE_GENERATED_LENGTH=34
export PASSWORD_STORE_CHARACTER_SET='123450!@#$%6789qwertQWERTasdfgASDFGzxcvbZXCVB'
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/config

# userbin
export PATH=$PATH:$HOME/bin

# go
export GOPATH=$XDG_DATA_HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GOPROXY=direct
export GOSUMDB=off

# python
export PATH=$PATH:$HOME/.local/bin

# rust
export CARGO_HOME=$XDG_DATA_HOME/cargo
export PATH=$PATH:$CARGO_HOME/bin

# php
export PATH=$PATH:$XDG_CONFIG_HOME/composer/vendor/bin

# android-tools
# export ANDROID_HOME=$XDG_DATA_HOME/android
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/platform-tools
# export ANDROID_SDK_ROOT=/opt/android-sdk
# export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
# export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# nvm
export NVM_DIR=$XDG_DATA_HOME/nvm

# ruby
export PATH=$PATH:$XDG_DATA_HOME/gem/ruby/3.0.0/bin

# js
export NPM_PACKAGES=$XDG_DATA_HOME/npm
export PATH=$PATH:$NPM_PACKAGES/bin
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
