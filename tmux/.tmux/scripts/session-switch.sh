#!/usr/bin/env bash
# Switch tmux session via fzf, excluding current session, sorted by last attached

CURRENT="$1"

selected=$(
  tmux list-sessions -F "#{session_last_attached} #{session_name}" \
    | sort -rn \
    | cut -d' ' -f2- \
    | grep -vx "$CURRENT" \
    | while IFS= read -r s; do
        if tmux list-windows -t "$s" -F '#{@agent_wait}' 2>/dev/null | grep -q .; then
          printf '● %s\n' "$s"
        else
          printf '  %s\n' "$s"
        fi
      done \
    | fzf --reverse --tiebreak=begin,index \
    | sed 's/^[● ]*//'
)

if [ -n "$selected" ]; then
  tmux switch-client -t "$selected"
fi
