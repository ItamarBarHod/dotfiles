# claude

Claude Code hook scripts, stow-managed into `~/.claude/`. Run `stow claude` from the repo root.

`settings.json` is intentionally **not** tracked here — it is machine-local and rewrites itself every session (OTEL resource timestamp). Only stable hook scripts live in this package; the wiring that calls them is documented below.

## tmux-agent-flag.sh

Sets or clears the tmux `@agent_wait` window option so the status bar, window list, and session switcher show which agents are waiting on you. Pairs with the `tmux` package (`agent-status-widget.sh`, `session-switch.sh`, `.tmux.conf`).

States: `ready` (green dot, on `Stop`), `input` (yellow dot, on `Notification`), `clear` (on `UserPromptSubmit`).

Wire it in `~/.claude/settings.json` under `hooks`:

```json
"Notification": [
  { "hooks": [ { "type": "command", "command": "bash ~/.claude/hooks/tmux-agent-flag.sh input" } ] }
],
"Stop": [
  { "hooks": [ { "type": "command", "command": "bash ~/.claude/hooks/tmux-agent-flag.sh ready" } ] }
],
"UserPromptSubmit": [
  { "hooks": [ { "type": "command", "command": "bash ~/.claude/hooks/tmux-agent-flag.sh clear" } ] }
]
```
