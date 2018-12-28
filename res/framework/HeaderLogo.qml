import QtQuick 2.12
import "../style"

Rectangle {
    width: 30
    height: 30
    color: "transparent"
    border.width: 2
    border.color: "#FFF"

    Text {
        anchors.fill: parent
        text: "HN"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 14
        font.family: Fonts.sourceSansProSemiBold
        color: "#FFF"
    }
}