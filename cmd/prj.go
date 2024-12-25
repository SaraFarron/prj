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
	command := "code " + absPath
	cmd := exec.Command("sh", "-c", command)
	cmd.Run()
}

func Add(projectPath string) {
	homeDir, _ := os.UserHomeDir()
	fullProjectsDir := filepath.Join(homeDir, projectsDir)
	absProjects, _ := filepath.Abs(fullProjectsDir)
	url, err := url.ParseRequestURI(projectPath)
	if err == nil {
		projectPathSplitted := strings.Split(url.Path, "/")
		projectPath = projectPathSplitted[len(projectPathSplitted)-1]

		if _, err := os.Stat(filepath.Join(absProjects, projectPath)); err == nil {
			fmt.Printf("Project %s already exists\n", projectPath)
			return
		}

		cmd := "cd " + absProjects + " && " + "git clone " + url.String()
		exec.Command("sh", "-c", cmd).Run()
	} else {
		// create folder projectPath
		fullProjectPath := filepath.Join(fullProjectsDir, projectPath)
		if _, err := os.Stat(fullProjectPath); err == nil {
			fmt.Printf("Project %s already exists\n", projectPath)
			return
		}
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
	if _, err := os.Stat(oldProjectPath); err != nil {
		fmt.Printf("Project %s does not exist\n", oldPath)
		return
	}
	absOldPath, _ := filepath.Abs(oldProjectPath)
	newProjectPath := filepath.Join(homeDir, projectsDir, newPath)
	if _, err := os.Stat(newProjectPath); err == nil {
		fmt.Printf("Project %s already exists\n", newPath)
		return
	}
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

func ListNames() []string {
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
	return fileNames
}

func List() string {
	fileNames := ListNames()

	output := strings.Join(fileNames, "\n")
	return output
}
