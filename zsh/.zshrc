# Current dotfiles directory
DOTDIR=~/Code/dotfiles
PKGDIR="$DOTDIR/packages"
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

# Set italic terminfo
export TERM=xterm-256color-italic

# Load asdf and load completions
__load $PKGDIR/asdf/asdf.sh
fpath=($ASDF_DIR/completions $fpath)

# Check cached .zcompdump only once a day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

# Use menu-driven completion and color completion
zstyle ':completion:*' menu select
zstyle -e ':completion:*:default' \
    list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Enable and configure zsh completions with fzf
__load $PKGDIR/fzf-tab/fzf-tab.plugin.zsh

# Load local zsh config
__load $ZSHDIR/local.zsh
