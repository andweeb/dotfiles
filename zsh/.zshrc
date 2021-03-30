# Load any of the following files that exist
function __load { [ -f "$1" ] && . "$1"; }
__load ~/.zle.zsh
__load ~/.fzf.zsh
__load ~/.colors.zsh
__load ~/.aliases.zsh

# Best prompt of all time
PROMPT='%F{cyan}%3~%f '

# Store history
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt sharehistory
setopt appendhistory
setopt incappendhistory

# Disable auto-correct
unsetopt CORRECT

# Less options
export LESS=mR

# Grep options
export GREP_OPTIONS='--color=always'

# Enable and configure zsh completions to use fzf
autoload -U compinit && compinit
__load ~/Code/dotfiles/fzf-tab/fzf-tab.plugin.zsh

# Load local zsh config
__load ~/.local.zsh
