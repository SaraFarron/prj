# PRJ
CLI project management tool

## Quick Install

### Global
Run this command in your terminal to install prj globally:

```shell
curl -fsSL https://raw.githubusercontent.com/SaraFarron/prj/main/install.sh
```

What this does:
1. Downloads the latest version from GitHub
2. Installs to /usr/local/bin (requires sudo)
3. Makes prj available system-wide

### User
For a user-local installation:

```shell
curl -fsSL https://raw.githubusercontent.com/SaraFarron/prj/main/install-local.sh
```
Installs to ~/.local/bin and updates your PATH automatically.

## Requirements
`git` and `curl`

tested on ubuntu / pop os

## Uninstallation

To completely remove `prj`:

### System-wide install (used sudo):
```shell
sudo curl -fsSL https://raw.githubusercontent.com/SaraFarron/prj/main/uninstall.sh
```
