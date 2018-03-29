#!/usr/bin/env bash
# Initialize custom vim folders & add gruvbox colors

repo=$(git rev-parse --show-toplevel)
. $repo/scripts/lib/shared
. $repo/scripts/packages.sh

InstallVimPlugins () {
    isInstalled "vim" || InstallVim
    isInstalled "nvim" && (
        clr_bold clr_brown "Installing vim-plug (nvim) & vim plugins..."
        curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        nvim +PlugInstall +qall
    ) || (
        read -p "Looks like nvim is not installed! Install regular vim-plug? [Y/n] " yn
        case $yn in
            [Y]* )
                clr_bold clr_brown "Installing vim-plug & vim plugins..."
                curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                vim +PlugInstall +qall
                ;;
            *)
                exit 1
                ;;
        esac
    )
}

InitVimFolders () {
    # Initialize backup folders
    clr_bold clr_brown "Initializing vim backup directories..."
    mkdir -p ~/.vim/backup//
    mkdir -p ~/.vim/swap//
    mkdir -p ~/.vim/undo//
}

InitGruvbox () {
    alreadyExists ~/.vim/colors/gruvbox.vim && return

    clr_bold clr_brown "Adding gruvbox colorscheme..."

    mkdir -p ~/.vim/colors

    if [ ! -f ~/.vim/plugged/gruvbox/colors/gruvbox.vim ]; then
        clr_bold clr_red "Failed to add the gruvbox colorscheme!"
        clr_red "Ensure that the appropriate vim plugins are installed."
    else
        cp ~/.vim/plugged/gruvbox/colors/gruvbox.vim ~/.vim/colors/
    fi
}

InstallFonts () {
    read -p "$(clr_bold clr_bold "Install airline-compatible fonts? [Y/n] ")" yn
    case $yn in
        [Y]* )
            clr_bold clr_brown "Installing fonts..."
            git clone https://github.com/powerline/fonts.git && ./install.sh
            ;;
        *)
            clr_white "Okay, skipping..."
            ;;
    esac
}

InitVim () {
    # Install vim-plug, symlink the vimrc, and install the vim plugins
    InstallVimPlugins
    InitVimFolders
    InitGruvbox
    InstallFonts
}

if [ ! -f ~/.vimrc ]; then
    clr_bold clr_red "No vimrc found, run install.sh first."
fi

link=$(readlink ~/.vimrc)

# Ensure vimrc is linked correctly
if [[ $link == "$repo"* ]]; then

    # Install vim plugins using vim-plug
    read -p "$(clr_bold clr_white "Install all vimrc plugins in using vim-plug? [Y/n]: ")" yn
    [ $yn == "Y" ] && InitVim
else
    clr_bold clr_red "Unexpected vimrc, run install.sh first."
fi

