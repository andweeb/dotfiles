# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# Configure fzf
export FZF_TMUX=1
export FZF_TMUX_HEIGHT="40%"
export FZF_COMPLETION_TRIGGER=",,"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
