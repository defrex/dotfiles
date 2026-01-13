#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
usage=$(echo "$input" | jq '.context_window.current_usage')

# Context percentage with progress bar
ctx_part=""
if [ "$usage" != "null" ]; then
  current=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
  size=$(echo "$input" | jq '.context_window.context_window_size')
  pct=$((current * 100 / size))

  # Create progress bar (20 characters) with color zones
  # 0-10: gray (safe), 11-14: yellow (warning), 15-19: red (danger)
  filled=$((pct / 5))  # 20 chars = 5% per char
  bar=""
  gray=$'\033[37m'
  yellow=$'\033[33m'
  red=$'\033[31m'
  reset=$'\033[0m'

  for ((i=0; i<20; i++)); do
    # Determine color for this position
    if [ $i -le 10 ]; then
      color="$gray"
    elif [ $i -le 14 ]; then
      color="$yellow"
    else
      color="$red"
    fi

    # Determine fill character
    if [ $i -lt $filled ]; then
      char="█"
    else
      char="░"
    fi

    bar+="${color}${char}"
  done
  bar+="$reset"

  ctx_part="${bar}"
fi

# Directory with git branch (top-level dir name only)
dir_part=""
if [ -n "$cwd" ]; then
  dir_name=$(basename "$cwd")
  if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
      dir_part="${dir_name}:${branch}"
    else
      dir_part="${dir_name}"
    fi
  else
    dir_part="${dir_name}"
  fi
fi

# Output: context bar, space, directory
if [ -n "$ctx_part" ] && [ -n "$dir_part" ]; then
  printf "%s %s" "$ctx_part" "$dir_part"
elif [ -n "$ctx_part" ]; then
  printf "%s" "$ctx_part"
elif [ -n "$dir_part" ]; then
  printf "%s" "$dir_part"
fi
