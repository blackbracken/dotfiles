#!/usr/bin/env bash
# Claude Code Statusline - single line

set -euo pipefail

CACHE_FILE="/tmp/claude-statusline-ratelimit"

input=$(cat)

# ── Colors ──
BLUE="\033[38;5;75m"
TEAL="\033[38;5;114m"
AMBER="\033[38;5;222m"
CORAL="\033[38;5;204m"
MID="\033[38;5;245m"
SEP_COLOR="\033[38;5;238m"
RESET="\033[0m"

color_for_pct() {
  local pct=${1%%.*}
  if (( pct >= 80 )); then
    printf '%s' "$CORAL"
  elif (( pct >= 50 )); then
    printf '%s' "$AMBER"
  else
    printf '%s' "$TEAL"
  fi
}

fmt_tokens() {
  local n=$1
  if (( n >= 1000000 )); then
    printf '%.1fM' "$(echo "scale=1; $n / 1000000" | bc)"
  elif (( n >= 1000 )); then
    printf '%.0fk' "$(echo "scale=0; $n / 1000" | bc)"
  else
    printf '%d' "$n"
  fi
}

# ── Extract fields ──
model=$(echo "$input" | jq -r '.model.display_name // "?"')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
input_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
output_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

ctx_int=0
if [ -n "$used_pct" ]; then
  printf -v ctx_int "%.0f" "$used_pct" 2>/dev/null || ctx_int="${used_pct%%.*}"
fi

sep="${SEP_COLOR} | ${RESET}"

# ── Build line ──
line="${BLUE}${model}${RESET}"

ctx_color=$(color_for_pct "$ctx_int")
line+="${sep}${MID}[Ctx]${RESET} ${ctx_color}${ctx_int}%${RESET}"

up=$(fmt_tokens "$input_tokens")
down=$(fmt_tokens "$output_tokens")
line+="${sep}${MID}↑${up} ↓${down}${RESET}"

# ── Rate limits (from input JSON) ──
rl_json=$(echo "$input" | jq -r '.rate_limits // empty' 2>/dev/null)

if [ -n "$rl_json" ] && [ "$rl_json" != "null" ]; then
  echo "$rl_json" > "$CACHE_FILE"
elif [ -f "$CACHE_FILE" ]; then
  rl_json=$(cat "$CACHE_FILE")
fi

five_pct=$(echo "$rl_json" | jq -r '.five_hour.used_percentage // empty' 2>/dev/null)
five_reset=$(echo "$rl_json" | jq -r '.five_hour.resets_at // empty' 2>/dev/null)
seven_pct=$(echo "$rl_json" | jq -r '.seven_day.used_percentage // empty' 2>/dev/null)

if [ -n "$five_pct" ]; then
  five_int="${five_pct%%.*}"
  five_color=$(color_for_pct "$five_int")
  line+="${sep}${MID}[5h]${RESET} ${five_color}${five_int}%${RESET}"
  if [ -n "$five_reset" ]; then
    reset_str=$(LC_ALL=en_US.UTF-8 TZ="Asia/Tokyo" date -r "$five_reset" +"%-l%p" 2>/dev/null | sed 's/AM/am/;s/PM/pm/')
    if [ -n "$reset_str" ]; then
      line+=" ${MID}(resets ${reset_str})${RESET}"
    fi
  fi
fi

if [ -n "$seven_pct" ]; then
  seven_int="${seven_pct%%.*}"
  seven_color=$(color_for_pct "$seven_int")
  line+="${sep}${MID}[7d]${RESET} ${seven_color}${seven_int}%${RESET}"
fi

printf '%b' "$line"
