alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -irv'
alias cwd='pwd | pbcopy'
alias bat='bat --theme="gruvbox-dark" --style=header,changes'
alias update-asdf-nvim-nightly='asdf uninstall neovim nightly && asdf install neovim nightly'

# Alias if neovim is installed
if command -v "nvim" > /dev/null; then
    alias vi='nvim'
    alias vim='nvim'
fi
