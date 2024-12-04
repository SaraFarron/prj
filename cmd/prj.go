package cmd

import (
	"fmt"
	"net/url"
	"os"
	"os/exec"
	"path/filepath"
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
    homeDir, _ := os.UserHomeDir()
    fullProjectsDir := filepath.Join(homeDir, projectsDir)
    absProjects, _ := filepath.Abs(fullProjectsDir)
    url, err := url.ParseRequestURI(projectPath)
    if err != nil {
        exec.Command("sh", "-c", "cd "+absProjects+" && "+"git", "clone", url.String()).Run()
    } else {
        // create folder projectPath
        fullProjectPath := filepath.Join(fullProjectsDir, projectPath)
        os.Mkdir(fullProjectPath, 0755)
    }
    fmt.Printf("Project %s created\n", projectPath)
    Run(projectPath)
}

func Mv(oldPath string, newPath string) {
    homeDir, err := os.UserHomeDir()
    if err != nil {
        panic(err)
    }
    oldProjectPath := filepath.Join(homeDir, projectsDir, oldPath)
    absOldPath, _ := filepath.Abs(oldProjectPath)
    newProjectPath := filepath.Join(homeDir, projectsDir, newPath)
    absNewPath, _ := filepath.Abs(newProjectPath)
    
    os.Rename(absOldPath, absNewPath)
    fmt.Printf("Moved %s --> %s\n", absOldPath, absNewPath)
}

func Remove(projectPath string) {
    homeDir, err := os.UserHomeDir()
    if err != nil {
        panic(err)
    }
    fullProjectPath := filepath.Join(homeDir, projectsDir, projectPath)
    fmt.Printf("Are you sure you want to delete %s? (y/n): ", fullProjectPath)
    var input string
    fmt.Scanln(&input)
    if input != "y" {
        return
    }
    os.RemoveAll(fullProjectPath)
    fmt.Printf("Deleted %s\n", fullProjectPath)
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
