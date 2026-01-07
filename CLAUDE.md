# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages configuration files for various development tools and environments. The primary shell is zsh, with a modular configuration approach.

## Architecture and Organization

### Core Structure
- **Shell Configuration**: `.zshrc` sources modular files from `~/.zshrc.d/` directory
- **Modular Configs**: `zshrc.d/` contains shell configuration scripts (symlinked to `~/.zshrc.d/`)
- **Custom Scripts**: User scripts are stored in `bin/` and automatically added to PATH
- **Editor Configs**: Configurations for Sublime Text, Zed, and other editors

### Key Patterns
1. **Shell configuration loading**: `.zshrc` sources all files from `~/.zshrc.d/` directory
2. **PATH management**: Multiple scripts handle PATH additions (dotfiles/bin, ~/bin, tool-specific paths)
3. **Tool integration**: Modular files handle specific tools (nvm, asdf, bun, homebrew, ruby)

## Common Development Tasks

### Adding New Shell Configuration
- Create a new file in `zshrc.d/` with your configuration
- Files are sourced alphabetically, so use prefixes if order matters
- Symlink the new file to `~/.zshrc.d/`

### Managing RC File Symlinks
The `~/.zshrc.d/` directory uses symlinks to files in this repo's `zshrc.d/` directory:
- **Create symlink**: `ln -s /Users/defrex/code/dotfiles/zshrc.d/filename.sh ~/.zshrc.d/filename.sh`
- **Remove symlink**: `unlink ~/.zshrc.d/filename.sh` or `rm ~/.zshrc.d/filename.sh`
- **Check existing symlinks**: `ls -la ~/.zshrc.d/`

### Adding Custom Scripts
- Place executable scripts in `bin/` directory
- Scripts are automatically available in PATH after shell restart
- Follow existing naming conventions (kebab-case)

### Testing Configuration Changes
- Source the main config file: `source ~/.zshrc`
- For modular files, source directly: `source ~/.zshrc.d/your-file.sh`

## Important Files and Their Purposes

- `.aerospace.toml`: macOS window manager configuration (AeroSpace)
- `bin/typecheck-zed`: TypeScript checking integration that opens error files in Zed editor
- `bin/display-*.sh`: Linux display configuration scripts using xrandr
- `bin/generate-cert.sh`: SSL certificate generation utility
- `zshrc.d/cd-env.sh`: Custom directory environment switching functionality
- `zshrc.d/starship.sh`: Starship prompt configuration
- `zed/settings.json`: Zed editor settings with TypeScript auto-formatting

## Notes

- No automated setup scripts exist; installation is manual via symlinking
- The repository is designed for personal use across different development machines