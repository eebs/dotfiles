# Load homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load asdf
source $(brew --prefix asdf)/asdf.sh

# Add dotfiles bin path
PATH="$HOME/.bin:$PATH"

# Add project bin paths if they are trusted
PATH=".git/safe/../../bin:$PATH"

export -U PATH
