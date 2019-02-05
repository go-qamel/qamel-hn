// +build dev

package main

import (
	"os"

	"github.com/RadhiFadlillah/qamel"
	"github.com/sirupsen/logrus"
)

func runQtApp(argc int, argv []string) {
	logrus.Println("DEV MODE")

	// Create QT app
	app := qamel.NewApplication(len(os.Args), os.Args)
	app.SetApplicationDisplayName("Qamel HN")
	app.SetWindowIcon(":/res/icon.png")

	// Create viewer
	view := qamel.NewViewer()
	view.SetSource("res/main.qml")
	view.SetResizeMode(qamel.SizeRootObjectToView)
	view.SetHeight(600)
	view.SetWidth(800)
	view.ShowMaximized()

	// Watch change in QML dir
	go view.WatchResourceDir("res")

	// Exec app
	app.Exec()
}
