#!/bin/bash

chmod +x ./scripts/*
for f in .*
do
    if [[ ("$f" == ".") || ("$f" == "..") || ("$f" == ".git") ]]; then
        continue
    fi

    if [ -f "$HOME/${f##*/}" ]; then
        printf "\033[38;5;11mLooks like there's already a \033[4m$f\033[0m \033[38;5;11min your home directory.\033[0m\n"
        read -p "Move your current $f to a backup folder? (y/n): " yn
        case $yn in
            [Yy]* ) mv "$HOME/${f##*/}" ./backups/${f:1}.bak
            ln -s $(pwd)"/$f" "$HOME/${f##*/}"
            if [ $? -eq 0 ]; then
                printf "\033[38;5;82m$f symlinked to your home directory.\033[0m\n"
            else
                printf "\033[38;5;196m$f symlink failed. Manually do this.\033[0m\n"
            fi
            ;;
        esac
    else
        ln -s $(pwd)"/$f" "$HOME/${f##*/}"
        if [ $? -eq 0 ]; then
            printf "\033[38;5;82m$f symlinked to your home directory.\033[0m\n"
        else
            printf "\033[38;5;196m$f symlink failed. Manually do this.\033[0m\n"
        fi
    fi
done

read -p "Install vim plugins and compile YCM?" yn
case $yn in
    [Yy]* ) ./scripts/vim-plugin-bootstrap.sh ;;
esac
