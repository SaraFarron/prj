package cmd

import (
	"github.com/spf13/cobra"
)

var addCmd = &cobra.Command{
	Use:   "add",
	Aliases: []string{"add"},
	Short: "Create a new project",
	Long:  `Create project folder and enter it or clone project from git`,
	Args:  cobra.ExactArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		Add(args[0])
	},
}

func init() {
	rootCmd.AddCommand(addCmd)
}
