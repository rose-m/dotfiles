#!/bin/bash

# Install oh-my-zsh
if [ -n "$(which zsh)" ]; then
    echo "-> ZSH is already installed"
else
    echo "-> Installing ZSH..."
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install homebrew
if [ -n "$(which brew)" ]; then
    echo "-> brew is already installed"
else
    echo "-> Installing brew..."
    # Install Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


