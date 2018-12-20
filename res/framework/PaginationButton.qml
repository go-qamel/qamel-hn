import QtQuick 2.11
import QtQuick.Controls 2.5
import "../style"

Button {
    id: root
    padding: 0
    font.pixelSize: 15
    font.family: Fonts.sourceSansPro
    font.underline: hovered

    contentItem: Text {
        id: label
        text: root.text
        font: root.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: root.enabled ? "#000" : "#CCC"
    }

    background: Rectangle {
        implicitWidth: root.width
        implicitHeight: root.height

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.clicked()
        }
    }
}