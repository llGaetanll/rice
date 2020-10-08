# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# A lot of this comes from LukeSmithxyz/voidrice
# although I did modify and annotate some parts
xdg_config=${XDG_CONFIG_HOME:-$HOME/.config}

# source theme
source $xdg_config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Source aliases
[ -f "$xdg_config/shortcutrc" ] && source "$xdg_config/shortcutrc"
[ -f "$xdg_config/aliasrc" ] && source "$xdg_config/aliasrc"

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

# Use lf to switch directories
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# ctrl+o -> open lf in current dir
# uncomment if you have lf installed
# bindkey -s '^o' 'lfcd\n'

# ctrl+a -> calculator
bindkey -s '^a' 'bc -l\n'

# ctrl+f -> cd into fzfed directory
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load syntax highlighting; should be last.
source $xdg_config/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
