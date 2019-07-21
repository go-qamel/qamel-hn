import QtQuick 2.12
import QtQuick.Controls 2.12
import "../../fonts/SourceSansPro" as SSP

Button {
    id: root

    padding: 0
    font { pixelSize: 13; family: SSP.Fonts.regular }

    contentItem: Text {
        color: "#888"
        text: root.text
        font: root.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
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