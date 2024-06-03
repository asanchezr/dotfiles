#!/bin/bash
# bash-git-prompt uninstaller

function uninstall() {
    grep -v -F "[ -f ~/.dotfiles/.bash_aliases ] && source ~/.dotfiles/.bash_aliases" ~/.bash_profile > temp; mv temp ~/.bash_profile
    grep -v -F "[ -f ~/.dotfiles/docker_aliases.sh ] && source ~/.dotfiles/docker_aliases.sh" ~/.bash_profile > temp; mv temp ~/.bash_profile
    grep -v -F "[ -f ~/.dotfiles/git-prompt.sh ] && source ~/.dotfiles/git-prompt.sh" ~/.bash_profile > temp; mv temp ~/.bash_profile
}

uninstall

echo ""
echo -e "\033[0;32mUninstallation finished successfully! Sorry to see you go!\033[0m"
echo ""
echo "Final steps to complete the uninstallation:"
echo "  -> Remove the .dotfiles folder"
echo "  -> Open a new shell/tab/terminal"
