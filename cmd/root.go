package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
	"os"
)

var rootCmd = &cobra.Command{
	Use:   "prj",
	Short: "Project management tool",
	Long:  `Simple project management tool to run projects with desired config.`,
	ValidArgs: []string{"add", "mv", "rm", "run", "list"},
	Run: func(cmd *cobra.Command, args []string) {
	},
}

func Execute() {
	if rootCmd.Args == nil {
		rootCmd.Help()
	}
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintf(os.Stderr, "An error while executing Prj '%s'\n", err)
		os.Exit(1)
	}
}
