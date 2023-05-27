# Recursively adds `~/.local/bin` subdirectories to $PATH
# This is to make nested scripts like `setbg` accessible
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"

export EDITOR="nvim" # default text editor is neovim
export TERMINAL="alacritty" # default terminal is alacritty
export BROWSER="firefox" # default browser is firefox
export READER="zathura" # default pdf reader is zathura

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.

# pixel scrolling in firefox
# see: https://askubuntu.com/questions/1148934/precise-scrolling-in-firefox
export MOZ_USE_XINPUT2=1

# stop firefox from crashing when opening multiple links in signal or discord
# see: https://www.reddit.com/r/archlinux/comments/n7cu62/comment/hzof4cc/?utm_source=share&utm_medium=web2x&context=3
export DBUS_SESSION_BUS_ADDRESS="autolaunch:"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

export LESSHISTFILE="-"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1 && exec startx
