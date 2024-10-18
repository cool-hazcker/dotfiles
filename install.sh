#!/usr/bin/env bash

# good reference https://github.com/maxjkfc/mac-setting/blob/505ea65efd8ffd27c031a459c221d91429827781/install.sh

echo "Setting up your environment..."

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install brew and brew packages from Brewfile
if [[ ! $(which brew) ]]; then
    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "Brew is installed"
ln -fs ${BASEDIR}/Brewfile ~/Brewfile
echo "Installing brew packages"

brew update
brew upgrade
brew bundle install

echo "Finished installing brew packages"

# zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi
echo "Oh my zsh is installed"
ln -fs ${BASEDIR}/.zshrc ~/.zshrc

# vim
ln -fs ${BASEDIR}/.vimrc ~/.vimrc
# Install vim-plug for vim.
if [ ! -e ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install scm breeze shortcuts
if [[ ! -f "$HOME/.scm_breeze/scm_breeze.sh" ]]; then
	git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
	~/.scm_breeze/install.sh
fi;

# Setting up tmux
echo "Setting up tmux"
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi;
ln -fs ${BASEDIR}/tmux/.tmux.conf ~/.tmux.conf

# python, setting symlinks
ln -s -f /usr/local/bin/python3 /usr/local/bin/python
ln -s -f /usr/local/bin/pip3 /usr/local/bin/pip
# installing necessary python packages
pip install --upgrade pip
pip install bpython jupyter

# isntalling kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# let's run this bitch
source ~/.zshrc
