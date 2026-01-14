#!/usr/bin/env bash

set -e  # Exit immediately if any command fails

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

# git
ln -fs ${BASEDIR}/.gitconfig ~/.gitconfig

# Setting up tmux
echo "Setting up tmux"
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi;
ln -fs ${BASEDIR}/tmux/.tmux.conf ~/.tmux.conf

# VS Code setup
bash ${BASEDIR}/setup_vscode.sh

echo "Installation complete! Please run: zsh setup_zsh.sh"
