package cmd

import (
	"github.com/spf13/cobra"
)

var runCmd = &cobra.Command{
	Use:   "run",
	Aliases: []string{"run"},
	Short: "Open project",
	Long:  `Run project in a code editor`,
	Args:  cobra.ExactArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		Run(args[0])
	},
}

func init() {
	rootCmd.AddCommand(runCmd)
}
