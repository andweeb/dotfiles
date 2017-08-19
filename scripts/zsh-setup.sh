#!/usr/bin/env bash

repo=$(git rev-parse --show-toplevel)
. $repo/scripts/lib/shared
. $repo/scripts/packages.sh

read -p "$(clr_bold clr_white "Install zsh, oh-my-zsh, and zplug? [Y/n] ")" yn
case $yn in
    [Y]* )
        clr_bold clr_brown "Installing zsh..."
        if [ "$(uname)" == "Darwin" ]; then
            InstallMacZsh
        elif [ "$(uname)" == "Linux" ]; then
            InstallLinuxZsh
        fi

        clr_bold clr_brown "Installing oh-my-zsh..."
        . $repo/scripts/oh-my-zsh-setup.sh

        clr_bold clr_white "Adding custom zsh theme..."
        mkdir -p $HOME/.oh-my-zsh/custom/themes
        cp $repo/term/+.zsh-theme $HOME/.oh-my-zsh/custom/themes

        clr_bold clr_brown "Installing zplug..."
        isInstalled "curl" || InstallCurl;
        sudo curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
        sudo chown -R $USER ~/.zplug

        if [ $? -eq 0 ]; then
            clr_bold clr_green "Zsh setup successful!"
            clr_brown "Set \`python_host_prog\` to your python3 path in your vimrc.";
        fi
        ;;
esac
