# Load homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load asdf
source $(brew --prefix asdf)/libexec/asdf.sh

# Add global npm path
PATH="$(npm config get prefix)/bin:$PATH"

# Add dotfiles bin path
PATH="$HOME/.bin:$PATH"

# Add project bin paths if they are trusted
PATH=".git/safe/../../bin:$PATH"

PATH="/Applications/Postgres.app/Contents/Versions/16/bin:$PATH"

export -U PATH
