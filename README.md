# Dotfiles

This repository hosts my personal dotfiles for both Linux and MacOS
environments.

A bash shell is required to run the installation scripts.

## Installation

**INSTALL AT YOUR OWN RISK!**

The bash script [`setup.sh`](./setup.sh) can be run to setup the dotfiles on
this repository onto this machine.

This script requires execution and write permissions.

To quickly run this script on your machine, use:

```bash
curl -L -H 'Accept: application/vnd.github.v3.raw' \
-H "X-GitHub-Api-Version: 2022-11-28" \
https://api.github.com/repos/a-barlow/dotfiles/contents/setup.sh | sh
```

## Repo Layout

| Folder/File         | Description                                                                         |
| ------------------- | ----------------------------------------------------------------------------------- |
| setup.sh            | Installs all configurations found in dotfiles/.                                     |
| setup_optional.sh   | Called by setup.sh, and installs programs in install_makes/.                        |
| bashrc_append       | Content that will be appended to the user's ~/.bashrc file when setup.sh is called. |
| bash_profile_append | Same as bashrc_append, but will append its contents to ~/.bash_profile.             |
| dotfiles/           | Files and folders that will be symlinked to the $HOME direcotry.                    |
| install_makes/      | The make files that are run for installing programs.                                |

## Licence

Licensed under MIT. Please see [`LICENCE.md`](./LICENCE.md) for more details.
