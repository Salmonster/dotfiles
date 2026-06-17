#!/bin/sh
# Claude Code status line.
# Shows: model | context-window usage (real tokens + %) | plan rate-limit usage (5h / 7d %).
#
# NOTE: Claude Code exposes plan/usage-policy consumption ONLY as a percentage
# (rate_limits.*.used_percentage). Absolute "granted vs. used" token counts for the
# plan windows are NOT available to the status line, so those are shown as % only.
# Real token numbers are available only for the per-session context window.

input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // "?"')

# --- Current working directory (basename only, to keep it compact). ---
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // empty')
dir=$(basename "$cwd" 2>/dev/null)

# --- Context window (per-session). Default pct to 0 so it never vanishes early in a session. ---
ctx_pct=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // 0')
ctx_used=$(printf '%s' "$input" | jq -r '.context_window.total_input_tokens // empty')
ctx_max=$(printf '%s' "$input" | jq -r '.context_window.context_window_size // empty')

# --- Plan rate-limit usage (Claude.ai Pro/Max only; absent before first API response). ---
rl5=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
rl7=$(printf '%s' "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Human-readable token count: 15500 -> 15.5k, 200000 -> 200k
hk() {
    awk -v n="$1" 'BEGIN{
        if (n >= 1000) { v = n/1000; if (v == int(v)) printf "%dk", v; else printf "%.1fk", v }
        else printf "%d", n
    }'
}

# ANSI color for a percentage: cyan < 70, yellow 70-90, red >= 90.
pct_color() {
    awk -v p="$1" 'BEGIN{
        if (p >= 90) printf "\033[0;31m";
        else if (p >= 70) printf "\033[0;33m";
        else printf "\033[0;36m"
    }'
}

# Materialize real ESC bytes so they render correctly when passed via %s.
ESC=$(printf '\033')
DIM="${ESC}[2m"
RST="${ESC}[0m"

out=$(printf '%s%s%s' "$DIM" "$model" "$RST")

# Directory segment, e.g.  📁 theater
if [ -n "$dir" ]; then
    out=$(printf '%s %s📁 %s%s' "$out" "$DIM" "$dir" "$RST")
fi

# Context segment, e.g.  ctx:8% (15.5k/200k)
ctx_col=$(pct_color "$ctx_pct")
if [ -n "$ctx_used" ] && [ -n "$ctx_max" ]; then
    ctx_seg=$(printf 'ctx:%.0f%% (%s/%s)' "$ctx_pct" "$(hk "$ctx_used")" "$(hk "$ctx_max")")
else
    ctx_seg=$(printf 'ctx:%.0f%%' "$ctx_pct")
fi
out=$(printf '%s %s%s%s' "$out" "$ctx_col" "$ctx_seg" "$RST")

# Plan segment, e.g.  plan 5h:24% 7d:41%
if [ -n "$rl5" ] || [ -n "$rl7" ]; then
    out=$(printf '%s %splan%s' "$out" "$DIM" "$RST")
    if [ -n "$rl5" ]; then
        out=$(printf '%s %s5h:%.0f%%%s' "$out" "$(pct_color "$rl5")" "$rl5" "$RST")
    fi
    if [ -n "$rl7" ]; then
        out=$(printf '%s %s7d:%.0f%%%s' "$out" "$(pct_color "$rl7")" "$rl7" "$RST")
    fi
fi

printf '%s' "$out"
