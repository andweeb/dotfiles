# Setup fzf
# ---------
export PATH="$PATH:$PKGDIR/fzf/bin"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$PKGDIR/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$PKGDIR/fzf/shell/key-bindings.zsh"

# Configure fzf
export FZF_TMUX=1
export FZF_TMUX_HEIGHT="40%"
export FZF_COMPLETION_TRIGGER=",,"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
