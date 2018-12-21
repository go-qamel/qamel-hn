import QtQuick 2.12
import QtGraphicalEffects 1.12
import "../framework" as Framework
import "../style"

Rectangle {
    z: 1
    id: root
    color: "#FFF"
    property int maxPage: 1
    property int currentPage: 1

    layer.enabled: true
    layer.effect: DropShadow {
        verticalOffset: 2
        transparentBorder: true
        radius: 3
        samples: 7
        color: "#DDD"
    }
    
    Row {
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Framework.PaginationButton {
            text: "< prev"
            enabled: root.enabled && root.currentPage > 1
            onClicked: root.currentPage--
        }
        Text {
            color: "#000"
            font.pixelSize: 15
            font.family: Fonts.sourceSansPro
            text: root.currentPage + "/" + root.maxPage
        }
        Framework.PaginationButton {
            text: "next >"
            enabled: root.enabled && root.currentPage < root.maxPage
            onClicked: root.currentPage++
        }
    }
}