#!/bin/bash
# Install optionall programs with user's permission

# Asks for user verification, and installs (optional) apps
install_program() {
  echo "[DOTFILES SETUP] Do you want to install $1?"
  select yn in "Yes" "No"; do
    case $yn in
    Yes)
      task --taskfile Taskfile.$1.yml
      break
      ;;
    No) break ;;
    esac
  done
}

# Install programs specified by makefiles in install_makes/ dir
echo "[DOTFILES SETUP] Installing optional programs."
for file in "$HOME/.dotfiles/install_makes/*"; do
  install_program $file
done
