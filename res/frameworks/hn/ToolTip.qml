import QtQuick 2.12
import QtQuick.Controls 2.12 as Base
import "../../fonts/SourceSansPro" as SSP

Base.ToolTip {
    id: tooltip

    delay: 150
    visible: parent.hovered || false

    background: Rectangle {
        radius: 4
        color: "#232323"
        border.color: "#111"
    }

    contentItem: Text {
        color: "#FFF"
        text: tooltip.text
        horizontalAlignment: Text.AlignHCenter
        font { pixelSize: 14; family: SSP.Fonts.regular }
    }
}