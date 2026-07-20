# Postgres.app
PATH="/Applications/Postgres.app/Contents/Versions/19/bin:$PATH"

# Add dotfiles before everything else
PATH="$HOME/.bin:$HOME/.local/bin:$PATH"

# Add project bin paths if they are trusted
PATH=".git/safe/../../bin:$PATH"

export -U PATH

# Load homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load Mise
eval "$(/opt/homebrew/bin/mise activate zsh)"
