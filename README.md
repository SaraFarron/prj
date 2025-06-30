# PRJ
CLI project management tool

Prj will help you manage your projects and navigate between them quickly, without remembering their name or path.

This tool will be helpful for people, who work on many active projects and tired of continious switching with `cd`.

## Quick Install

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/SaraFarron/prj/main/install.sh)"
```
Installs to ~/.local/bin and updates your PATH automatically.

**If you ran it with sudo and `prj` command does not work - try without sudo**

## Requirements
`git` and `curl`

tested on ubuntu / pop os

## Uninstallation

To completely remove `prj`:

```shell
curl -fsSL https://raw.githubusercontent.com/SaraFarron/prj/main/uninstall.sh | bash
```

## Development

If you happened to use this and experience some kind of bug or want more features, you can create an issue or write me directly in telegram @SaraFaron .

You can also do it yourself - prj is just a bunch of bash scripts, even if you are not comfortable with programming in bash - AI will most certainly be of great help.

## Cool features
* simple to install and uninstall with one command scripts
* tab completion
* no in-app purchases and ads
* rust-free

## Credits

Mostly inspired by [prm](https://github.com/EivindArvesen/prm), but prj is more simple and trivial.

## TODO

* command for changing config (like choosing another ide or modifying default open command)
* custom project opening (like choosing open command for specific project)
