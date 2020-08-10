#!/bin/bash

echo "Setting up your environment..."

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# zsh
ln -s ${BASEDIR}/.zshrc ~/.zshrc

# install scm breeze shortcuts
if [[ ! -f "$HOME/.scm_breeze/scm_breeze.sh" ]]; then
	git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
	~/.scm_breeze/install.sh
fi;

# install brew packages, replace with Brewfile later
. ${BASEDIR}/brew_install.sh

# let's run this bitch
source ~/.zshrc
