import QtQuick 2.12
import QtQuick.Controls 2.12
import "../../fonts/FontAwesome" as FA
import "." as HN

Button {
    id: root

    property string tooltip: ""
    property alias symbol: root.text

    implicitWidth: 30
    implicitHeight: 30
    opacity: enabled ? 1 : 0.6
    font { weight: Font.Bold; pixelSize: 14; family: FA.Fonts.solid }

    HN.ToolTip {
        text: root.tooltip
        visible: root.tooltip !== "" && root.hovered
    }

    contentItem: Text {
        text: root.text
        font: root.font
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
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