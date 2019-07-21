import QtQuick 2.12
import QtQuick.Controls 2.12
import "../../fonts/SourceSansPro" as SSP

Button {
    id: root

    property bool actived: false

    padding: 0
    enabled: !actived
    font.pixelSize: 16
    font.family: actived ? SSP.Fonts.semiBold : SSP.Fonts.regular

    contentItem: Text {
        id: label

        text: root.text
        font: root.font
        horizontalAlignment: Text.AlignHCenter
        color: root.actived || root.hovered ? "#FFEB3B" : "#FFF"
    }

    background: Rectangle {
        color: "transparent"
        implicitWidth: root.width
        implicitHeight: root.height

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.clicked()
        }
    }
}