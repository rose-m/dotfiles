#!/bin/bash

if [[ ! -d ~/.config ]]; then
    mkdir ~/.config
fi

# Clone Astronvim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim +PackerSync

# Clone custom config
git clone https://github.com/rose-m/astronvim_config.git ~/.config/nvim/lua/user
nvim +PackerSync
