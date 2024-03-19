#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"


function git_dirty {
  [[ -z $(git status --porcelain 2>/dev/null) ]] || echo "*"
}

function git_color {
  local git_status="$(git_dirty)"

  if [[ ! -z $git_status ]]; then
    echo -e $COLOR_RED
  else
    echo -e $COLOR_GREEN
  fi
}

function parse_git_branch() {
  ref=$(git symbolic-ref -q HEAD 2> /dev/null) || return
  printf "${1:-(%s)}" "${ref#refs/heads/}"
}

function git_branch_2 {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function git_branch {
  local git_status="$(git status 2>/dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "$branch"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "$commit"
  fi
}

function git_prompt {
    # First, get the branch name...
    local branch="$(git_branch_2)"
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local dirty="$(git_dirty)"
        echo -e "($branch$dirty)"
    fi
}

# original git-prompt
# export PS1=\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$

# PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[36m\]\u@\h \[\033[33m\]\w \[$(git_color)\]$(git_prompt)\[\033[0m\]'$' $ '

PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[33m\]\w \[$(git_color)\]$(git_prompt)\[\033[0m\]'$'$ '
export PS1
