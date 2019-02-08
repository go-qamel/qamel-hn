// +build dev

package main

import (
	"go/build"
	"os"
	fp "path/filepath"

	"github.com/RadhiFadlillah/qamel"
	"github.com/sirupsen/logrus"
)

func runQtApp(argc int, argv []string) {
	logrus.Println("DEV MODE")

	// Create QT app
	app := qamel.NewApplication(len(os.Args), os.Args)
	app.SetApplicationDisplayName("Qamel HN")
	app.SetWindowIcon(":/res/icon.png")

	// Define path to resource directory
	gopath := build.Default.GOPATH
	resDir := fp.Join(gopath, "src", "qamel-hn", "res")

	// Create viewer
	view := qamel.NewViewer()
	view.SetSource(fp.Join(resDir, "main.qml"))
	view.SetResizeMode(qamel.SizeRootObjectToView)
	view.SetHeight(600)
	view.SetWidth(800)
	view.ShowMaximized()

	// Watch change in resource dir
	go view.WatchResourceDir(resDir)

	// Exec app
	app.Exec()
}
