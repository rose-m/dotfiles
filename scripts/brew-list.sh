#!/usr/bin/env bash

brew ls -1 --formulae > ~/.homebrew_list
brew ls -1 --casks >> ~/.homebrew_list

echo "Saved the following Homewbrew list:"
cat ~/.homebrew_list
