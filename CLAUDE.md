# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages configuration files for various development tools and environments. The repository supports multiple shells (bash, zsh, xonsh) and follows a modular configuration approach.

## Architecture and Organization

### Core Structure
- **Shell Configurations**: Main configs (`.bashrc`, `.zshrc`) source modular files from `.bashrc.d/` directory
- **Shared Configuration**: **Important**: `.bashrc.d/` is used for BOTH bash and zsh configurations (despite the name). The scripts are written to be compatible with both shells
- **Custom Scripts**: User scripts are stored in `bin/` and automatically added to PATH
- **Editor Configs**: Configurations for Sublime Text, Zed, and other editors

### Key Patterns
1. **Shell configuration loading**: Both bash and zsh source all files from `.bashrc.d/` directory (zsh primarily used, but varies by machine)
2. **PATH management**: Multiple scripts handle PATH additions (dotfiles/bin, ~/bin, tool-specific paths)
3. **Tool integration**: Modular files handle specific tools (nvm, asdf, bun, homebrew, ruby)

## Common Development Tasks

### Adding New Shell Configuration
- Create a new file in `.bashrc.d/` with your configuration (used by both bash and zsh)
- Ensure scripts are compatible with both bash and zsh syntax
- Files are sourced alphabetically, so use prefixes if order matters

### Managing RC File Symlinks
The `~/.zshrc.d/` directory uses symlinks to files in this repo's `.bashrc.d/` directory:
- **Important**: `~/.bashrc.d/` does NOT exist. Scripts live in this repo at `/Users/defrex/code/dotfiles/.bashrc.d/` and are symlinked into `~/.zshrc.d/`
- **Create symlink**: `ln -s /Users/defrex/code/dotfiles/.bashrc.d/filename.sh ~/.zshrc.d/filename.sh`
- **Remove symlink**: `unlink ~/.zshrc.d/filename.sh` or `rm ~/.zshrc.d/filename.sh`
- **Check existing symlinks**: `ls -la ~/.zshrc.d/`

### Adding Custom Scripts
- Place executable scripts in `bin/` directory
- Scripts are automatically available in PATH after shell restart
- Follow existing naming conventions (kebab-case)

### Testing Configuration Changes
- Source the main config file: `source ~/.bashrc` or `source ~/.zshrc`
- For modular files, source directly: `source ~/.bashrc.d/your-file.sh`

## Important Files and Their Purposes

- `.aerospace.toml`: macOS window manager configuration (AeroSpace)
- `bin/typecheck-zed`: TypeScript checking integration that opens error files in Zed editor
- `bin/display-*.sh`: Linux display configuration scripts using xrandr
- `bin/generate-cert.sh`: SSL certificate generation utility
- `.bashrc.d/cd-env.sh`: Custom directory environment switching functionality
- `.bashrc.d/prompt.sh`: Bash prompt customization
- `zed/settings.json`: Zed editor settings with TypeScript auto-formatting

## Notes

- No automated setup scripts exist; installation is manual via symlinking
- The repository is designed for personal use across different development machines
- Configuration changes should maintain compatibility with both bash and zsh where applicable
- use ~/.zshrc.d for the home dir version of .bashrc.d