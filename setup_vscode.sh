#!/usr/bin/env bash

echo "Setting up VS Code environment..."

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install VS Code if not present
if [[ ! $(which code) ]]; then
    echo "Installing VS Code via brew"
    brew install --cask visual-studio-code
fi

# Wait for VS Code to be available
echo "Waiting for VS Code to be available..."
sleep 2

# Install VS Code extensions
if [[ -f "${BASEDIR}/vscode/extensions" ]]; then
    echo "Installing VS Code extensions"
    while read extension; do
        echo "Installing $extension"
        code --install-extension $extension
    done < "${BASEDIR}/vscode/extensions"
fi

# Link VS Code settings
echo "Linking VS Code settings"
mkdir -p ~/Library/Application\ Support/Code/User
ln -fs ${BASEDIR}/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -fs ${BASEDIR}/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

terminal-notifier -title 'VS Code Setup Complete 🚀' -message 'VS Code and extensions are ready!' -sound Ping

echo "VS Code setup complete!"
