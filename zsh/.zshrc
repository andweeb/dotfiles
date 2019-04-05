# Load any of the following files that exist
function __load { [ -f "$1" ] && . "$1"; }
__load ~/.zle.zsh
__load ~/.fzf.zsh
__load ~/.aliases
__load ~/.colors.zsh
__load ~/.local.zsh
__load ~/.nix-profile/etc/profile.d/nix.sh

# Best prompt of all time
PROMPT='%F{cyan}%3~%f '

# Store history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt sharehistory
setopt appendhistory
setopt incappendhistory

# Disable auto-correct
unsetopt CORRECT

# Less options
export LESS=mR

# Enable and configure zsh completions
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle -e ':completion:*:default' \
    list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# FZF
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='40%'
export FZF_COMPLETION_TRIGGER=',,'

export PATH=/bin:/usr/bin:/usr/local/bin:${PATH}
