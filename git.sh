#!/bin/bash

# Set up git config
git config --global user.name "Michael Rose"
git config --global user.email "michael_rose@gmx.de"

git config --global core.autocrlf "input"
git config --global core.editor "nvim"

git config --global --add url."git@github.com:".insteadOf "https://github.com/"

git config --global merge.tool nvimdiff3
git config --global mergetool.keepbackup false
