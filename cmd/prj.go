package cmd

import (
    "path/filepath"
    "os"
    "os/exec"
    "strings"
    "net/url"
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
}

func Remove(projectPath string) {
    homeDir, err := os.UserHomeDir()
    if err != nil {
        panic(err)
    }
    fullProjectPath := filepath.Join(homeDir, projectsDir, projectPath)
    os.RemoveAll(fullProjectPath)
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
