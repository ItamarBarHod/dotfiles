#!/bin/bash
# Refresh current tmux session:
# - Window 1: quit nvim, source zshrc, reopen nvim
# - Other windows: source zshrc in zsh panes, skip claude sessions

SESSION=$(tmux display-message -p '#S')

# Refresh window 1 (nvim): quit, source, reopen
tmux send-keys -t "${SESSION}:1.0" Escape
tmux send-keys -t "${SESSION}:1.0" " qq"

# Wait for nvim to exit, then source and reopen (run in background so tmux isn't blocked)
(sleep 1 && tmux send-keys -t "${SESSION}:1.0" "source ~/.zshrc && nvim ." Enter) &

# Refresh zsh panes in other windows (skip window 1, skip non-zsh like claude)
tmux list-panes -s -F '#{window_index}.#{pane_index} #{pane_current_command}' | while read pane cmd; do
  window="${pane%%.*}"
  [ "$window" = "1" ] && continue
  [ "$cmd" = "zsh" ] || continue
  tmux send-keys -t "${SESSION}:${pane}" "source ~/.zshrc" Enter
done
