alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -irv'
alias cwd='pwd | pbcopy'
alias bat='bat --theme="gruvbox-dark" --style=header,changes'

# Functions for asdf
function asdf-update-nightly-nvim () {
    asdf uninstall neovim nightly && \
        asdf install neovim nightly
}
function asdf-add-plugins () {
    cut -d' ' -f1 .tool-versions | sort \
      | comm -23 - <(asdf plugin-list | sort) \
      | join -a1 - <(asdf plugin list all) \
      | xargs -t -L1 asdf plugin add
}

# Alias nvim if installed
if command -v "nvim" > /dev/null; then
    alias vi='nvim'
fi
