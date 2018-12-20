import QtQuick 2.11
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import "framework" as Framework
import "fragment" as Fragment
import "style"

ColumnLayout {
    spacing: 0
    anchors.fill: parent

    Framework.Header {
        contents: [
            Framework.HeaderButton {
                text: "Top"
                actived: stack.currentIndex === 0
                onClicked: stack.currentIndex = 0
            },
            Framework.HeaderButton {
                text: "New"
                actived: stack.currentIndex === 1
                onClicked: stack.currentIndex = 1
            },
            Framework.HeaderButton {
                text: "Show"
                actived: stack.currentIndex === 2
                onClicked: stack.currentIndex = 2
            },
            Framework.HeaderButton {
                text: "Ask"
                actived: stack.currentIndex === 3
                onClicked: stack.currentIndex = 3
            },
            Framework.HeaderButton {
                text: "Jobs"
                actived: stack.currentIndex === 4
                onClicked: stack.currentIndex = 4
            },
            Rectangle {
                Layout.fillWidth: true
            },
            Text {
                text: "Built with Qamel"
                color: "#FFF"
                font.pixelSize: 14
                font.family: Fonts.sourceSansPro
            }
        ]
    }

    StackLayout {
        id: stack
        Layout.fillWidth: true
        Layout.fillHeight: true

        onCurrentIndexChanged: function() {
            if (currentIndex <= 4) data[currentIndex].loadData(1);
        }
        
        Fragment.ListStory {
            storiesType: "top"
        }

        Fragment.ListStory {
            storiesType: "new"
        }

        Fragment.ListStory {
            storiesType: "show"
        }

        Fragment.ListStory {
            storiesType: "ask"
        }

        Fragment.ListStory {
            storiesType: "jobs"
        }
    }
}