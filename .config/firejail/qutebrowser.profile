noblacklist ${HOME}/.config/foot
mkdir ${HOME}/.config/foot
whitelist ${HOME}/.config/foot
noblacklist ${HOME}/.config/mpv
mkdir ${HOME}/.config/mpv
whitelist ${HOME}/.config/mpv
noblacklist ${HOME}/.config/nvim
mkdir ${HOME}/.config/nvim
whitelist ${HOME}/.config/nvim

whitelist ${HOME}/dl
include /etc/firejail/allow-lua.inc
include /etc/firejail/qutebrowser.profile
