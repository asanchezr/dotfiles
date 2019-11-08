#!/bin/bash
# bash-git-prompt installer

CONFIG_FILE=.bashrc

function install() {
    echo -e "\n[ -f ~/.bash-git-prompt/.bash_aliases ] && source ~/.bash-git-prompt/.bash_aliases" >> "$HOME/$CONFIG_FILE"
    echo -e "[ -f ~/.bash-git-prompt/git-prompt.sh ] && source ~/.bash-git-prompt/git-prompt.sh" >> "$HOME/$CONFIG_FILE"
}

install

echo ""
echo -e "\033[0;32mInstallation finished successfully! Enjoy bash-git-prompt!\033[0m"
echo -e "\033[0;32mTo start using it, open a new tab or 'source "$HOME/$CONFIG_FILE"'.\033[0m"
