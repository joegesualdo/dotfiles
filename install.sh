#!/bin/bash

# Base directory where your configuration folders are located
BASE_DIR=$(realpath $(dirname $0)) # Script's directory as base

# Calculate full paths for each directory
NVIM_DIR=$(realpath "$BASE_DIR/nvim")
TMUX_DIR=$(realpath "$BASE_DIR/tmux")
WEZTERM_DIR=$(realpath "$BASE_DIR/wezterm")
ZSHRC_DIR=$(realpath "$BASE_DIR/zshrc")

# Get the full path to the home directory
HOME_DIR=$(realpath "$HOME")

# Create symbolic links using full paths
ln -sfn "$NVIM_DIR" "$HOME_DIR/.config/nvim"
ln -sfn "$TMUX_DIR" "$HOME_DIR/.config/tmux"
ln -sfn "$WEZTERM_DIR" "$HOME_DIR/.config/wezterm"
ln -sfn "$ZSHRC_DIR" "$HOME_DIR/.zshrc"

# Reload tmux configuration only if inside a tmux session
if [ -n "$TMUX" ]; then
  tmux source-file ~/.config/tmux/tmux.conf
  echo "tmux configuration reloaded."
else
  echo "Not in a tmux session. Skipping tmux reload."
fi

# Validate WezTerm configuration
echo "Validating WezTerm configuration..."
wezterm ls-fonts
if [ $? -eq 0 ]; then
  echo "WezTerm configuration is valid."
else
  echo "Error: WezTerm configuration validation failed."
fi

# Reload Zsh configuration
echo "Reloading Zsh configuration..."
source ~/.zshrc
if [ $? -eq 0 ]; then
  echo "Zsh configuration reloaded successfully."
else
  echo "Error: Failed to reload Zsh configuration."
fi
