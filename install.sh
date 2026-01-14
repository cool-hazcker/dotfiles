#!/usr/bin/env bash

set -e  # Exit immediately if any command fails

# good reference https://github.com/maxjkfc/mac-setting/blob/505ea65efd8ffd27c031a459c221d91429827781/install.sh

echo "==> Setting up your environment..."

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install brew and brew packages from Brewfile
if [[ ! $(which brew) ]]; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "==> Homebrew is installed"
ln -fs ${BASEDIR}/Brewfile ~/Brewfile
echo "==> Installing Homebrew packages..."

brew update
brew upgrade
brew bundle install

# Install macOS-specific casks
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "==> Installing macOS applications..."
    brew bundle install --file=${BASEDIR}/Brewfile.macos
fi

echo "==> Finished installing Homebrew packages"

# zsh
echo "==> Setting up zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi
echo "==> Oh My Zsh is installed"
ln -fs ${BASEDIR}/.zshrc ~/.zshrc

# vim
echo "==> Setting up vim..."
ln -fs ${BASEDIR}/.vimrc ~/.vimrc
# Install vim-plug for vim.
if [ ! -e ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# git
echo "==> Setting up git..."
ln -fs ${BASEDIR}/.gitconfig ~/.gitconfig

# Setting up tmux
echo "==> Setting up tmux..."
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi;
ln -fs ${BASEDIR}/tmux/.tmux.conf ~/.tmux.conf

# VS Code setup
echo "==> Setting up VS Code..."
bash ${BASEDIR}/setup_vscode.sh

echo "==> Installation complete! Please run: zsh setup_zsh.sh"
