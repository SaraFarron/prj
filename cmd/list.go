package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
)

var listCmd = &cobra.Command{
	Use:   "list",
	Aliases: []string{"ls"},
	Short: "Lists all projects",
	Long:  `Lists all projects in Projects folder`,
	Args:  cobra.ExactArgs(0),
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Printf("%s\n", List())
	},
}

func init() {
	rootCmd.AddCommand(listCmd)
}
