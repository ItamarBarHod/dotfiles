#!/usr/bin/env bash
cur="${1:-}"
seen=""
ready=""
input=""
while IFS='|' read -r sess val; do
  [ "$sess" = "$cur" ] && continue
  case "$val" in ready|input) ;; *) continue ;; esac
  key="${val}:${sess}"
  case " $seen " in *" $key "*) continue ;; esac
  seen="$seen $key"
  if [ "$val" = ready ]; then
    ready="${ready}#[fg=#9ece6a]●#[default]  ${sess}   "
  else
    input="${input}#[fg=#e0af68]●#[default]  ${sess}   "
  fi
done < <(tmux list-windows -a -F '#{session_name}|#{@agent_wait}' 2>/dev/null)
out="${ready}${input}"
[ -n "$out" ] && printf '%s' "$out"
