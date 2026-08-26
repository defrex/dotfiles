# Distribution base layer, if this machine ships one. CachyOS puts oh-my-zsh,
# powerlevel10k, syntax highlighting, autosuggestions and fzf behind a single
# file; other distros and macOS have nothing here and skip it. It must stay
# FIRST -- the p10k instant-prompt block has to run before any output.
for _base in \
  /usr/share/cachyos-zsh-config/cachyos-config.zsh \
  /usr/share/zsh/manjaro-zsh-config
do
  [[ -r $_base ]] && source "$_base" && break
done
unset _base

# Personal config: files in ~/code/dotfiles/zshrc.d (and, on a machine with
# host-specific config, wherever else), all symlinked into ~/.zshrc.d.
# Sourced last so anything here wins over the distro defaults above.
#
# (N) is the nullglob qualifier. Without it, an empty ~/.zshrc.d makes the
# glob a fatal error in zsh and the shell comes up broken.
#
# NOTE: Claude Code's shell tool also sources this file, in a NON-interactive
# shell. Keep everything reachable from here safe in that context -- nothing
# that prompts, blocks, or spawns a background daemon (which is why
# ssh-agent.sh is deliberately not symlinked in).
for rc in ~/.zshrc.d/*(N); do
  source "$rc"
done
unset rc

# ---------------------------------------------------------------------------
# Machine-local tooling. Everything below is guarded by an existence check, so
# a box without the tool installed simply skips it rather than erroring. Add
# new entries in this shape, not as bare exports.
# ---------------------------------------------------------------------------

# bun
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# Antigravity
[[ -d "$HOME/.antigravity/antigravity/bin" ]] &&
  export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# pnpm -- Library/pnpm on macOS, .local/share/pnpm on Linux
for _pnpm in "$HOME/Library/pnpm" "$HOME/.local/share/pnpm"; do
  if [[ -d $_pnpm ]]; then
    export PNPM_HOME="$_pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
    break
  fi
done
unset _pnpm

# nvm
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
