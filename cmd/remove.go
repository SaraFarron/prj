package cmd

import (
	"github.com/spf13/cobra"
)

var rmCmd = &cobra.Command{
	Use:   "rm",
	Aliases: []string{"rm"},
	Short: "Remove project",
	Long:  `Deletes project`,
	Args:  cobra.ExactArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		Remove(args[0])
	},
}

func init() {
	rootCmd.AddCommand(rmCmd)
}
