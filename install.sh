#!/bin/bash

# Source dependencies
chmod +x ./scripts/*
. $(git rev-parse --show-toplevel)/scripts/lib/*

cd dotfiles

for f in .*
do
    if [[ ("$f" == ".") || ("$f" == "..") ]]; then
        continue
    fi

    target="$HOME/${f##*/}"

    if [ -f $target ]; then
        read -p "$(clr_white "Move the pre-existing $f to a backup folder? (y/n) ")" yn
        case $yn in
            [Yy]* )
                mv $target ../backups/${f:1}.bak
                ;;
            *)
                continue
                ;;
        esac
    fi

    ln -s $(pwd)"/$f" $target

    if [ $? -ne 0 ]; then
        clr_bold clr_red "$f symlink failed! Do this manually instead."
    fi
done

read -p "$(clr_bold clr_white "Install vim plugins and compile YCM? (y/n) ")" yn
case $yn in
    [Yy]* ) ../scripts/vim-plugin-bootstrap.sh ;;
esac
