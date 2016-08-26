#!/usr/bin/env bash
# Simple nvim environment setup script
. packages.sh

printf "\033[38;5;11mLet's install NeoVim (งツ)ว\033[0m\n"
printf "\033[38;5;11mRead the installation docs @ https://github.com/neovim/neovim/wiki/Installing-Neovim\033[0m\n";

linkConfigs () {
    mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
    ln -s ~/.vim $XDG_CONFIG_HOME/nvim
    ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
}

alreadyInstalled "vim" || InstallVim;

# Determine host & install nvim appropriately
if [ "$(uname)" == "Darwin" ]
then
    printf "\033[38;5;227mDetected \e[4mMac OS\033[0m\n";
    linkConfigs
    alreadyInstalled "python3" || brew install python3;
    alreadyInstalled "nvim" && printf "\033[38;5;204mNeoVim is already installed! \033[0m\n" || InstallMacNvim;
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
    printf "\033[38;5;227mDetected \e[4mGNU/Linux\033[0m\n";
    linkConfigs
    alreadyInstalled "python3" || sudo pacapt -S python3;
    alreadyInstalled "nvim" && printf "\033[38;5;204mNeoVim is already installed! \033[0m\n" || InstallLinuxNvim;
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    printf "\033[381;5;227mDetected \e[4mWindows\033[0m\n"
    echo "LOL sorry ¯\_(ツ)_/¯"
fi

printf "Add \033[38;5;204mlet g:python_host_prog='$(which python3)'\033[0m to your \e[4m.vimrc\n";
