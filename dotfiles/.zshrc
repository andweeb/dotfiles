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
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"
export TERM=xterm-256color

# Use custom zsh theme if installed
if [ -f ~/.oh-my-zsh/custom/themes/+.zsh-theme ]; then
    export ZSH_THEME="+"
fi

# Start in tmux if installed with reattach-to-user-namespace
if ! [ -n "$TMUX" ]; then
    command -v tmux >/dev/null 2>&1 &&
    command -v reattach-to-user-namespace >/dev/null 2>&1 && {
        exec tmux
    }
fi

# Source an existing aliases dotfile
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# Source an existing local zshrc
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# Set zsh completion use ls colors
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# ZSH Configs
export DISABLE_AUTO_UPDATE=true
export DISABLE_AUTO_TITLE=true
export COMPLETION_WAITING_DOTS=true
export NVIM_TUI_ENABLE_TRUE_COLOR=1

setopt noincappendhistory
setopt nosharehistory

# ----------------------------------------------------------------------------
# Zsh Plugins
# ----------------------------------------------------------------------------
if command -v "zplug" > /dev/null; then
    export ZPLUG_HOME=~/.zplug
    . $ZPLUG_HOME/init.zsh

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
fi

# ----------------------------------------------------------------------------
# External Plugin Configurations
# ----------------------------------------------------------------------------
gruvboxsh=$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh

# Source gruvbox colors
if [ -f "$gruvboxsh" ]; then
    . "$gruvboxsh"
fi

# Source oh my zsh
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    . "$ZSH/oh-my-zsh.sh"
fi

# Zsh Line Editor (vi-mode)
bindkey -v
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
export KEYTIMEOUT=1

# FZF
if [ -f ~/.fzf.zsh ]; then
    . ~/.fzf.zsh
fi
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='45%'
export FZF_COMPLETION_TRIGGER=',,'
