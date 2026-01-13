# Setup worktree-init.sh

Create a `worktree-init.sh` script in the project root for git worktree initialization.

## Requirements

1. The script must be executable (`chmod +x worktree-init.sh`)
2. Add `worktree-init.sh` to `.gitignore` (this file contains local paths and shouldn't be committed)

## Script Template

The script runs from inside the new worktree directory. The main worktree is typically at `../<project-name>/`.

Common setup tasks to include:

### Environment Files
```bash
# Copy .env from main worktree
cp ../<project-name>/.env .env
```

### Claude Code Settings
```bash
# Copy local Claude settings (if using Claude Code)
if [ -d "../<project-name>/.claude" ]; then
    mkdir -p .claude
    cp ../<project-name>/.claude/settings.local.json .claude/settings.local.json 2>/dev/null || true
fi
```

### Package Installation
```bash
# Detect and run package manager
if [ -f bun.lockb ] || [ -f bun.lock ]; then
    bun install
elif [ -f package-lock.json ]; then
    npm install
elif [ -f yarn.lock ]; then
    yarn install
elif [ -f pnpm-lock.yaml ]; then
    pnpm install
fi
```

### Other Common Tasks
- Database migrations
- Building native dependencies
- Setting up local config files
- Starting background services

## Instructions

1. Determine the project name (the directory name of the main worktree)
2. Create `worktree-init.sh` with the appropriate setup commands for this project
3. Make it executable
4. Add to `.gitignore` if not already present
5. Explain what the script does

Ask the user what setup tasks they need if not obvious from the project structure.
