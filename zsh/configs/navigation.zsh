# with cdpath enabled, auto_cd gives too many false positives
unsetopt auto_cd

cdpath=(
  $HOME/code \
  $HOME/code/eebs \
  $HOME/code/ynab \
  $HOME
)

_cdpath_directories() {
  modified_in_last_days=${1:-999}
  echo "${CDPATH//:/\n}" | while read dir; do
    find -L "$dir" \
      -not -path '*/\.*' \
      -type d \
      -atime -"$modified_in_last_days" \
      -maxdepth 1
  done
}

_is_a_git_repo() {
  while read dir; do
    if [[ -d "$dir/.git" ]]; then
      basename "$dir"
    fi
  done
}
projects() {
  _cdpath_directories $1 | _is_a_git_repo
}

function chpwd {
  local v; v=$(projections)
  if [[ $? -eq 0 ]]; then
    echo $v > .projections.json
  fi

  ls
}

tm-select-session() {
  project=$(projects | fzf --reverse)
  if [ ! -z "$project" ]; then
    (cd "$project" && tat)
  fi
}
