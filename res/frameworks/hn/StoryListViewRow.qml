import QtQuick 2.12
import QtQuick.Layouts 1.12
import "../../script/utils.js" as Utils
import "../../fonts/SourceSansPro" as SSP

Rectangle {
    id: root

    readonly property alias hovered: mouseArea.containsMouse

    signal doubleClicked(int row)

    width: parent.width
    height: childrenRect.height
    color: hovered ? "#E8EAF6" : "#FFF"
    border { color: "#3F51B5"; width: hovered ? 3 : 0 }
    
    Rectangle {
        z: 1
        height: 1
        color: "#EEE"
        visible: !root.hovered
        anchors { left: parent.left; right: parent.right }
    }

    GridLayout {
        rows: 2
        columns: 2
        rowSpacing: 4
        columnSpacing: 0
        width: parent.width

        Text {
            text: score
            color: "#3F51B5"
            Layout.row: 0
            Layout.column: 0
            Layout.rowSpan: 2
            Layout.fillHeight: true
            Layout.preferredWidth: 80
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font { pixelSize: 16; family: SSP.Fonts.semiBold }
        }
        
        Text {
            function _text() {
                if (url === "") return title;
                let domain = Utils.getDomainName(url);
                return `${title} <span style='color: #888; font-size: 14px'>(${domain})</span>`;
            }

            text: _text()
            color: "#000"
            topPadding: 16
            rightPadding: 8
            Layout.row: 0
            Layout.column: 1
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            font { pixelSize: 16; family: SSP.Fonts.semiBold }
        }

        Text {
            function _text() {
                let relTime = Utils.relativeTime(new Date(time * 1000));
                return `by ${by} ${relTime} | ${descendants} comments`;
            }

            text: _text()
            color: "#888"
            rightPadding: 8
            bottomPadding: 16
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth: true
            font { pixelSize: 14; family: SSP.Fonts.regular }
        }
    }
    
    MouseArea {
        id: mouseArea

        anchors.fill: root
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onDoubleClicked: root.doubleClicked(index)
    }
}