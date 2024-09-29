if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export LANG=de_DE.UTF-8
export LC_CTYPE=de_DE.UTF-8

ulimit -n 64000

export EDITOR=nvim
export VISUAL=nvim

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=10000
setopt INC_APPEND_HISTORY_TIME

#
# === Setup ZINIT ===
#

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Load fzf widgets and bindings (like CTRL-R, CTRL-T, CTRL-I)
source <(fzf --zsh)

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::poetry-env
zinit snippet OMZP::terraform
zinit snippet OMZP::command-not-found

zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

setopt no_auto_remove_slash
setopt auto_cd

autoload -Uz compinit && compinit

zinit cdreplay -q
complete -o nospace -C /opt/homebrew/bin/terraform terraform

#
# === Path extensions ===
#
export PATH=$(go env GOPATH)/bin:$PATH
export PATH=$PATH:/Users/michael.rose/.local/bin # Pipx
export PATH=$PATH:/usr/local/share/dotnet # dotnet

#
# === Configure oh-my-posh ===
#
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.zshomp.toml)"
fi

#
# === Aliases ===
#
alias zshconfig="nvim ~/.zshrc"

# Listing
alias ls='ls --color'
alias ll='ls -la --color'

# Git
alias greset='git reset HEAD --hard'
alias gff='git pull --ff-only'
alias gpu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gcpb='git rev-parse --abbrev-ref HEAD | pbcopy'
alias gs='git status'

function gitrmc() {
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    COMMIT=$(git rev-parse HEAD)
    git checkout -
    git branch -D "$BRANCH"
}
# // Git

alias tunnel-vnc-pi='echo "Tunneling VNC for raspberrypi";ssh pi@raspberrypi -L 50000:localhost:5900 -N'
alias video2gif='~/.cr-scripts/video2gif.sh "$@"'
alias npr='npm run'
alias lg='lazygit'

function fixssh() {
    eval $(tmux show-env -s |grep '^SSH_')
}

# unalias gm

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

aasp ()
{
  profile="${1}"

  if [[ -z "$profile" ]]; then
    echo "Clearing AWS env credentials"
    eval "unset AWS_ACCESS_KEY_ID; unset AWS_SECRET_ACCESS_KEY; unset AWS_SESSION_TOKEN; unset AWS_CREDENTIAL_EXPIRATION"
    return
  fi

  eval "$(aws configure export-credentials --profile $profile --format env)"
}

#
# === NVM Stuff ===
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# === Python Stuff ===
# 
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

#
# === Load local settings ===
#
if [ -f "$HOME/.zsh_local" ]; then
  source "$HOME/.zsh_local"
fi
