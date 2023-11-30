#################### Run bash if in text console ###########
if [ "$TERM" = "linux" ]; then
    exec /usr/bin/env bash
fi

#################### Detect intergrated terminal ###########

export TERM_INTEGRATED=0
[ "$TERM_PROGRAM" = "vscode" ] && export TERM_INTEGRATED=1

#################### Automatically start tmux ##############
if [ $TERM_INTEGRATED = 0 ]; then 
    ENABLED_TMUX_ATTACH=0

    if [[ -z "$TMUX" ]];  then
        if tmux has-session 2>/dev/null && [ $ENABLED_TMUX_ATTACH = 1 ]; then
            exec tmux attach
        else
            exec tmux
        fi
    fi
fi

#################### Powerlevel10k instant prompt ##########
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################### Initialize zsh ########################
if [ -f ~/.antigen.zsh ]; then
    # Load antigen
    source ~/.antigen.zsh

    # Load bundles (oh-my-zsh, plugins, themes)
    antigen init ~/.antigenrc

    # Load powerlevel10k config (by "p10k configure")
    if [ -f ~/.p10k.zsh ]; then
        source ~/.p10k.zsh
    fi
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
if [ -f ~/.dircolors ]; then
    eval "$(dircolors ~/.dircolors)"
fi

# Set editor for "sudoedit"
export EDITOR="/usr/bin/env vim"

#################### Key bindings ##########################
# Use "Ctrl+\" to accept zsh-autosuggestions
bindkey "^\\" autosuggest-accept

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias rm="trash"
