#!/bin/bash

chmod +x ./scripts/*
for f in .*
do
    ln -s $(pwd)"/$f" "$HOME/${f##*/}"
done

