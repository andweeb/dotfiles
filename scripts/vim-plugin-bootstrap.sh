#!/usr/bin/env bash
# Quickstart my personal vim plugins :)
#   Initialize custom vim folders & add gruvbox colors :)
#   Compile YouCompleteMe (install Node/NPM/TypeScript/Go)
. packages.sh

CompileYCM () {
    InstallYCMPrereqs

    # Install semantic support for Go/Node/TypeScript & YCM prereqs
    alreadyInstalled "go" || InstallGo
    alreadyInstalled "node" || InstallNode
    sudo npm install -g typescript

    # - Cross fingers & pray to the heavens -
    cd ~/.vim/bundle/YouCompleteMe && \
        ./install.py \
            --clang-completer \
            --gocode-completer \
            --tern-completer;

    # Check for success/error
    if [ $? -eq 0 ]; then
        printf "\033[38;5;82mNice! YouCompleteMe successfully compiled!\033[0m\n"
        printf "\033[38;5;215mAdd the following to your \033[4m.vimrc\033[0m\n"
        printf "\033[38;5;204m- let g:ycm_global_ycm_extra_conf='/path/to/.ycm_extra_conf.py'\033[0m\n"
        printf "\033[38;5;204m- let g:ycm_path_to_python_interpreter='/path/to/python'\033[0m\n"
    else
        printf "\033[38;5;196mUh oh :( Looks like YouCompleteMe failed to install.\033[0m\n"
        printf "\033[38;5;11mRead the docs @ https://github.com/Valloric/YouCompleteMe\033[0m\n";
        exit 1
    fi
}

InitVimFolders() {
    # Initialize backup folders
    printf "\033[38;5;227mInitializing vim backup directories...\033[0m\n"
    mkdir -p ~/.vim/backup//
    mkdir -p ~/.vim/swap//
    mkdir -p ~/.vim/undo//

    # Add gruvbox colorscheme
    printf "\033[38;5;227mAdding gruvbox colorscheme to ~/.vim/colors...\033[0m\n"
    mkdir -p ~/.vim/colors
    cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors/
}

if [ ! -f ~/.vimrc ]; then
    # Install Vundle, symlink the vimrc, and install the vim plugins
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ln -s ../vimrc ~/.vimrc
    vim +PluginInstall +qall
    InitVimFolders

    # Compile only after confirmation
    printf "\033[38;5;215mWe're about to compile YouCompleteMe.\033[0m\n"
    printf "\033[38;5;215m- Make sure to look at the docs @ https://github.com/Valloric/YouCompleteMe\033[0m\n"
    printf "\033[38;5;215m- We will install & update Go/Node/TypeScript and comile YCM with only those mentioned completion engines.\033[0m\n"
    printf "\033[38;5;215m- You should probably do it manually to modify the completion engines, but this attempts to streamline the process with only those listed languages.\033[0m\n"
    read -p "Want to give it a shot? (y/n): " yn
    case $yn in
        [Yy]* ) CompileYCM; exit;;
        [Nn]* ) exit;;
    esac
else
    printf "\033[38;5;11mWhoa! Looks like there's already a .vimrc! \033[0m\n"
    printf "\033[38;5;11mWe're about to symlink something onto it, so make sure you have it backed up, renamed, or removed.\033[0m\n"
fi
