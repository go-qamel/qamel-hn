import QtQuick 2.12
import QtGraphicalEffects 1.12
import "../../fonts/SourceSansPro" as SSP
import "." as HN

Rectangle {
    id: root

    property int maxPage: 1
    property int currentPage: 1

    z: 1
    color: "#FFF"
    layer.enabled: true
    layer.effect: DropShadow {
        radius: 3
        samples: 7
        color: "#DDD"
        verticalOffset: 2
        transparentBorder: true
    }

    Row {
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        HN.PaginationButton {
            text: "< prev"
            enabled: root.enabled && root.currentPage > 1
            onClicked: root.currentPage--
        }

        Text {
            color: "#000"
            text: `${root.currentPage} / ${root.maxPage}`
            font { pixelSize: 15; family: SSP.Fonts.regular }
        }

        HN.PaginationButton {
            text: "next >"
            enabled: root.enabled && root.currentPage < root.maxPage
            onClicked: root.currentPage++
        }
    }
}