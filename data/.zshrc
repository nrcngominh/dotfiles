#################### Run bash if in text console ###########
[ "$TERM" = "linux" ] && exec /usr/bin/env bash

################### Automatically start tmux ###############
if command -v tmux > /dev/null; then
    # Prevent infinitive loop of zsh and tmux
    if [ -z "$TMUX" ] && [ -t 0 ]; then
        # Set $TERM
        export TERM=xterm-256color

        # Get tmux sessions
        session=$(tmux 2> /dev/null ls -F \
        '#{session_attached} #{?#{==:#{session_last_attached},},1,#{session_last_attached}} #{session_id}' |
        awk '/^0/ { if ($2 > t) { t = $2; s = $3 } }; END { if (s) printf "%s", s }')

        # Attach the last session if not attached or create a new one
        [ -n "$session" ] && exec tmux attach -t "$session" || exec tmux
    fi
fi 

#################### Powerlevel10k instant prompt ##########
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################### Initialize zsh ########################
if [ -f ~/antigen.zsh ]; then
    # Load antigen
    source ~/antigen.zsh
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
export EDITOR="/usr/bin/env nvim"

# Load fzf config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#################### Key bindings ##########################
# Use "Ctrl+\" to accept zsh-autosuggestions
bindkey "^\\" autosuggest-accept

#################### Aliases ###############################
# Use neovim instead of vim 
alias vim="nvim"

# Quick edit neovim configuration
alias ev="vim ${HOME}/.config/nvim/init.vim"
