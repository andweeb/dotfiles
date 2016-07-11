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

InitGruvbox () {
    printf "\033[38;5;227mAdding gruvbox colorscheme to ~/.vim/colors...\033[0m\n"
    mkdir -p ~/.vim/colors
    if [ ! -f ~/.vim/bundle/gruvbox/colors/gruvbox.vim ]; then
        printf "\033[38;5;196mThe gruvbox vim plugin was not installed! Ensure that the appropriate vim plugins are installed. \033[0m\n" && exit 1
    else
        cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors/
    fi
}

InitVimFolders () {
    # Initialize backup folders
    printf "\033[38;5;227mInitializing vim backup directories...\033[0m\n"
    mkdir -p ~/.vim/backup//
    mkdir -p ~/.vim/swap//
    mkdir -p ~/.vim/undo//

    # Add gruvbox colorscheme
    alreadyExists ~/.vim/colors/gruvbox.vim || InitGruvbox
}

InitVim () {
    # Install Vundle, symlink the vimrc, and install the vim plugins
    alreadyExists ~/.vim/bundle/Vundle.vim || InstallVundle
    InstallVimPlugins
    InitVimFolders
}

ConfirmYCMInstall () {
    # Compile only after confirmation
    printf "\033[38;5;215mWe're about to compile YouCompleteMe.\033[0m\n"
    printf "\033[38;5;215m- Make sure to look at the docs @ https://github.com/Valloric/YouCompleteMe\033[0m\n"
    printf "\033[38;5;215m- We will install & update Go/Node/TypeScript and compile YCM with only those mentioned completion engines.\033[0m\n"
    printf "\033[38;5;215m- You should probably do it manually to modify the completion engines, but this attempts to streamline the process with only those listed languages.\033[0m\n"
    read -p "Want to give it a shot? (y/n): " yn
    case $yn in
        [Yy]* ) CompileYCM; exit;;
        [Nn]* ) exit;;
    esac
}

# Check if .vimrc was properly installed
if [ ! -f ~/.vimrc ]; then
    printf "\033[38;5;196mLooks like you don't have a .vimrc in your home directory yet! \033[0m\n"
    printf "\033[38;5;196mWe will be installing Vim plugins based on askwon's .vimrc, so run install.sh first.\033[0m\n"
else
    printf "\033[38;5;11m* Ensure you have askwon's .vimrc symlinked to your home directory! * \033[0m\n\n"
    printf "\033[38;5;11mWe're gonna attempt to do the following: \033[0m\n"
    printf "\033[38;5;11m- Install Vundle and install all plugins listed in ~/.vimrc. \033[0m\n"
    printf "\033[38;5;11m- Initialize vim backup directories and install the gruvbox colorscheme. \033[0m\n"
    read -p "Continue? (y/n): " yn
    case $yn in
        [Yy]* ) InitVim && ConfirmYCMInstall; exit;;
        [Nn]* ) exit;;
    esac
fi

