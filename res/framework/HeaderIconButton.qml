import QtQuick 2.12
import QtQuick.Controls 2.5
import "../style"

Button {
    id: root
    implicitWidth: 30
    implicitHeight: 30
    font.pixelSize: 14
    font.family: Fonts.fontAwesomeIcons
    opacity: enabled ? 1 : 0.6

    property string tooltip: ""
    property alias symbol: root.text

    FlatToolTip {
        text: root.tooltip
        visible: root.tooltip !== "" && root.hovered
    }

    contentItem: Text {
        text: root.text
        font: root.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        color: root.hovered ? "#FFEB3B" : "#FFF"
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