# Dotfiles :sparkles:

A collection of configuration files for my ideal personal development
environment, along with some custom convenience scripts to streamline the setup
process for both Mac and Linux.

#### `scripts/`
- Dotfiles: `install.sh`
    - symlink dotfiles from `dotfiles/` to `$HOME`
    - move existing dotfiles to `backups/`
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
- Terminal gruvbox dark
- iTerm2 gruvbox dark & preferences file
- custom zsh theme (`+.zsh-theme`)

#### `apps/`
- QuickSilver triggers
- Karabiner-Elements config file (`v0.90.29`)
