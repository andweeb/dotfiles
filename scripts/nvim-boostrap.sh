#!/usr/bin/env bash
# Simple nvim environment setup script
. packages.sh

printf "\033[38;5;11mLet's install NeoVim (งツ)ว\033[0m\n"
printf "\033[38;5;11mRead the installation docs @ https://github.com/neovim/neovim/wiki/Installing-Neovim\033[0m\n";

# Determine host & install nvim appropriately
if [ "$(uname)" == "Darwin" ]
then
    printf "\033[38;5;227mDetected \e[4mMac OS\033[0m\n";
    alreadyInstalled "nvim" && printf "\033[38;5;204mNeoVim is already installed! \033[0m\n" || InstallMacNvim;
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
    printf "\033[38;5;227mDetected \e[4mGNU/Linux\033[0m\n";
    alreadyInstalled "nvim" && printf "\033[38;5;204mNeoVim is already installed! \033[0m\n" || InstallLinuxNvim;
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    printf "\033[381;5;227mDetected \e[4mWindows\033[0m\n"
    echo "LOL sorry ¯\_(ツ)_/¯"
fi

printf "Add \033[38;5;204mlet g:python_host_prog='/path/to/python3'\033[0m to your \e[4m.vimrc\n";
