#!/bin/bash
# bash-git-prompt installer

CONFIG_FILE=.bash_profile

function install() {
    echo -e "\n" >> "$HOME/$CONFIG_FILE"
    echo -e "[ -f ~/.dotfiles/.bash_aliases ] && source ~/.dotfiles/.bash_aliases" >> "$HOME/$CONFIG_FILE"
    echo -e "[ -f ~/.dotfiles/docker_aliases.sh ] && source ~/.dotfiles/docker_aliases.sh" >> "$HOME/$CONFIG_FILE"
    echo -e "[ -f ~/.dotfiles/git-prompt.sh ] && source ~/.dotfiles/git-prompt.sh" >> "$HOME/$CONFIG_FILE"
}

install

echo ""
echo -e "\033[0;32mInstallation finished successfully! Enjoy dotfiles!\033[0m"
echo -e "\033[0;32mTo start using it, open a new tab or 'source "$HOME/$CONFIG_FILE"'.\033[0m"
