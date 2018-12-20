import QtQuick 2.12
import QtQuick.Controls 2.5
import "../style"

ToolTip {
    id: tooltip
    delay: 100
    visible: parent.hovered

    background: Rectangle {
        color: "#232323"
        radius: 4
        border.width: 0
    }

    contentItem: Text {
        color: "#FFF"
        text: tooltip.text
        font.family: Fonts.sourceSansPro
        font.pixelSize: 13
    }
}