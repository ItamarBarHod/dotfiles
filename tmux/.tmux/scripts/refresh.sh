#!/bin/bash
# Refresh all tmux sessions:
# - Window 1 of each session: quit nvim, source zshrc, reopen nvim
# - Claude panes: exit claude, source zshrc, resume session with `claude -c`
# - Other zsh panes: source zshrc

for SESSION in $(tmux list-sessions -F '#{session_name}'); do
  # Refresh window 1 (nvim): quit, source, reopen
  tmux send-keys -t "${SESSION}:1.0" Escape
  tmux send-keys -t "${SESSION}:1.0" " qq"
  (sleep 1 && tmux send-keys -t "${SESSION}:1.0" "source ~/.zshrc && nvim ." Enter) &

  # Refresh other panes
  tmux list-panes -t "$SESSION" -s -F '#{window_index}.#{pane_index} #{pane_current_command}' | while read pane cmd; do
    window="${pane%%.*}"
    [ "$window" = "1" ] && continue

    if [ "$cmd" = "zsh" ]; then
      tmux send-keys -t "${SESSION}:${pane}" "source ~/.zshrc && clear" Enter
    else
      # Assume claude (version number like 2.1.112). Exit, source, resume.
      tmux send-keys -t "${SESSION}:${pane}" "/exit" Enter
      (sleep 1 && tmux send-keys -t "${SESSION}:${pane}" "source ~/.zshrc && clear && claude -c" Enter) &
    fi
  done
done
