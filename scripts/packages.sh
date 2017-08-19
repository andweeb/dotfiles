#!/usr/bin/env bash
# Functions to install various software packages

repo=$(git rev-parse --show-toplevel)
. $repo/scripts/lib/colors

InstallVim () {
    clr_bold clr_brown "Installing vim..."
    isInstalled "pacapt" || InstallPacapt
    sudo pacapt -S vim
    checkInstallStatus "vim"
}

InstallBrew () {
    clr_bold clr_brown "Installing brew..."
    isInstalled "curl" || InstallCurl;
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    checkInstallStatus "brew"
}

InstallPacapt () {
    clr_bold clr_brown "Installing pacapt..."
    sudo wget -O /usr/local/bin/pacapt \
        https://github.com/icy/pacapt/raw/ng/pacapt && \
        sudo chmod 755 /usr/local/bin/pacapt && \
        sudo ln -sv /usr/local/bin/pacapt /usr/local/bin/pacman || true
    checkInstallStatus "pacapt"
}

InstallMacZsh () {
    isInstalled "brew" || InstallBrew;
    brew install zsh;
    checkInstallStatus "brew"
}

InstallLinuxZsh () {
    isInstalled "pacapt" || InstallPacapt
    sudo pacapt -S zsh
    checkInstallStatus "zsh"
}

InstallMacNvim () {
    isInstalled "brew" || InstallBrew;
    brew install neovim/neovim/neovim;
    checkInstallStatus "nvim"
}

InstallLinuxNvim () {
    isInstalled "pacapt" || InstallPacapt;

    clr_white "Adding neovim repository...";
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo pacapt -Syu

    clr_bold clr_brown "Installing nvim...";
    sudo pacapt -S neovim;

    checkInstallStatus "nvim"
}

InstallCurl () {
    if [ "$(uname)" == "Darwin" ]; then
        isInstalled "brew" || InstallBrew;
        brew install curl
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        isInstalled "pacapt" || InstallPacapt;
        sudo pacapt -S curl;
    fi
    checkInstallStatus "curl"
}

InstallGVM () {
    # Install GVM prerequisites
    if [ "$(uname)" == "Darwin" ]; then
        printf "\033[38;5;227mDetected \e[4mMac OS\033[0m, installing GVM prerequisites now...\n";
        isInstalled "brew" || InstallBrew
        brew update
        brew install mercurial
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        printf "\033[38;5;227mDetected \e[4mGNU/Linux\033[0m, installing GVM prerequisites now...\n";
        sudo apt-get install curl git mercurial make binutils bison gcc build-essential
    fi
    isInstalled "curl" || InstallCurl
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer);
    source ~/.gvm/scripts/gvm
    checkInstallStatus "gvm"
}

InstallGo () {
    clr_bold clr_brown "Installing Go...";
    # Install GVM to install Go
    InstallGVM
    gvm install go1.4 && gvm use go1.4 && export GOROOT_BOOTSTRAP=$GOROOT;
    printf "Add \033[38;5;204mexport GOROOT_BOOTSTRAP=$GOROOT\033[0m to your .bash_profile \n";
    # gvm install go1.5;
    checkInstallStatus "go"
}

InstallNode () {
    clr_bold clr_brown "Installing Node.js & NPM...";
    git clone https://github.com/tj/n.git && cd n && sudo make install && sudo n latest
    checkInstallStatus "n"
    checkInstallStatus "node"
    checkInstallStatus "npm"
}

InstallCMake () {
    clr_bold clr_brown "Installing cmake...";
    if [ "$(uname)" == "Darwin" ]; then
        isInstalled "brew" || InstallBrew
        brew install cmake
    elif [ "$(uname)" == "Linux" ]; then
        isInstalled "pacapt" || InstallPacapt;
        sudo pacapt -S cmake;
    fi
    checkInstallStatus "cmake"
}

InstallYCMPrereqs () {
    if [ "$(uname)" == "Darwin" ]; then
        read -p "Want to continue? [Y/n] " yn
        case $yn in
            [Y]* )
                clr_bold clr_brown "Installing YouCompleteMe dependencies..."
                isInstalled "brew" || InstallBrew
                brew install cmake
                ;;
            [Nn]* )
                exit
                ;;
        esac
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        printf "\033[38;5;227mDetected \e[4mGNU/Linux\033[0m\n";
        printf "\033[38;5;215mMake sure you have Vim 7.3.598 with python2 or python3 support before continuing.\033[0m\n"
        read -p "Want to continue? [Y/n] " yn
        case $yn in
            [Y]* ) clr_bold clr_brown "Installing YouCompleteMe dependencies..."
                isInstalled "pacapt" || InstallPacapt
                sudo pacapt -S build-essential cmake
                sudo pacapt -S python-dev python3-dev ;;
            [Nn]* ) exit ;;
        esac
    fi
    checkInstallStatus "cmake"
}
