# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.jenv/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH
eval "$(jenv init -)"
export JAVA_HOME="$(dirname $(dirname $(jenv which java)))"

# Path to your oh-my-zsh installation.
export ZSH=/Users/rosem/.oh-my-zsh

# Java Path
# export JAVA_HOME=`/usr/libexec/java_home`

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="custom-dracula"

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
plugins=(git osx vi-mode docker gradle)
 
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=de_DE.UTF-8
export LC_CTYPE=de_DE.UTF-8

export EDITOR=vim
export VISUAL=vim
alias vimrc="vim ~/.vimrc"
alias zshconfig="vim ~/.zshrc"

zstyle ':completion:*' special-dirs true

# Git Aliases
alias greset='git reset HEAD --hard'
alias gff='git pull --ff-only'
alias gpu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gcpb='git rev-parse --abbrev-ref HEAD | pbcopy'

function gitrmc() {
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    COMMIT=$(git rev-parse HEAD)
    git checkout -
    git branch -D "$BRANCH"
}

# custom aliases
alias tunnel-vnc-pi='echo "Tunneling VNC for raspberrypi";ssh pi@raspberrypi -L 50000:localhost:5900 -N';
alias serve='python ~/.cr-scripts/serve.py "$@"';
alias video2gif='~/.cr-scripts/video2gif.sh "$@"';
alias foam='$(cd ~/Software/private/foam-workspace; code .)';

# collaboration Factory aliases
export CFUSER="mrose"
function sshc() {
	cluster=$1
	if [ -z $cluster ]; then
		echo "Usage: sshc <cluster-number>"
	fi
	server="cplace-cluster$cluster.collaboration-factory.de"
	echo "Connecting to $server..."
	ssh -o SendEnv=CFUSER root@$server
}

function mkpatch() {
    folder=$1
    file=$2
    if [ ! -d "$folder" ]; then
        echo "Usage: mkpatch <directory> [patchfile]"
        return 1
    fi
    if [ -z "$file" ]; then
        file="patch.zip"
    fi
    echo -n "... removing .DS_Store files"
    find "$folder" -name ".DS_Store" -exec rm {} \;
    echo " done."
    zip -r "$file" "$folder"
    echo "Patch written to: $file"
}

alias cdocs='docker run --rm -it -v "`pwd`":/src/content/testing-repo -p 1313:1313 -u hugo docs:latest server --environment devtesting -w --bind=0.0.0.0'

unalias gm

# Include all "tool" aliases
if [ -f "~/Software/tools/aliases.sh" ]; then
    source ~/Software/tools/aliases.sh
fi

