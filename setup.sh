#!/bin/bash

HOME_TARGET=$HOME
CONFIG_TARGET=$HOME_TARGET/.config

echo "Setting up dotfiles for user: $HOME"

setup_config() {
  local config_name=$1
  local config_dir="$CONFIG_TARGET/$config_name"

  if [ ! -d "$config_dir" ]; then
    echo "Creating directory: $config_dir"
    mkdir -p "$config_dir"
  fi

  echo "Stowing $config_name configuration..."
  stow --target="$config_dir" "$config_name"
}

configs=("nvim" "aerospace" "tmux" "kitty")

for config in "${configs[@]}"; do
  setup_config "$config"
done

echo "Stowing zsh configuration..."
stow --target="$HOME_TARGET" zsh

echo "Stowing starship configuration..."
stow --target="$CONFIG_TARGET" starship
