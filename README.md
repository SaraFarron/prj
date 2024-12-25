# PRJ
CLI project management tool

## Commands

```shell
prj [project | folder/project]
prj add [project | folder/project | git-link | folder/git-link]
prj mv [folder/project | folder/project]
prj remove [project | folder/project | folder]
prj list [*folder]
prj help

```

## Dev install
```shell
go build  # Creates binary prj
go install  # Adds binary to go list -f '{{.Target}}'
go list -f '{{.Target}}'
export PATH=$PATH:/output/of/command/above/minus/last/node  # This can be added to .bashrc

```

