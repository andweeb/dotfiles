# ----------------------------------------------------------------------------
# Environment Variables
# ----------------------------------------------------------------------------
# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8

# Paths
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/Library/TeX/texbin:/usr/local/Cellar:/usr/local/lib:/usr/local/include
export PATH=$PATH:~/.vimpkg/bin
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/sbin:$PATH
# (Go)
export GOPATH=$HOME/go:$HOME/Sites
export GOROOT=/usr/local/go
export GOBIN=/usr/local/go/bin
export PATH=$PATH:$GOBIN
# (Android)
export ANDROID_HOME=/usr/local/opt/android-sdk
# (C#)
export MONO_GAC_PREFIX="/usr/local"
# (Rust)
export PATH=$HOME/.cargo/bin:$PATH

# ----------------------------------------------------------------------------
# Zsh Configurations
# ----------------------------------------------------------------------------
ZSH_THEME="+"

# Start in tmux pl0x
if ! [ -n "$TMUX" ]; then
    command -v tmux >/dev/null 2>&1 &&
    command -v reattach-to-user-namespace >/dev/null 2>&1 && {
        exec tmux
    }
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
# Zsh Plugins
# ----------------------------------------------------------------------------
command -v zplug >/dev/null 2>&1 && {
    export ZPLUG_HOME=~/.zplug
    source $ZPLUG_HOME/init.zsh

    zplug "plugins/git", from:oh-my-zsh
    zplug "plugins/docker", from:oh-my-zsh
    zplug "plugins/colored-man", from:oh-my-zsh
    zplug "plugins/colorize", from:oh-my-zsh
    zplug "plugins/github", from:oh-my-zsh
    zplug "plugins/jira", from:oh-my-zsh
    zplug "plugins/vagrant", from:oh-my-zsh
    zplug "plugins/virtualenv", from:oh-my-zsh
    zplug "plugins/pip", from:oh-my-zsh
    zplug "plugins/python", from:oh-my-zsh
    zplug "plugins/brew", from:oh-my-zsh
    zplug "plugins/osx", from:oh-my-zsh
    zplug "plugins/zsh-syntax-highlighting", from:oh-my-zsh
    zplug "plugins/go", from:oh-my-zsh
    zplug "plugins/golang", from:oh-my-zsh
    zplug "plugins/node", from:oh-my-zsh
    zplug "plugins/npm", from:oh-my-zsh
    zplug "plugins/brew", from:oh-my-zsh
    zplug "plugins/extract", from:oh-my-zsh
    zplug "plugins/mix", from:oh-my-zsh
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "b4b4r07/zsh-vimode-visual", defer:3

    zplug load
}

# ----------------------------------------------------------------------------
# External Plugin Scripts
# ----------------------------------------------------------------------------
gruvboxsh=$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh
[[ -e "$gruvboxsh" ]] && source $gruvboxsh                  # gruvbox colors
[[ -e "$ZSH/oh-my-zsh.sh" ]] && source $ZSH/oh-my-zsh.sh    # oh-my-zsh
command -v thefuck >/dev/null 2>&1 && {                     # thefuck
    eval $(thefuck --alias)
}

# Zsh Line Editor (vi-mode)
bindkey -v
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
export KEYTIMEOUT=1

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='45%'
export FZF_COMPLETION_TRIGGER=',,'
