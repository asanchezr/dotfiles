# bash-git-prompt
A bash prompt that displays information about the current git repository



## Installation

1. Clone this repository to your home directory.

```sh
git clone --depth=1 https://github.com/asanchezr/bash-git-prompt.git ~/.bash-git-prompt
```

2.  Add to your `~/.bashrc`:

```sh
if [ -f ~/.bash-git-prompt/git-prompt.sh ]; then
    source ~/.bash-git-prompt/git-prompt.sh
fi
```

3. Restart your shell
