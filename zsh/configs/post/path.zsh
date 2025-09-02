# Load homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load asdf
PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Set JAVA_HOME and JDK_HOME
local java_path
java_path="$(asdf which java)"
if [[ -n "${java_path}" ]]; then
  export JAVA_HOME
  JAVA_HOME="$(dirname "$(dirname "${java_path:A}")")"
  export JDK_HOME=${JAVA_HOME}
fi

# Add global npm path
PATH="$(npm config get prefix)/bin:$PATH"

# Add dotfiles bin path
PATH="$HOME/.bin:$PATH"

# Add project bin paths if they are trusted
PATH=".git/safe/../../bin:$PATH"

PATH="/Applications/Postgres.app/Contents/Versions/17/bin:$PATH"

export -U PATH
