package cmd

import (
    "path/filepath"
    "os"
    "strings"
)

func Run(projectPath string) {
}

func Add(projectPath string) {
}

func Mv(oldPath string, newPath string) {
}

func Remove(projectPath string) {
}

func List() (string) {
    homeDir, err := os.UserHomeDir()
    if err != nil {
        panic(err)
    }

    projectsDir := filepath.Join(homeDir, "Projects")

    files, err := os.ReadDir(projectsDir)
    if err != nil {
        panic(err)
    }

    var fileNames []string
	for _, file := range files {
		fileNames = append(fileNames, file.Name())
	}
    
    output := strings.Join(fileNames, "\n")
	return output
}
