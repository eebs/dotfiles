# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# Load asdf
. "$HOME/.asdf/asdf.sh"

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../node_modules/.bin:$PATH"
PATH=".git/safe/../../bin:$PATH"

export -U PATH
