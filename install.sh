#!/bin/bash

echo "Setting up your environment..."

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# zsh
ln -fs ${BASEDIR}/.zshrc ~/.zshrc

# install scm breeze shortcuts
if [[ ! -f "$HOME/.scm_breeze/scm_breeze.sh" ]]; then
	git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
	~/.scm_breeze/install.sh
fi;

# Install p10k
# https://github.com/romkatv/powerlevel10k
# https://qiita.com/szk07/items/b15c38ec73e547a23439
if [[ -f ~/.p10k.zsh ]]; then
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    source ~/.p10k.zsh
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme	
fi;


# install brew packages, replace with Brewfile later
. ${BASEDIR}/brew_install.sh

# let's run this bitch
source ~/.zshrc
