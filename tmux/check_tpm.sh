#!/bin/bash

TPM_DIR="$HOME/.config/tmux/plugins/tpm"

# Check if TPM directory exists and is non-empty
if [ ! -d "$TPM_DIR" ] || [ -z "$(ls -A "$TPM_DIR" 2>/dev/null)" ]; then
  echo "Cloning TPM..."
  rm -rf "$TPM_DIR"
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "TPM already exists and is valid."
fi
