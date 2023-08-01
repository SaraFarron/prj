# prj
Simple terminal project manager to make your life a little bit easier

# Installation

```shell
git clone https://github.com/SaraFarron/prj.git
chmod +x ./prj/prj.sh
```
Add alias to your `.bashrc`:
```shell
alias prj="path/to/prj/prj.sh"
```

# Usage

```shell
prj add <project name>           Add project.
prj add <git link>               Add project from git host.
prj list                         List all projects.
prj remove <project name>        Remove project(s).
prj run <project name>           Start project.
prj init <project name> <config> Init project.
prj                              Display this information.

```
* Add project: 
If provided with name creates folder in `PROJECTS_FOLDER` with that name and adds project config
If provided with link clones repo in `PROJECTS_FOLDER` and adds project config
* Init project:
You can initialise project like `git init ; touch README.md ; touch .gitignore ...`
Possible init options are in `configs/`, of course, you can add and edit them to your taste
You can also init multilple scripts in one go: `prj init project-name config1 config2 config3`

You can define what editor to use and your default projects folder in `prj.sh` at the top
of the file:
```shell
PROJECTS_FOLDER="$HOME/Projects/"  # your projects folder
EDITOR_COMMAND="code ."  # edit to run in your favourite editor
```


# Why this project?

If you cd to your project every time after opening terminal - then this might save
you some time. With prj you can `cd`, `git pull`, activate virtual env, etc. with just one simple command.

Want flexibility? All your project configs are located in `projects/`, this scripts are launched when you
run project through prj, feel free to adjust them individually to your needs.

# TODO

* init command: initialise project (git init, create README, create main.lang, etc.) and allow to choose initilising profile

# Credits

Thanks to [EivindArvesen's prm](https://github.com/EivindArvesen/prm) - some ideas were inspired by his project
