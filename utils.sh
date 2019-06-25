#!/bin/bash

# Install oh-my-zsh
echo "-> Installing ZSH..."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp ./dracula.zsh-theme ~/.oh-my-zsh/themes/

# Install homebrew
if [ -n "$(which brew)" ]; then
    echo "-> brew is already installed"
else
    echo "-> Installing brew..."
    # Install Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


