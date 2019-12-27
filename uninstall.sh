#!/bin/bash
# bash-git-prompt uninstaller

function uninstall() {
    grep -v -F "[ -f ~/.bash-git-prompt/.bash_aliases ] && source ~/.bash-git-prompt/.bash_aliases" ~/.bash_profile > temp; mv temp ~/.bash_profile
    grep -v -F "[ -f ~/.bash-git-prompt/docker_aliases.sh ] && source ~/.bash-git-prompt/docker_aliases.sh" ~/.bash_profile > temp; mv temp ~/.bash_profile
    grep -v -F "[ -f ~/.bash-git-prompt/git-prompt.sh ] && source ~/.bash-git-prompt/git-prompt.sh" ~/.bash_profile > temp; mv temp ~/.bash_profile
}

uninstall

echo ""
echo -e "\033[0;32mUninstallation finished successfully! Sorry to see you go!\033[0m"
echo ""
echo "Final steps to complete the uninstallation:"
echo "  -> Remove the bash-git-prompt folder"
echo "  -> Open a new shell/tab/terminal"