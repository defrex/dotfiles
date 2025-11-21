#!/bin/bash

# Initialize starship prompt for zsh
if [ -n "$ZSH_VERSION" ]; then
    eval "$(starship init zsh)"
fi