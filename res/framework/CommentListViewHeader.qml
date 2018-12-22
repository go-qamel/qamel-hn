import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import "../style"
import "../script/utils.js" as Utils

Rectangle {
    color: "transparent"
    width: parent.width
    height: childrenRect.height + 20
    
    property var story
    signal linkActivated(string url)

    Rectangle {
        color: "#FFF"
        width: parent.width
        height: parent.height - 20
        layer.enabled: true
        layer.effect: DropShadow {
            verticalOffset: 2
            transparentBorder: true
            radius: 3
            samples: 7
            color: "#DDD"
        }
    }

    ColumnLayout {
        width: Math.min(800, parent.width - 60)
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            color: "#000"
            Layout.fillWidth: true
            textFormat: Text.RichText
            font.pixelSize: 22
            font.family: Fonts.sourceSansProSemiBold
            wrapMode: Text.WordWrap
            topPadding: 20
            bottomPadding: 8
            text: {
                let story = root.story || {},
                    title = story.title || '',
                    url = story.url || '',
                    domain = url ? Utils.getDomainName(url) : '';

                if (url === '') return title;
                return `${title} <span style='color: #888; font-size: 14px;'>(${domain})</span>`;
            }
        }

        Text {
            color: "#888"
            Layout.fillWidth: true
            font.pixelSize: 15
            font.family: Fonts.sourceSansPro
            text: {
                let story = root.story || {},
                    score = story.score || 0,
                    by = story.by || '',
                    time = story.time || 0,
                    relTime = Utils.relativeTime(new Date(time * 1000)),
                    descendants = story.descendants || 0;

                return `${score} points | by ${by} ${relTime} | ${descendants} comments`;
            }
        }

        TextArea {
            color: "#000"
            selectionColor: "#1A237E"
            selectedTextColor: "#FFF"
            leftPadding: 0
            rightPadding: 0
            topPadding: 8
            bottomPadding: 0
            background: null
            Layout.fillWidth: true
            font.pixelSize: 16
            textFormat: Text.RichText
            font.family: Fonts.sourceSansPro
            wrapMode: Text.WordWrap
            readOnly: true
            selectByMouse: true
            text: {
                let story = root.story || {},
                    content = story.text || '';
                
                if (content === '') return '';
                return `<style>
                    * {line-height: 1.2} 
                    a {color: "#3F51B5"} 
                    pre {line-height: 1; font-size: 14px}
                    </style> ${content}`
            }
            visible: {
                let story = root.story || {},
                    content = story.text || '';
                return content !== '';
            }
            onLinkActivated: url => root.linkActivated(url)
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 20
        }
    }
}