import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../../script/utils.js" as Utils
import "../../fonts/SourceSansPro" as SSP
import "." as HN

Rectangle {
    id: root

    property bool isLastRow: false
    property bool repliesCollapsed: false
    readonly property int defaultHeight: childrenRect.height
    property var comment: {
        "id": 0,
        "by": "",
        "text": "",
        "time": 0,
        "parent": "",
        "parents": [],
        "kids": [],
        "descendants": 0,
        "dead": false,
    }

    signal toggleReplies(int index)
    signal linkActivated(string url)

    color: "#FFF"
    height: childrenRect.height
    width: Math.min(800, parent.width - 60)
    anchors.horizontalCenter: parent.horizontalCenter

    ColumnLayout {
        spacing: 10
        width: parent.width
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.leftMargin: (root.comment.parents.length - 1) * 24 + 16

        Text {
            function _text() {
                let comment = root.comment,
                    relTime = Utils.relativeTime(new Date(comment.time * 1000)),
                    text = `${comment.by} ${relTime}`;

                if (comment.dead) text += ` (dead)`
                return text;
            }

            text: _text()
            color: "#888"
            Layout.topMargin: 8
            Layout.fillWidth: true
            font { pixelSize: 14; family: SSP.Fonts.regular }
        }

        TextArea {
            function _text() {
                return `<style>
                    * {line-height: 1.2} 
                    a {color: "#3F51B5"}
                    pre {line-height: 1; font-size: 14px}
                    </style> ${root.comment.text}`
            }

            function _visible() {
                return root.comment.text.trim() !== "";
            }

            function _color() {
                return root.comment.dead ? "#888" : "#000";
            }

            topPadding: 0
            leftPadding: 0
            rightPadding: 0
            bottomPadding: 0
            background: null
            Layout.fillWidth: true
            text: _text()
            readOnly: true
            visible: _visible()
            selectByMouse: true
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            color: _color()
            selectionColor: "#1A237E"
            selectedTextColor: "#FFF"
            font { pixelSize: 16; family: SSP.Fonts.regular }
            onLinkActivated: (url) => root.linkActivated(url)
        }

        RowLayout {
            spacing: 4
            Layout.fillWidth: true
            Layout.topMargin: root.comment.descendants > 0 ? 4 : 8 
            Layout.bottomMargin: 8

            HN.CommentListViewButton {
                function _text() {
                    if (!root.repliesCollapsed) return `[ - ]`;
                    return `[ + ] ${root.comment.descendants} replies collapsed`;
                }

                function _visible() {
                    return root.comment.descendants > 0;
                }

                text: _text()
                visible: _visible()
                onClicked: root.toggleReplies(index)
            }
            
            Rectangle {
                color: root.isLastRow ? "transparent" : "#DDD"
                Layout.fillWidth: true
                Layout.maximumHeight: 1
                Layout.preferredHeight: 1
            }
        }
    }
}