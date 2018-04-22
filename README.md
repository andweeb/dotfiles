# Dotfiles :sparkles:

A collection of configuration files for my ideal personal development
environment, along with some custom convenience scripts to streamline the setup
process for both Mac and Linux.

#### `dotfiles/`
- `.aliases`
    - a random pile of shell aliases
    - imports an `~/.aliases.local` if it exists
- `.gitconfig`
    - typical git config with some predefined aliases
    - includes a `~/.gitconfig.local` if it exists
- `.hammerspoon`
    - custom keyboard triggers to open urls, focus apps, etc
- `.tmux.conf`
    - tmux in vi mode with a custom status bar
    - reattaches pbcopy to yank to the system clipboard
    - initializes tpm with some plugins if it exists
- `.vimrc`
    - gruvbox colorscheme
    - various plugins and configurations using vim-plug
    - sources a `~/.vimrc.local` if it exists
- `.zshrc`
    - start in oh-my-zsh and tmux with fzf and zle (in vi-mode)
    - sources `~/.aliases` and `~/.zshrc.local`
    - use custom `+` theme if available

#### `scripts/`
- NeoVim: `scripts/nvim-setup.sh`
    - link pre-existing vim configs
    - install and setup NeoVim
    - add NeoVim python provider
- Vim Plugins: `scripts/vim-plugin-setup.sh`
    - install plugins with `vim-plug`
    - initialize vim backup folder
    - add gruvbox colors
    - add pre-patched powerline fonts
- Zsh: `scripts/zsh-setup.sh`
    - install zsh if unavailable
    - install oh-my-zsh (`scripts/oh-my-zsh-setup.sh`)
    - install zplug

#### `term/`
- Alacritty yaml config
- iTerm2 gruvbox dark colors
- Terminal gruvbox dark colors
- custom oh-my-zsh theme (`+.zsh-theme`)
