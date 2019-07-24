with_tunnel () {
  DATABASE_URL=$(tmux capture-pane -t 1 -p | grep postgresql:// | tail -1 | cut -d " " -f 3) $@
}
