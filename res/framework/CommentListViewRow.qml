import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../style"
import "../script/utils.js" as Utils

Rectangle {
    id: root
    color: "#FFF"
    height: childrenRect.height
    width: Math.min(800, parent.width - 60)
    anchors.horizontalCenter: parent.horizontalCenter

    property bool isLastRow: false
    property bool repliesCollapsed: false
    property int defaultHeight: childrenRect.height
    signal toggleReplies(int index)
    signal linkActivated(string url)

    ColumnLayout {
        spacing: 10
        width: parent.width
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.leftMargin: (nParents - 1) * 24 + 16

        Text {
            color: "#888"
            font.pixelSize: 14
            Layout.topMargin: 8
            font.family: Fonts.sourceSansPro
            text: {
                let relTime = Utils.relativeTime(new Date(time * 1000));
                return `${by} ${relTime}`;
            }
        }

        TextArea {
            color: "#000"
            selectionColor: "#1A237E"
            selectedTextColor: "#FFF"
            leftPadding: 0
            rightPadding: 0
            topPadding: 0
            bottomPadding: 0
            background: null
            Layout.fillWidth: true
            font.pixelSize: 16
            textFormat: Text.RichText
            font.family: Fonts.sourceSansPro
            wrapMode: Text.WordWrap
            readOnly: true
            selectByMouse: true
            text: `<style>
                * {line-height: 1.2} 
                a {color: "#3F51B5"}
                pre {line-height: 1; font-size: 14px}
                </style> ${content}`
            onLinkActivated: url => root.linkActivated(url)
        }

        RowLayout {
            spacing: 4
            Layout.fillWidth: true
            Layout.topMargin: nKids > 0 ? 4 : 8 
            Layout.bottomMargin: 8

            CommentListViewButton {
                text: root.repliesCollapsed ? `[ + ] ${descendants} replies collapsed` : `[ - ]`
                onClicked: root.toggleReplies(index)
                visible: nKids > 0
            }
            
            Rectangle {
                color: root.isLastRow ? "transparent" : "#DDD"
                Layout.maximumHeight: 1
                Layout.preferredHeight: 1
                Layout.fillWidth: true
            }
        }
    }
}