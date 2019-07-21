import QtQuick 2.12
import QtQuick.Controls 2.12
import "../../fonts/SourceSansPro" as SSP

Button {
    id: root

    padding: 0
    font { pixelSize: 15; family: SSP.Fonts.regular; underline: hovered }

    contentItem: Text {
        text: root.text
        font: root.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: root.enabled ? "#000" : "#CCC"
    }

    background: Rectangle {
        width: root.width
        height: root.height

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.clicked()
        }
    }
}