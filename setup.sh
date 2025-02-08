#!/bin/bash
# Bash script to be executed for downloading a-barlows .dotfiles setup.
LICENCE="Copyright 2025 Andrew Rowan Barlow\n
\n
Permission is hereby granted, free of charge, to any person obtaining a copy of\n
this software and associated documentation files (the “Software”), to deal in\n
the Software without restriction, including without limitation the rights to\n
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of\n
the Software, and to permit persons to whom the Software is furnished to do so,\n
subject to the following conditions:\n
\n
The above copyright notice and this permission notice shall be included in all\n
copies or substantial portions of the Software.\n
\n
THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS\n
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR\n
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER\n
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN\n
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n"

echo -e $LICENCE
echo "[DOTFILES SETUP] This script will install dotfiles from the following repository: "
echo "[DOTFILES SETUP] https://github.com/a-barlow/dotfiles"
echo "[DOTFILES SETUP] By proceeding with the installation of dotfiles, you must accept"
echo "                 the licence's terms and conditions (printed above)."
echo "[DOTFILES SETUP] To ACCEPT the terms and conditions, type: accept"
echo "[DOTFILES SETUP] If you wish to DECLINE the terms and conditions, press ENTER."
read USER_CONSET
if [ "$USER_CONSET" != "accept" ]; then
  exit 1
fi

# Set dirs for dotfile installation
DOTFILES_DIR=$HOME/.dotfiles
XDG_CONFIG_HOME=$HOME/.config

# Check for dot files installation
if [ -d $DOTFILES_DIR ]; then
  echo "[DOTFILES SETUP] .dotfiles/ directory already exists."
  echo "[DOTFILES SETUP] Exiting program now."
  exit 1
fi

echo "[DOTFILES SETUP] Installing essential programs."

# Setup isntallation for firacode fonts
version='3.3.0'
fonts_dir=$HOME/.local/share/fonts
font=FiraCode
echo "[DOTFILES SETUP] Installed nerd font."
curl https://github.com/ryanoasis/nerd-fonts/releases/download/v$version/${font}.zip

# Detect the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "[DOTFILES SETUP] Detected Linux system."
  unzip ${font} -d $HOME/.local/share/fonts
  PACKAGE_MANAGER="sudo apt install -y"
  # Add access to python libraries
  sudo add-apt-repository -y 'ppa:deadsnakes/ppa'
  # Adds make and gcc
  sudo apt install -y build-essentials
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "[DOTFILES SETUP] Detected MacOS system."
  unzip ${font} -d $HOME/Library/Fonts/
  PACKAGE_MANAGER="brew install"
  brew install gcc
else
  echo "[DOTFILES SETUP] Unsupported operating system."
  exit 1
fi

rm ${font}.zip
echo "[DOTFILES SETUP] Installed relevant package manager."

# Function to install packages
install_package() {
  $PACKAGE_MANAGER $1
}

# Download dotfiles repo
install_package git
git clone https://github.com/a-barlow/dotfiles.git
mv dotfiles/ $DOTFILES_DIR

# Use GNUs stow (create symlinks to home directory)
install_package stow
stow $HOME/dotfiles/dotfiles/ $HOME/

# Install curl
install_package curl

# Installs make
install_package make

# Install programs listed in install_makes dir/, with user's permission
./setup_optional.sh

export -f install_package
# Append to bash_profile
cat "$bash_profile_append" >>$HOME/.bash_profile

# Append to bash_rc
cat "$bashrc_append" >>$HOME/.bashrc

echo "[DOTFILES SETUP] Finished setup."
