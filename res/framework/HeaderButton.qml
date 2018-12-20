import QtQuick 2.11
import QtQuick.Controls 2.5
import "../style"

Button {
    id: root
    padding: 0
    width: 35
    font.pixelSize: 16
    font.family: actived ? Fonts.sourceSansProSemiBold : Fonts.sourceSansPro

    property bool actived: false

    contentItem: Text {
        id: label
        text: root.text
        font: root.font
        horizontalAlignment: Text.AlignHCenter
        color: root.actived || root.hovered ? "#FFEB3B" : "#FFF"
    }

    background: Rectangle {
        implicitWidth: root.width
        implicitHeight: root.height
        color: "transparent"

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.clicked()
        }
    }
}