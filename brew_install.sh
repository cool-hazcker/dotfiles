#!/bin/bash

brew update

brew upgrade

brew bundle install

ln -s -f /usr/local/bin/python3 /usr/local/bin/python
ln -s -f /usr/local/bin/pip3 /usr/local/bin/pip

