local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"
local NEWLINE=$'\n'

PROMPT='%{$fg[grey]%}$(date +"%H:%M:%S") ${ret_status}\$  %n %{$fg_bold[green]%}%p %{$fg_bold[blue]%}%~ $(git_prompt_info)% ${NEWLINE}${ret_status}➜  %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_CLEAN=") %{$fg_bold[green]%}✔ "
ZSH_THEME_GIT_PROMPT_DIRTY=") %{$fg_bold[yellow]%}✘ "
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
