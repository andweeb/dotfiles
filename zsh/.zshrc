# Current dotfiles directory
DOTDIR=~/Code/dotfiles
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

# Enable and configure zsh completions with fzf
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle -e ':completion:*:default' \
    list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
__load $DOTDIR/fzf-tab/fzf-tab.plugin.zsh

# Load local zsh config
__load $ZSHDIR/local.zsh
