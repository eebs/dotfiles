# Short explaination of options:
# https://github.com/mattjj/my-oh-my-zsh/blob/b1d4bab329456e9a4af49237064d9a3b6566f1b0/history.zsh

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

export ERL_AFLAGS="-kernel shell_history enabled"
