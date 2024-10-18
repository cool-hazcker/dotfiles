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
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git docker docker-compose zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR='vim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Nord"

# Go
export GOPATH="${HOME}/go"
mkdir -p ${GOPATH} $GOPATH/src $GOPATH/pkg $GOPATH/bin

# Ruby exports
export GEM_HOME=$HOME/gems

# PATH var
path=("/usr/local/bin" $path)
path=("${HOME}/bin" $path)
path=("$HOME/.local/bin" $path)
path=("$HOME/gems/bin" $path)
path=("${GOPATH}/bin" $path)

export PATH
typeset -U path

# Aliases
alias lh="ls -alh"
alias mkdir="mkdir -p"
alias venv="python -m venv"

alias bi="brew install"
alias bif="brew info"
alias bu="brew update"

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

function acvenv() {
    local env=$1
    if [[ ! -d "$env" ]]; then
      echo "No venv '$env' foud"
      return 1
    fi  
    echo "Activating environment $env"
    source "$env/bin/activate"
}

# export -> install vscode extensions
#code --list-extensions | xargs -L 1 code-insiders --install-extension

# Keybindings
bindkey "\e\e[D" backward-word # jump backward one word
bindkey "\e\e[C" forward-word # jump forward one word
bindkey "ç" fzf-cd-widget # for fzf dir search

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
