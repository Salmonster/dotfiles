export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export GOPATH=$HOME/Library/go
export PATH="/usr/local/Cellar/python@2/2.7.17_1/bin:$GOPATH/bin:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1
export GO111MODULE=on
export GOPRIVATE="github.com/mailgun"
export ETCD3_ENDPOINT=localhost:2379
export EVENTBUS_ENDPOINT=localhost:19091
export MG_ENV=dev

# Path to your oh-my-zsh installation.
export ZSH=/Users/$USER/.oh-my-zsh

export NVM_DIR="$HOME/.nvm"
function setup_nvm {
    . $NVM_DIR/nvm.sh
}
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set name of the theme to load. Optionally, if you set this to "random"
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# Custom theme set by link.sh from dotfiles
ZSH_THEME="salman"

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
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Vi mode
bindkey -v
# Map alternate escape key from insert to command mode
bindkey jk vi-cmd-mode
# Keep emacs behavior of 'escape' + '.' recalling last argument from previous shell command
# '^[' (escape) can alternatively be written as '\e.'
bindkey -M viins '^[.' insert-last-word

bindkey '^h' backward-delete-char
bindkey '^d' forward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^p' up-history
bindkey '^n' down-history

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Kill the lag. This can result in issues with other terminal commands that depended on this delay. If you have issues try raising the delay.
export KEYTIMEOUT=10

# Personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes.
alias ls='ls -GFh'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias cds='cd ~/projects/support-service; . ../venv/bin/activate'
alias vnv='. .env/bin/activate'
# Cockpit has a .env file, so use env
alias ckp='. env/bin/activate'
alias swapdir='cd ~/.local/share/nvim/swap/'
# To use the system Python of OSX (v2.7), use `python2`
# alias python='python3'
# alias pip='pip3'
alias rm-pyc='find . -name "*.pyc" -exec rm -rf {} \;'

# kill a zombie running on a socket
#   usage  => `killport 3000`
function killport { kill $(lsof -i :$@ | tail -n 1 | cut -f 3 -d ' '); }
