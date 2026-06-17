# Run Claude Code under separate accounts by isolating CLAUDE_CONFIG_DIR.
#
# Credentials live in $CLAUDE_CONFIG_DIR/.credentials.json, so each config dir
# keeps its own independent login — no logging in and out to switch accounts.
#
# Personal is the default ~/.claude dir (your original login + history). Work
# gets its own dir but shares machine-level config (settings, statusline,
# skills, commands, plugins) via symlinks from ~/.claude (see
# claude-account-setup). Plain `claude` is identical to `claude-personal`.

claude-personal() {
  CLAUDE_CONFIG_DIR="$HOME/.claude" command claude "$@"
}

claude-work() {
  CLAUDE_CONFIG_DIR="$HOME/.claude-work" command claude "$@"
}

# One-time bootstrap for an alternate account dir. Symlinks shared config from
# ~/.claude so you keep your statusline/skills/etc, then you just run /login.
#   claude-account-setup ~/.claude-work
claude-account-setup() {
  local dir="${1:?usage: claude-account-setup <config-dir>}"
  mkdir -p "$dir"
  local item
  for item in settings.json statusline.sh CLAUDE.md commands skills plugins keybindings.json; do
    if [ -e "$HOME/.claude/$item" ]; then
      ln -sfn "$HOME/.claude/$item" "$dir/$item"
    fi
  done
  echo "Set up $dir (shared config symlinked from ~/.claude)."
  echo "Now run:  CLAUDE_CONFIG_DIR=\"$dir\" claude   then /login with the right account."
}
