package main

import (
	"os"

	_ "github.com/RadhiFadlillah/qamel-hn/backend"
)

func main() {
	// getStories("top")
	// return
	runQtApp(len(os.Args), os.Args)
}
