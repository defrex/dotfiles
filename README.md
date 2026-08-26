dotfiles — DEPRECATED
=====================

**Superseded on 2026-08-26 by `defrex/sysadmin`. Archived as history; do not clone
this onto a new machine.**

This repo was a decade of personal scratch across macOS, several Linux boxes, and
window managers that no longer exist — X11 rc files from 2016, Sublime settings from
2019, an AeroSpace config for macOS, i3 and kitty configs, a Zed setup, a xonsh
directory. Useful in its time, but by the end only **six** of its files were actually
symlinked into `$HOME` on the machine that used it:

    zshrc.d/{add-home-bin-to-path,add-local-bin-to-path,alias,bun,editor,history}

Those six, plus `.zshrc`, `.gitconfig`, `.gitignore_global`, and the git-forge half of
`.ssh/config`, now live in `sysadmin/home/` and are symlinked into `$HOME` from there.
Everything else stays here, unmigrated, and is reachable through this repo's history.

Why the change: config is now managed alongside the machine it configures, in a repo
that also carries the operational notes, the `/etc` source-of-record, and the agent
memory system. One tree, one owner, and a `--check` that fails loudly when a tracked
path stops being a symlink — which is how the commit-signing identity quietly escaped
version control in this repo.
