PROMPT=$'[%{$fg[blue]%}%D{%a %b %d} %* %{$reset_color%}: %{$fg[magenta]%}%~%{$reset_color%}] $(git_prompt_info)\
$ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
