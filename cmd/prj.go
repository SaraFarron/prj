package cmd

import (
    "path/filepath"
    "os"
    "os/exec"
    "strings"
)

var projectsDir string = "Projects"

func Run(projectPath string) {
    homeDir, err := os.UserHomeDir()
    if err != nil {
        panic(err)
    }
    fullProjectPath := filepath.Join(homeDir, projectsDir, projectPath)
    absPath, err := filepath.Abs(fullProjectPath)
    if err != nil {
        panic(err)
    }
    cmd := exec.Command("sh", "-c", "cd "+projectPath+" && code "+absPath)
    cmd.Run()
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

    projectsDir := filepath.Join(homeDir, projectsDir)

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
