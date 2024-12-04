#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -al --color=auto'
alias vi='vim'
alias vim='nvim'

# fzf
export FZF_DEFAULT_OPTS='--extended --height 40% --reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_COMPLETION_TRIGGER=','

function fzf_ghq() {
  local project_name=$(ghq list | sort | $(__fzfcmd))
  if [ -n "$project_name" ]; then
    local project_full_path=$(ghq root)/$project_name
    local project_relative_path="~/$(realpath --relative-to=$HOME $project_full_path)"
    READLINE_LINE="cd $project_relative_path"
    READLINE_POINT=${#READLINE_LINE}
  fi
}
bind -x '"\C-g": fzf_ghq'

function git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="[\u@\h \W] \$(git_branch) \$ "

# use ctrl-z to toggle in and out of bg
# https://schulz.dk/2022/01/26/using-ctrl-z-to-toggle-process-in-fg-bg/
if [[ $- == *i* ]]; then 
  stty susp undef
  bind '"\C-z":" fg\015"'
fi

#####################################
# source other files
#####################################

# rust
. "$HOME/.cargo/env"

# fzf-completions
. /usr/share/fzf/key-bindings.bash
. /usr/share/fzf/completion.bash

# gh
# eval "$(gh completion -s bash)"

# mise
eval "$(~/.local/bin/mise activate bash)"
