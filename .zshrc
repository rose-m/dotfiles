# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.jenv/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH
export PATH=~/.mongodb/versions/mongodb-current/bin:$PATH

#eval "$(jenv init -)"
#export JAVA_HOME="$(dirname $(dirname $(jenv which java)))"

# Path to your oh-my-zsh installation.
export ZSH=/Users/michael.rose/.oh-my-zsh

# Java Path
# export JAVA_HOME=`/usr/libexec/java_home`

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="custom-dracula"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="false"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git macos vi-mode docker aws kubectl zsh-syntax-highlighting zsh-autosuggestions)
 
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=de_DE.UTF-8
export LC_CTYPE=de_DE.UTF-8

ulimit -n 64000

export EDITOR=vim
export VISUAL=vim
alias vimrc="vim ~/.vimrc"
alias zshconfig="vim ~/.zshrc"
alias python3="python3.9"

zstyle ':completion:*' special-dirs true

# Git Aliases
alias greset='git reset HEAD --hard'
alias gff='git pull --ff-only'
alias gpu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gcpb='git rev-parse --abbrev-ref HEAD | pbcopy'
alias gs='git status'
alias phypercon='export PATH="/Users/michael.rose/Software/squ/hypercon-platform/node_modules/.bin:$PATH" && nvm use 14'

function gitrmc() {
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    COMMIT=$(git rev-parse HEAD)
    git checkout -
    git branch -D "$BRANCH"
}

# custom aliases
alias tunnel-vnc-pi='echo "Tunneling VNC for raspberrypi";ssh pi@raspberrypi -L 50000:localhost:5900 -N'
alias video2gif='~/.cr-scripts/video2gif.sh "$@"'
alias npr='npm run'

# Bazel aliases
alias bzlg='bazel run //:gazelle'

function fixssh() {
    eval $(tmux show-env -s |grep '^SSH_')
}

unalias gm

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

# Include all "tool" aliases
if [[ -f ~/Software/tools/aliases.sh ]]; then
    source ~/Software/tools/aliases.sh
fi

# NVM Stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python Stuff
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# GO Stuff
export GOPRIVATE="github.com/cresta/*"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Created by `pipx` on 2021-10-04 14:46:16
export PATH="$PATH:/Users/michael.rose/.local/bin"
