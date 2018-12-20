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
                actived: true
                onClicked: console.log('top')
            },
            Framework.HeaderButton {
                text: "New"
            },
            Framework.HeaderButton {
                text: "Show"
            },
            Framework.HeaderButton {
                text: "Ask"
            },
            Framework.HeaderButton {
                text: "Jobs"
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

    Fragment.ListStory {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}