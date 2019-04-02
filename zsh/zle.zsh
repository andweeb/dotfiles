# Enable ZLE in vi-mode
bindkey -v
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
export KEYTIMEOUT=1

# Allow history search
bindkey '^R' history-incremental-search-backward
HISTFILE=~/.zsh_history

# Vim Surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# Select within quotes
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done
