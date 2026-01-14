#!/usr/bin/env zsh

echo "Setting up zsh specific environment..."

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install p10k theme
if [[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Link p10k configuration
ln -fs ${BASEDIR}/.p10k.zsh ~/.p10k.zsh
echo "Powerlevel10k configuration linked"

# Install fzf-tab plugin
if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab ]]; then
    echo "Installing fzf-tab plugin..."
    git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
fi

# Install zsh-syntax-highlighting plugin
if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
    echo "Installing zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

terminal-notifier -title 'Lets go bruh🚀' -message 'Your environment is ready!' -sound Ping

echo "Zsh setup complete! Please restart your terminal or run: source ~/.zshrc"