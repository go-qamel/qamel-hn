import QtQuick 2.12
import QtQuick.Controls 2.5
import "../style"

Button {
    id: root
    padding: 0
    font.pixelSize: 13
    font.family: Fonts.sourceSansPro

    contentItem: Text {
        text: root.text
        font: root.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "#888"
    }

    background: Rectangle {
        color: "transparent"
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.clicked()
        }
    }
}