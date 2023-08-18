xdg_config=${XDG_CONFIG_HOME:-$HOME/.config}

# Conditionally source prompt if exists, otherwise git clone it
# [ -d "$xdg_config/zsh/themes/powerlevel10k" ] &&\
#     source $xdg_config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme || \
#     git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $xdg_config/zsh/themes/powerlevel10k

# A lot of this comes from LukeSmithxyz/voidrice
# although I did modify and annotate some parts

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# source aliases
[ -f "$xdg_config/shortcutrc" ] && source "$xdg_config/shortcutrc"
[ -f "$xdg_config/aliasrc" ] && source "$xdg_config/aliasrc"

# source language startup files
[ -f "$xdg_config/langinit" ] && source "$xdg_config/langinit"

# when command is not found, assume to mean cd
setopt auto_cd

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode - note that `-e` would use emacs shortcuts
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# # ctrl+f -> cd into fzfed directory
# bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
#
# bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


# load version control information
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd_vcs_info() { vcs_info }
precmd_functions+=(precmd_vcs_info)

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats " %F{blue}%r%F{white}/%F{cyan}%b%F{white}"

setopt prompt_subst

PROMPT='%B[%b%F{red}%n%F{white}%B@%b%F{green}%m%F{white} %F{white}%~%F{white}%B${vcs_info_msg_0_}]%b '


# Conditionally load syntax highlighting otherwise, clone it; should be last.
[ -d "$xdg_config/zsh/plugins/fast-syntax-highlighting" ] &&\
    source $xdg_config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh || \
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $xdg_config/zsh/plugins/fast-syntax-highlighting



# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
