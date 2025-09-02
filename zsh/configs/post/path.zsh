# Load homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load asdf
PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Add global npm path
PATH="$(npm config get prefix)/bin:$PATH"

# Add dotfiles bin path
PATH="$HOME/.bin:$PATH"

# Add project bin paths if they are trusted
PATH=".git/safe/../../bin:$PATH"

PATH="/Applications/Postgres.app/Contents/Versions/17/bin:$PATH"

export -U PATH
