# PATH var
path=("/usr/local/bin" $path)
path=("${HOME}/bin" $path)
path=("$HOME/.local/bin" $path)
path=("$HOME/gems/bin" $path)
path=("${GOPATH}/bin" $path)
path=("$HOME/.toolbox/bin" "/opt/homebrew/bin" $path)

export PATH
typeset -U path

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

export LS_COLORS="$(vivid generate nord)"

plugins=(git docker docker-compose zsh-syntax-highlighting fzf-tab)
ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

# Fzf tab styling
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' popup-pad 300 0 fzf-flags  --color=fg:1,fg+:2
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup


# User configuration
export EDITOR='vim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Nord"

# Go
export GOPATH="${HOME}/go"
mkdir -p ${GOPATH} $GOPATH/src $GOPATH/pkg $GOPATH/bin

# Ruby exports
export GEM_HOME=$HOME/gems

# Aliases
alias lh="ls -alh"
alias mkdir="mkdir -p"
alias venv="python -m venv"

alias bi="brew install"
alias bif="brew info"
alias bu="brew update"

alias jqless="jq -C . | less -R"

alias vimfiles='vim -O $(fzf -m --preview="bat --color always {}")'

# git aliases
alias gbrecent="git branch --sort=-committerdate --format='%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:magenta)%(objectname:short)|%(color:blue)%(subject)%(color:reset)' --color=always | column -ts'|'"
alias gashl="git stash list --pretty=format:'%C(yellow)%gd %C(green)%ci %C(blue)(%cr) %C(reset)%s'"


# misc aliases
alias dl="cd ~/Downloads"
alias ~="cd ~"

alias jqless="jq -C . | less -R"

# git aliases
alias gbrecent="git branch --sort=-committerdate --format='%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:magenta)%(objectname:short)|%(color:blue)%(subject)%(color:reset)' --color=always | column -ts'|'"

# fuzzy searching on git branches
# https://polothy.github.io/post/2019-08-19-fzf-git-checkout/
fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo “No branch selected.”
        return
    fi

    # If branch name starts with ‘remotes/’ then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}

fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed “s/.* //”
}

alias gbf="fzf-git-branch"
alias gcof="fzf-git-checkout"

# Functions
function mkd() {
    mkdir -p "$1" && cd "$1"
}

function cr-img() { echo "!["$2"](data:image/png;base64,`base64 -i "$1"`)" }

# fuzzy searching on git branches
# https://polothy.github.io/post/2019-08-19-fzf-git-checkout/
fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}

fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

alias gbf='fzf-git-branch'
alias gcof='fzf-git-checkout'

# export -> install vscode extensions
#code --list-extensions | xargs -L 1 code-insiders --install-extension

# Keybindings
bindkey "\e\e[D" backward-word # jump backward one word
bindkey "\e\e[C" forward-word # jump forward one word

source <(fzf --zsh)

eval "$(zoxide init zsh)"

# Enable aws cli autocompletion
complete -C '/usr/local/bin/aws_completer' aws

# configuring scmpuff and missing git aliases
eval "$(scmpuff init -s)"
alias gl='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias gcm="git commit --amend"
alias gpl="git pull"
alias gasha="git stash apply"
alias gash="git stash"

# activating mise
eval "$(mise activate zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source local config if it exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
