# ----------------------------------------------------------------------------
# Environment Variables
# ----------------------------------------------------------------------------
# Path to oh-my-zsh installation.
export ZSH=/Users/$USER/.oh-my-zsh
export LANG=en_US.UTF-8

# Paths
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/Library/TeX/texbin:/usr/local/Cellar:/usr/local/lib:/usr/local/include
export PATH=$PATH:~/.vimpkg/bin
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/sbin:$PATH

# Add RVM to PATH for scripting and load RVM into a shell session *as a function*
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export GEM_HOME=~/.gem
export GEM_PATH=~/.gem

export GOPATH=$HOME/go:$HOME/Sites
export GOROOT=/usr/local/go
export GOBIN=/usr/local/go/bin
export PATH=$PATH:$GOBIN

export ANDROID_HOME=/usr/local/opt/android-sdk

# ----------------------------------------------------------------------------
# Zsh Configurations
# ----------------------------------------------------------------------------
ZSH_THEME="+"

# ZSH Plugins (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git colored-man colorize github jira vagrant virtualenv pip python brew osx zsh-syntax-highlighting go golang node npm brew extract)

# Start in tmux pl0x
if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

# Add .bash_profile exports and aliases to zshrc
[[ -e ~/.bash_profile ]] && emulate sh -c 'source ~/.bash_profile'

# ZSH Configs
DISABLE_AUTO_UPDATE=true
DISABLE_AUTO_TITLE=true
COMPLETION_WAITING_DOTS=true
NVIM_TUI_ENABLE_TRUE_COLOR=1

setopt noincappendhistory
setopt nosharehistory

# ----------------------------------------------------------------------------
# Custom commands
# ----------------------------------------------------------------------------
# Lazy browser open commands
firefox() {
    open $1 -a Firefox
}
firefox-dev() {
    open $1 -a FirefoxDeveloperEdition
}
chrome() {
    open $1 -a Google\ Chrome
}
chrome-security-disabled() {
    open $1 -a Google\ Chrome --args --disable-web-security --user-data-dir
}

# Open applications given some argument(s)
atom() {
    open -a atom $*;
}
sublime() {
    open -a sublime\ text $*;
}

# ----------------------------------------------------------------------------
# External Plugin Scripts
# ----------------------------------------------------------------------------
eval $(thefuck --alias)                                     # thefuck
source $ZSH/oh-my-zsh.sh                                    # oh-my-zsh
source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"   # gruvbox color palette
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh                      # fzf
export FZF_COMPLETION_TRIGGER=',,'

