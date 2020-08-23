#!/usr/bin/env bash

latestRelease() {
    curl -s https://api.github.com/repos/andweeb/ki/releases/latest \
        | grep 'github.*download.*Ki.spoon.zip' \
        | cut -d\" -f4
}

mkdir -p ~/.hammerspoon/Spoons

curl -L -o ~/.hammerspoon/Spoons/Ki.Spoon.zip $(latestRelease) && \
    unzip ~/.hammerspoon/Spoons/Ki.Spoon.zip -d ~/.hammerspoon/Spoons
