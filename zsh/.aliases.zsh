alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -irv'
alias cwd='pwd | pbcopy'
alias bat='bat --theme="gruvbox-dark" --style=header,changes'

# Alias if neovim is installed
if command -v "nvim" > /dev/null; then
    alias vi='nvim'
    alias vim='nvim'
fi
