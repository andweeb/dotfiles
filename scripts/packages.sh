#!/usr/bin/env bash
# Functions to install various software packages

alreadyInstalled () {
    command -v $1 >/dev/null 2>&1 && return 0 || return 1
}

checkInstallStatus () {
    alreadyInstalled $1 && printf "\033[38;5;82m$1 successfully installed! \033[0m\n" ||
        (printf "\033[38;5;196m$1 failed to install! \033[0m\n" && exit 1)
}

InstallBrew () {
    printf "\033[38;5;227mInstalling brew...\033[0m\n"
    alreadyInstalled "curl" || InstallCurl;
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    checkInstallStatus "brew"
}

InstallPacapt () {
    printf "\033[38;5;227mInstalling pacapt...\033[0m\n"
    sudo wget -O /usr/local/bin/pacapt \
    https://github.com/icy/pacapt/raw/ng/pacapt && \
    sudo chmod 755 /usr/local/bin/pacapt && \
    sudo ln -sv /usr/local/bin/pacapt /usr/local/bin/pacman || true
    checkInstallStatus "pacapt"
}

InstallMacNvim () {
    alreadyInstalled "brew" || InstallBrew;
    brew install neovim/neovim/neovim;
    checkInstallStatus "nvim"
    exit 1
}

InstallLinuxNvim () {
    # Install pacapt if not installed
    alreadyInstalled "pacapt" || InstallPacapt;
    # Install prerequisites, add nvim repo & install
    printf "\033[38;5;227mInstalling nvim requirements...\033[0m\n";
    sudo pacapt -S software-properties-common python-dev python-pip python3-dev python3-pip;
    printf "\033[38;5;227mAdding nvim repository...\033[0m\n";
    sudo add-apt-repository ppa:neovim-ppa/unstable;
    printf "\033[38;5;227mInstalling nvim...\033[0m\n";
    sudo pacapt -Syu && sudo pacapt -S neovim;
    checkInstallStatus "nvim"
}

InstallCurl () {
    if [ "$(uname)" == "Darwin" ]; then
        printf "\033[38;5;227mDetected \e[4mMac OS\033[0m\n";
        alreadyInstalled "brew" || InstallBrew;
        brew install curl
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        printf "\033[38;5;227mDetected \e[4mGNU/Linux\033[0m\n";
        alreadyInstalled "pacapt" || InstallPacapt;
        sudo pacapt -S curl;
    fi
    checkInstallStatus "curl"
}

InstallGVM () {
    # Install GVM prerequisites
    if [ "$(uname)" == "Darwin" ]; then
        printf "\033[38;5;227mDetected \e[4mMac OS\033[0m, installing GVM prerequisites now...\n";
        alreadyInstalled "brew" || InstallBrew
        brew update
        brew install mercurial
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        printf "\033[38;5;227mDetected \e[4mGNU/Linux\033[0m, installing GVM prerequisites now...\n";
        sudo apt-get install curl git mercurial make binutils bison gcc build-essential
    fi
    alreadyInstalled "curl" || InstallCurl
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer);
    source ~/.gvm/scripts/gvm
    checkInstallStatus "gvm"
}

InstallGo () {
    printf "\033[38;5;227mInstalling Go...\n";
    # Install GVM to install Go
    InstallGVM
    gvm install go1.4 && gvm use go1.4 && export GOROOT_BOOTSTRAP=$GOROOT;
    printf "Add \033[38;5;204mexport GOROOT_BOOTSTRAP=$GOROOT\033[0m to your .bash_profile \n";
    # gvm install go1.5;
    checkInstallStatus "go"
}

InstallNode () {
    printf "\033[38;5;227mInstalling Node.js & NPM...\n";
    git clone https://github.com/tj/n.git && cd n && sudo make install && sudo n latest
    checkInstallStatus "n"
    checkInstallStatus "node"
    checkInstallStatus "npm"
}

InstallCMake () {
    printf "\033[38;5;227mInstalling CMake...\n";
    if [ "$(uname)" == "Darwin" ]; then
        printf "\033[38;5;227mDetected \e[4mMac OS\033[0m\n";
        alreadyInstalled "brew" || InstallBrew
        brew install cmake
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        printf "\033[38;5;227mDetected \e[4mGNU/Linux\033[0m\n";
        alreadyInstalled "pacapt" || InstallPacapt;
        sudo pacapt -S cmake;
    fi
    checkInstallStatus "cmake"
}

InstallYCMPrereqs () {
    if [ "$(uname)" == "Darwin" ]; then
        printf "\033[38;5;227mDetected \033[4mMac OS\033[0m\n";
        printf "\033[38;5;215mIf you want C-family completion, you MUST have the latest Xcode installed along with the latest Command Line Tools\033[0m\n"
        printf "\033[38;5;215m(they are installed automatically when you run clang for the first time, or manually by running xcode-select --install)\033[0m\n"
        read -p "Want to continue? (y/n): " yn
        case $yn in
            [Yy]* ) printf "\033[38;5;227mInstalling YouCompleteMe dependencies...\033[0m\n"
                alreadyInstalled "brew" || InstallBrew
                brew install cmake ;;
            [Nn]* ) exit ;;
        esac
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        printf "\033[38;5;227mDetected \e[4mGNU/Linux\033[0m\n";
        printf "\033[38;5;215mMake sure you have Vim 7.3.598 with python2 or python3 support before continuing.\033[0m\n"
        read -p "Want to continue? (y/n): " yn
        case $yn in
            [Yy]* ) printf "\033[38;5;227mInstalling YouCompleteMe dependencies...\033[0m\n"
                alreadyInstalled "pacapt" || InstallPacapt
                sudo pacapt -S build-essential cmake
                sudo pacapt -S python-dev python3-dev ;;
            [Nn]* ) exit ;;
        esac
    fi
    checkInstallStatus "cmake"
}
