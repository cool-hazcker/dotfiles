### Installation guide :rocket:
* Install OSX command line tools: ```xcode-select --install || true```
* Git clone this repo
* Run ```bash install.sh```
* Run ```zsh setup_zsh.sh```
* Restart your terminal or run ```source ~/.zshrc```

### Machine-specific configuration
The dotfiles support machine-specific configurations that won't be tracked in git:

**Zsh configuration** - Create `~/.zshrc.local` for machine-specific zsh settings:
```bash
# Example ~/.zshrc.local
export WORK_ENV=true
alias work-vpn="sudo openconnect vpn.company.com"
```

**Git configuration** - Create `~/.gitconfig.local` for user credentials:
```bash
# Example ~/.gitconfig.local
[user]
    name = Your Name
    email = your.email@example.com

[credential]
    helper = store
```