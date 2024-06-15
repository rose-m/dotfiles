#!/usr/bin/env bash

SOURCE_DIR="$(cd ~ && pwd)"
TARGET_DIR="./"

if [[ "$1" == "install" ]]; then
	echo "Installing dotfiles..."
	TARGET_DIR="$(cd ~ && pwd)"
	SOURCE_DIR="."
else
	echo "Copying dotfiles..."
fi

cp "$SOURCE_DIR/.alacritty.toml" $TARGET_DIR
cp "$SOURCE_DIR/.gitconfig" $TARGET_DIR
cp "$SOURCE_DIR/.ideavimrc" $TARGET_DIR
cp "$SOURCE_DIR/.tmux.conf" $TARGET_DIR
cp "$SOURCE_DIR/.vimrc" $TARGET_DIR
cp "$SOURCE_DIR/.zshrc" $TARGET_DIR
