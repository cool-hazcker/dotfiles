#!/usr/bin/env zsh

echo "Setting up zsh specific environment..."

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install p10k
# https://github.com/romkatv/powerlevel10k
if [[ -f ~/.p10k.zsh ]]; then
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    source ~/.p10k.zsh
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme	
fi;

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

terminal-notifier -title 'Lets go bruh🚀' -message 'Your environment is ready!' -sound Ping;

# let's run this bitch
source ~/.zshrc