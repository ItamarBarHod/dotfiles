#!/usr/bin/env bash
# Switch tmux session via fzf, excluding current session, sorted by last attached

CURRENT="$1"

selected=$(
  tmux list-sessions -F "#{session_last_attached} #{session_name}" \
    | sort -rn \
    | cut -d' ' -f2- \
    | grep -vx "$CURRENT" \
    | fzf --reverse --tiebreak=begin,index
)

if [ -n "$selected" ]; then
  tmux switch-client -t "$selected"
fi
