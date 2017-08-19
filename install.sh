#!/bin/bash

repo=$(git rev-parse --show-toplevel)

# Source dependencies
chmod +x $repo/scripts/*
chmod +x $repo/scripts/lib/*
. $repo/scripts/lib/shared
. $repo/scripts/lib/colors

for f in $repo/dotfiles/.*
do
    filename=${f##*/}
    if [[ ("$filename" == ".") || ("$filename" == "..") ]]; then
        continue
    fi

    target="$HOME/$filename"

    if [ -f $target ]; then
        read -p "$(clr_white "Move the pre-existing $filename to a backup folder? [Y/n] ")" yn
        [ $yn == "Y" ] && mv $target $repo/backups/$filename.bak || continue
    fi

    ln -s $f $target

    if [ $? -ne 0 ]; then
        clr_bold clr_red "Failed to symlink $filename! Do this manually instead."
    fi
done
