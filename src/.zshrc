#################### Run bash if in text console ###########
[ "$TERM" = "linux" ] && exec /usr/bin/env bash

#################### Powerlevel10k instant prompt ##########
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################### Initialize zsh ########################
if [ -f /opt/antigen.zsh ]; then
    # Load antigen
    source /opt/antigen.zsh
    # Load bundles (oh-my-zsh, plugins, themes)
    antigen init ~/.antigenrc
    # Load powerlevel10k config (by "p10k configure")
    [ -f ~/.p10k.zsh ] && source ~/.p10k.zsh
fi

#################### Preferences ###########################
# Colors for man pages
export LESS_TERMCAP_me=$'\E[0m'         # Reset
export LESS_TERMCAP_md=$'\E[1;34m'      # Bold
export LESS_TERMCAP_us=$'\E[1;32m'      # Underline
export LESS_TERMCAP_ue=$'\E[0m'         # Exit underline
export LESS_TERMCAP_so=$'\E[1;30;45m'   # Standout
export LESS_TERMCAP_se=$'\E[0m'         # Exit standout

# Colors for "ls" command
[ -f ~/.dircolors ] && eval "$(dircolors ~/.dircolors)"

# Set editor for "sudoedit"
export EDITOR="/usr/bin/env vim"

#################### Key bindings ##########################
# Use "Ctrl+\" to accept zsh-autosuggestions
bindkey "^\\" autosuggest-accept
