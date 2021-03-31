# Current dotfiles directory
DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHDIR="$DOTDIR/zsh"

# Load any of the following files that exist
function __load { [ -f "$1" ] && . "$1"; }
__load $ZSHDIR/zle.zsh
__load $ZSHDIR/fzf.zsh
__load $ZSHDIR/colors.zsh
__load $ZSHDIR/aliases.zsh

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

export GREP_OPTIONS='--color=always' # Grep options
export LESS=mR                       # Less options

# Load asdf and load completions
__load $DOTDIR/asdf/asdf.sh
fpath=($DOTDIR/asdf/completions $fpath)

# Enable and configure zsh completions to use fzf
autoload -U compinit && compinit
__load $DOTDIR/fzf-tab/fzf-tab.plugin.zsh

# Load local zsh config
__load $ZSHDIR/local.zsh
