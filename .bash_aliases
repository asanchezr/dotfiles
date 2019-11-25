
# List directory contents
alias sl=ls
alias la='ls -AF'       # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

alias cls='clear'
alias q='exit'

alias ..='cd ..'         # Go up one directory
alias cd..='cd ..'       # Common misspelling for going up one directory

# Directory
alias md='mkdir -p'
alias rd='rmdir'

# git
alias git-log="git log --graph --pretty=format:'%C(yellow)%h%Creset %C(bold cyan)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# docker-compose
alias dcp="docker-compose"
alias dcp-logs="docker-compose logs -f --tail 100"

# custom internal tools
alias journal='./journal.sh'
alias til='./til.sh'
alias wiki='./wiki.sh'
