export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin
export GOPATH=$HOME/Library/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.yarn/bin"

# Homebrew settings
export HOMEBREW_NO_AUTO_UPDATE=1
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv (installed with brew so this section must come after Homebrew settings)
# cf. https://github.com/pyenv/pyenv & https://github.com/pyenv/pyenv-virtualenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# THESE EVALS MUST USE DOUBLE-QUOTES
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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
# This loads nvm bash_completion.
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Checks if the file .ssh-agent-environment exists in home dir and sources it to set the appropriate environment variables.
# See related alias below.
[[ -s ~/.ssh-agent-environment ]] && . ~/.ssh-agent-environment &>/dev/null

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

DISABLE_AUTO_UPDATE="true"
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

# Personal aliases overriding those provided by oh-my-zsh libs, plugins, and themes.
alias ls='ls -GFh'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# python2 virtual envs
alias venv='pyenv activate ${PWD##*/}'
alias dvenv='source deactivate'

# python3 local dir venv
alias vnv='. .env/bin/activate'
alias dvnv='deactivate'

alias gomg='cd $GOPATH/src/github.com/mailgun/'
alias prj='cd ~/projects/'
alias swapdir='cd ~/.local/share/nvim/swap/'
alias rm-pyc='find . -name "*.pyc" -exec rm -rf {} \;'
# https://vlaams-supercomputing-centrum-vscdocumentation.readthedocs-hosted.com/en/latest/access/using_ssh_agent.html
alias start-ssh-agent='/usr/bin/ssh-agent -s > ~/.ssh-agent-environment; . ~/.ssh-agent-environment'
