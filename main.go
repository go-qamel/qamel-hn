package main

import (
	"os"

	_ "qamel-hn/backend"
)

func main() {
	runQtApp(len(os.Args), os.Args)
}
