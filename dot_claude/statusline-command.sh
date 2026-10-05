#!/bin/sh
# Claude Code status line: model, effort, context usage, cost, elapsed time.
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')
used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
max_tokens=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')

dim() { printf '\033[2m%s\033[0m' "$1"; }

fmt_tokens() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000000) printf "%.1fM", n/1000000;
    else if (n >= 1000) printf "%dK", int(n/1000 + 0.5);
    else printf "%d", n;
  }'
}

out=""
add() {
  if [ -n "$out" ]; then
    out="$out $(dim '|') $1"
  else
    out="$1"
  fi
}

[ -n "$model" ] && add "$(dim "$model")"
[ -n "$effort" ] && add "$(dim "effort:$effort")"

if [ -n "$max_tokens" ] && [ "$max_tokens" != "0" ]; then
  used_display=$(fmt_tokens "${used_tokens:-0}")
  max_display=$(fmt_tokens "$max_tokens")
  if [ -n "$used_pct" ]; then
    pct_display=$(printf '%.0f' "$used_pct")
    add "$(dim "ctx:${used_display}/${max_display} (${pct_display}%)")"
  else
    add "$(dim "ctx:${used_display}/${max_display}")"
  fi
fi

if [ -n "$cost" ]; then
  cost_display=$(printf '%.4f' "$cost")
  add "$(dim "\$${cost_display}")"
fi

if [ -n "$duration_ms" ]; then
  secs=$(( duration_ms / 1000 ))
  h=$(( secs / 3600 ))
  m=$(( (secs % 3600) / 60 ))
  s=$(( secs % 60 ))
  if [ "$h" -gt 0 ]; then
    elapsed=$(printf '%dh%02dm%02ds' "$h" "$m" "$s")
  elif [ "$m" -gt 0 ]; then
    elapsed=$(printf '%dm%02ds' "$m" "$s")
  else
    elapsed=$(printf '%ds' "$s")
  fi
  add "$(dim "$elapsed")"
fi

printf '%s\n' "$out"
