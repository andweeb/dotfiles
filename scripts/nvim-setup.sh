#!/usr/bin/env bash
# Simple nvim environment setup script
repo=$(git rev-parse --show-toplevel)
. $repo/scripts/lib/shared
. $repo/scripts/packages.sh

clr_bold clr_white "Let's install NeoVim! (งツ)ว"
clr_white "See the installation docs @ https://github.com/neovim/neovim/wiki/Installing-Neovim."

isInstalled "vim" || InstallVim;

read -p "$(clr_bold clr_brown "Link any pre-existing vim configurations to neovim? [Y/n] ")" yn
case $yn in
    [Y]* )
        mkdir -p $HOME/.config/nvim
        if [ -f ~/.vim ]; then
            ln -s ~/.vim $HOME/.config/nvim
        fi
        if [ -f ~/.vimrc ]; then
            ln -s ~/.vimrc $HOME/.config/nvim/init.vim
        fi
        ;;
esac

# Determine host & install nvim appropriately
if [ "$(uname)" == "Darwin" ]; then
    isInstalled "python3" || brew install python3;
    isInstalled "nvim" || InstallMacNvim;
elif [ "$(uname)" == "Linux" ]; then
    isInstalled "python3" || sudo pacapt -S python3;
    isInstalled "nvim" || InstallLinuxNvim;
fi

if [ $? -eq 0 ]; then
    clr_brown "Set \`python_host_prog\` to your python3 path in your vimrc.";
fi

read -p "$(clr_bold clr_brown "Add Python 3 provider to NeoVim? [Y/n] ")" yn
case $yn in
    [Y]* )
        isInstalled "pip3" || sudo pacapt -S python3-pip;
        sudo pip3 install --upgrade neovim
        ;;
esac
