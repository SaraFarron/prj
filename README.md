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

# It is very simple
`prj` is just a one simple bash script, what it does is basically:
```shell
cd here
run this-thing.sh
```
so you can easily understand whats going on inside

## Add your own configs
I will most likely add scripts in `configs/` depending on my own needs, if you need something for yourself just copy, rename and edit what you want it to execute - it is that simple.

## Want flexibility?
All your project scripts are located in `projects/`, these scripts execute when you
run project using `prj run <project name>`, therefore you can edit them individually.

# Credits

Thanks to [EivindArvesen's prm](https://github.com/EivindArvesen/prm) - some ideas were inspired by his project
