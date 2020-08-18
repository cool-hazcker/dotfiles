#!/bin/bash

brew update

brew upgrade

# system utils
brew install htop
brew install tree
brew install pstree

# set up python
brew install python3
ln -s -f /usr/local/bin/python3 /usr/local/bin/python
ln -s -f /usr/local/bin/pip3 /usr/local/bin/pip

# networking
brew install httpie

# editors
brew install vim

# misc
brew install bat
brew install terminal-notifier

