package cmd

import (
	"github.com/spf13/cobra"
)

var mvCmd = &cobra.Command{
	Use:   "mv",
	Aliases: []string{"mv"},
	Short: "Move project",
	Long:  `Move project to another folder`,
	Args:  cobra.ExactArgs(2),
	Run: func(cmd *cobra.Command, args []string) {
		Mv(args[0], args[1])
	},
}

func init() {
	rootCmd.AddCommand(mvCmd)
}
