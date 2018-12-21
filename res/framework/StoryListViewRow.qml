import QtQuick 2.12
import QtQuick.Layouts 1.12
import "../style"
import "../script/utils.js" as Utils

Rectangle {
    id: root
    color: hovered ? "#E8EAF6" : "#FFF"
    width: parent.width
    height: childrenRect.height
    border.color: "#3F51B5"
    border.width: hovered ? 3 : 0

    signal doubleClicked(int row)
    readonly property alias hovered: mouseArea.containsMouse
    
    Rectangle {
        z: 1
        height: 1
        color: "#EEE"
        anchors.left: parent.left
        anchors.right: parent.right
        visible: !root.hovered
    }

    GridLayout {
        rows: 2
        columns: 2
        rowSpacing: 4
        columnSpacing: 0
        width: parent.width

        Text {
            text: score
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.row: 0
            Layout.column: 0
            Layout.rowSpan: 2
            Layout.preferredWidth: 80
            Layout.fillHeight: true
            font.pixelSize: 16
            font.family: Fonts.sourceSansProSemiBold
            color: "#3F51B5"
        }
        
        Text {
            color: "#000"
            Layout.row: 0
            Layout.column: 1
            Layout.fillWidth: true
            font.pixelSize: 16
            textFormat: Text.RichText
            font.family: Fonts.sourceSansPro
            wrapMode: Text.WordWrap
            topPadding: 16
            rightPadding: 8
            text: {
                if (url === '') return title;

                let domain = Utils.getDomainName(url);
                return `${title} <span style='color: #888; font-size: 14px'>(${domain})</span>`;
            }
        }

        Text {
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth: true
            rightPadding: 8
            bottomPadding: 16
            color: "#888"
            font.pixelSize: 14
            font.family: Fonts.sourceSansPro
            text: {
                let relTime = Utils.relativeTime(new Date(time * 1000));
                return `by ${by} ${relTime} | ${descendants} comments`;
            }
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: root
        hoverEnabled: true
        propagateComposedEvents: true
        onDoubleClicked: (event) => {
            root.doubleClicked(index);
            event.accepted = false;
        }
    }
}