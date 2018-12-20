// +build dev

package main

import (
	"os"
	fp "path/filepath"
	"strings"

	"github.com/RadhiFadlillah/qamel"
	"github.com/fsnotify/fsnotify"
	"github.com/sirupsen/logrus"
)

func runQtApp(argc int, argv []string) {
	logrus.Println("DEV MODE")

	// Create watcher for QML dir
	watcher, err := createWatcher("res")
	if err != nil {
		logrus.Fatalln("Failed to create file watcher:", err)
	}
	defer watcher.Close()

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

	// If files in dir changed, update view
	go func() {
		for {
			select {
			case event := <-watcher.Events:
				fName := event.Name
				if fp.Ext(fName) == ".qmlc" || strings.Contains(fName, ".qmlc.") {
					continue
				}

				logrus.Printf("%s: %s", event.Op.String(), fName)
				view.Reload()
			case err := <-watcher.Errors:
				if err != nil {
					logrus.Errorln("Watcher error:", err)
				}
			}
		}
	}()

	// Exec app
	app.Exec()
}

func createWatcher(dir string) (*fsnotify.Watcher, error) {
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		return nil, err
	}

	fp.Walk(dir, func(path string, info os.FileInfo, err error) error {
		if info.IsDir() {
			return watcher.Add(path)
		}
		return nil
	})

	return watcher, nil
}
