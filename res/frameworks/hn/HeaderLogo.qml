import QtQuick 2.12
import "../../fonts/SourceSansPro" as SSP

Rectangle {
    width: 30
    height: 30
    color: "transparent"
    border { width: 2; color: "#FFF" }

    Text {
        text: "HN"
        color: "#FFF"
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font { pixelSize: 14; family: SSP.Fonts.semiBold }
    }
}