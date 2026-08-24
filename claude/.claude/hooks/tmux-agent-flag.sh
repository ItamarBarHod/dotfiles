#!/usr/bin/env bash
[ -n "${TMUX:-}" ] || exit 0
pane="${TMUX_PANE:-}"
[ -n "$pane" ] || exit 0
state="${1:-}"
case "$state" in
  ready) tmux set-option -w -t "$pane" @agent_wait ready 2>/dev/null ;;
  input) tmux set-option -w -t "$pane" @agent_wait input 2>/dev/null ;;
  clear) tmux set-option -uw -t "$pane" @agent_wait 2>/dev/null ;;
esac
tmux refresh-client -S 2>/dev/null

if { [ "$state" = "ready" ] || [ "$state" = "input" ]; } && command -v osascript >/dev/null 2>&1; then
  info=$(tmux display-message -p -t "$pane" '#{window_active} #{session_attached} #{session_name} #{window_index} #{window_name}' 2>/dev/null)
  read -r wactive sattached sname widx wname <<<"$info"
  if ! { [ "$wactive" = "1" ] && [ "${sattached:-0}" -ge 1 ]; }; then
    [ "$state" = "ready" ] && label="ready" || label="needs input"
    osascript -e "display notification \"${sname}:${widx} ${wname}\" with title \"Agent ${label}\"" >/dev/null 2>&1
  fi
fi
exit 0
