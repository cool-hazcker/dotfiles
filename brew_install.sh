#!/bin/bash

brew update

brew upgrade

brew install htop

# set up python
brew install python3
ln -s -f /usr/local/bin/python3 /usr/local/bin/python
ln -s -f /usr/local/bin/pip3 /usr/local/bin/pip

# misc
brew install terminal-notifier

