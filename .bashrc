export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export GOPATH=$HOME/Library/go
export PATH="/usr/local/Cellar/python@2/2.7.17_1/bin:$GOPATH/bin:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1
export GO111MODULE=on
export GOPRIVATE="github.com/mailgun"
export ETCD3_ENDPOINT=localhost:2379
export EVENTBUS_ENDPOINT=localhost:19091
export MG_ENV=dev
export BASH_SILENCE_DEPRECATION_WARNING=1

export NVM_DIR="$HOME/.nvm"
function setup_nvm {
    . $NVM_DIR/nvm.sh
}
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Checks if the file .ssh-agent-environment exists in home dir and sources it to set the appropriate environment variables.
# See related alias below.
[[ -s ~/.ssh-agent-environment ]] && . ~/.ssh-agent-environment &>/dev/null

# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
. ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1
# cf. https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
PROMPT_COMMAND='__git_ps1 "[\[\e[34m\]\d \t\[\e[m\] : \[\e[35m\]\w\[\e[m\]]" "\n$ "'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# format 'history' command output
export HISTTIMEFORMAT="%m/%d/%y %T "

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Vi mode
#  - vim prompt not available till Bash 4.3 or later versions
#    of GNU Readline
#  - no visual mode
#  - nice emacs keybindings are lost, requires bindkey changes
# set -o vi

alias ls='ls -GFh'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias vnv='source .env/bin/activate'
alias gomg='cd $GOPATH/src/github.com/mailgun/'
alias prj='cd ~/projects/'
# Cockpit has a .env file, so use env
alias ckp='. env/bin/activate'
alias swapdir='cd ~/.local/share/nvim/swap/'
# To use the system Python of OSX (v2.7), use `python2`
# alias python='python3'
# alias pip='pip3'
alias rm-pyc='find . -name "*.pyc" -exec rm -rf {} \;'
# https://vlaams-supercomputing-centrum-vscdocumentation.readthedocs-hosted.com/en/latest/access/using_ssh_agent.html
alias start-ssh-agent='/usr/bin/ssh-agent -s > ~/.ssh-agent-environment; . ~/.ssh-agent-environment'

# kill a zombie running on a socket
#   usage  => `killport 3000`
function killport { kill $(lsof -i :$@ | tail -n 1 | cut -f 3 -d ' '); }
