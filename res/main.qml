import QtQuick 2.11
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import "framework" as Framework
import "fragment" as Fragment
import "style"

ColumnLayout {
    spacing: 0
    anchors.fill: parent

    Framework.Header {
        contents: [
            Framework.HeaderButton {
                text: "Top"
                actived: stack.currentIndex === 0
                onClicked: stack.currentIndex = 0
            },
            Framework.HeaderButton {
                text: "New"
                actived: stack.currentIndex === 1
                onClicked: stack.currentIndex = 1
            },
            Framework.HeaderButton {
                text: "Show"
                actived: stack.currentIndex === 2
                onClicked: stack.currentIndex = 2
            },
            Framework.HeaderButton {
                text: "Ask"
                actived: stack.currentIndex === 3
                onClicked: stack.currentIndex = 3
            },
            Framework.HeaderButton {
                text: "Jobs"
                actived: stack.currentIndex === 4
                onClicked: stack.currentIndex = 4
            },
            Rectangle {
                Layout.fillWidth: true
            },
            Framework.HeaderIconButton {
                symbol: Icons.faSyncAlt
                font.weight: Font.Bold
                tooltip: "Refresh data"
                onClicked: {
                    let fragmentList = stack.data[stack.currentIndex];
                    if (fragmentList.loading) return;
                    fragmentList.refreshData();
                }
            }
        ]
    }

    StackLayout {
        id: stack
        Layout.fillWidth: true
        Layout.fillHeight: true

        onCurrentIndexChanged: function() {
            if (currentIndex <= 4) data[currentIndex].loadData(1);
        }
        
        Fragment.StoryList {
            storiesType: "top"
        }

        Fragment.StoryList {
            storiesType: "new"
        }

        Fragment.StoryList {
            storiesType: "show"
        }

        Fragment.StoryList {
            storiesType: "ask"
        }

        Fragment.StoryList {
            storiesType: "jobs"
        }
    }
}