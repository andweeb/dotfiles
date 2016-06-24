# Path to oh-my-zsh installation.
export ZSH=/Users/askwon/.oh-my-zsh

# Paths
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/Library/TeX/texbin:/usr/local/Cellar:/usr/local/lib:/usr/local/include
export PATH=$PATH:~/.vimpkg/bin
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/sbin:$PATH

# Add RVM to PATH for scripting and load RVM into a shell session *as a function*
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# For Golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export GEM_HOME=~/.gem
export GEM_PATH=~/.gem

# For Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# For dem emojis 😏
export LANG=en_US.UTF-8

ZSH_THEME="+"

# ZSH Plugins (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Overview: https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview#node-js
plugins=(git colored-man colorize github jira vagrant virtualenv pip python brew osx zsh-syntax-highlighting go golang node npm brew extract)
eval $(thefuck --alias)

# Add .bash_profile exports and aliases to zshrc
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.bash_profile'

# ZSH Configs
DISABLE_AUTO_UPDATE=true
DISABLE_AUTO_TITLE=true
COMPLETION_WAITING_DOTS=true
NVIM_TUI_ENABLE_TRUE_COLOR=1

# Source some stuff
source $ZSH/oh-my-zsh.sh
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

setopt noincappendhistory
setopt nosharehistory

# Simple script to recompile YCM if necessary after an update
recompileYCM() {
    cd ~/.vim/bundle/YouCompleteMe && \
    ./install.py \
        --clang-completer \
        --gocode-completer \
        --tern-completer;
}

# Just keeping a record of all global npm installs
npmInstallGlobals() {
    npm install -g \
    n \
    xo \
    cash \
    gulp \
    rnpm \
    bower \
    snazzy \
    eslint \
    standard \
    babel-cli \
    grunt-cli \
    typescript \
    babel-eslint \
    concurrently \
    react-native-cli \
    instant-markdown-d
}

# Purge all derived data in Xcode
purgeDerivedData() {
    rm -rf ~/Library/Developer/Xcode/DerivedData/*;
}

# Enable the Gradle Daemon for the current user
# https://docs.gradle.org/2.9/userguide/gradle_daemon.html
enableGradleDaemon() {
    touch ~/.gradle/gradle.properties && echo "org.gradle.daemon=true" >> ~/.gradle/gradle.properties
}

# forward port 80:
#     iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT;
#     iptables -A INPUT -i eth0 -p tcp --dport 8080 -j ACCEPT;
#     iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080;

# Lazy browser open commands
firefox() { open $1 -a Firefox }
ffdev() { open $1 -a FirefoxDeveloperEdition }
chrome() { open $1 -a Google\ Chrome }

# Open applications given some argument(s)
atom() { open -a atom $*; }
sublime() { open -a sublime\ text $*; }

