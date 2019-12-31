# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Make utilities available
PATH="$DOTFILES_DIR/bin:$PATH"

if is-macos; then
  OS_DIR="macos"
else
  OS_DIR="win"
fi

# Load the shell dotfiles, and then some (order matters):
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in "$DOTFILES_DIR/$OS_DIR"/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
