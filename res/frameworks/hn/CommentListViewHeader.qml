import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import "../../script/utils.js" as Utils
import "../../fonts/SourceSansPro" as SSP

Rectangle {
    id: root

    property var story

    signal linkActivated(string url)

    color: "transparent"
    width: parent.width
    height: childrenRect.height + 20

    Rectangle {
        color: "#FFF"
        width: parent.width
        height: parent.height - 20
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 3
            samples: 7
            color: "#DDD"
            verticalOffset: 2
            transparentBorder: true
        }
    }

    ColumnLayout {
        width: Math.min(800, parent.width - 60)
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            function _text() {
                let story = root.story || {},
                    url = story.url || "",
                    title = story.title || "",
                    domain = url ? Utils.getDomainName(url) : "";

                if (url === "") return title;
                return `${title} <span style="color: #888; font-size: 14px;">(${domain})</span>`;
            }
    
            text: _text()
            color: "#000"
            topPadding: 20
            bottomPadding: 8
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            font { pixelSize: 22; family: SSP.Fonts.semiBold }
        }

        Text {
            function _text() {
                let story = root.story || {},
                    by = story.by || "",
                    time = story.time || 0,
                    score = story.score || 0,
                    relTime = Utils.relativeTime(new Date(time * 1000)),
                    descendants = story.descendants || 0;

                return `${score} points | by ${by} ${relTime} | ${descendants} comments`;
            }

            text: _text()
            color: "#888"
            Layout.fillWidth: true
            font { pixelSize: 15; family: SSP.Fonts.regular }
        }

        TextArea {
            function _text() {
                let story = root.story || {},
                    content = story.text || "";
                
                if (content === "") return "";
                return `<style>
                    * {line-height: 1.2} 
                    a {color: "#3F51B5"} 
                    pre {line-height: 1; font-size: 14px}
                    </style> ${content}`
            }

            function _visible() {
                let story = root.story || {},
                    content = story.text || "";
                return content !== "";
            }

            topPadding: 8
            leftPadding: 0
            rightPadding: 0
            bottomPadding: 0
            background: null
            Layout.fillWidth: true
            text: _text()
            readOnly: true
            selectByMouse: true
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            visible: _visible()
            color: "#000"
            selectionColor: "#1A237E"
            selectedTextColor: "#FFF"
            font { pixelSize: 16; family: SSP.Fonts.regular }
            onLinkActivated: (url) => root.linkActivated(url)
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 20
        }
    }
}