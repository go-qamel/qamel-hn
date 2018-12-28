import QtQuick 2.12
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
            Framework.HeaderLogo {
                visible: stack.currentIndex <= 4
            },
            Framework.HeaderIconButton {
                id: btnBack
                symbol: Icons.faArrowLeft
                font.weight: Font.Bold
                tooltip: "Back"
                visible: stack.currentIndex > 4
                onClicked: stack.currentIndex = prevIndex
                property int prevIndex
            },
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
                    let fragment = stack.data[stack.currentIndex];
                    if (fragment.loading) return;
                    fragment.refreshData();
                }
            },
            Framework.HeaderIconButton {
                symbol: Icons.faGlobe
                font.weight: Font.Bold
                tooltip: "Open in browser"
                onClicked: {
                    let fragment = stack.data[stack.currentIndex];
                    fragment.openInBrowser();
                }
            }
        ]
    }

    StackLayout {
        id: stack
        Layout.fillWidth: true
        Layout.fillHeight: true
        onCurrentIndexChanged: {
            if (count > 5 && currentIndex <= 4) {
                for (let i = 5; i < count; i++) {
                    data[i].destroy();
                }
            }

            if (currentIndex <= 4 && count <= 5) data[currentIndex].loadData(1);
        }

        function openStory(id) {
            var fragment = Qt.createComponent("fragment/StoryDetail.qml")
                             .createObject(stack, {storyId: id});
            
            btnBack.prevIndex = stack.currentIndex;
            stack.currentIndex = stack.count - 1;
        }
        
        Fragment.StoryList {
            storiesType: "top"
            onOpenStory: id => stack.openStory(id)
        }

        Fragment.StoryList {
            storiesType: "new"
            onOpenStory: id => stack.openStory(id)
        }

        Fragment.StoryList {
            storiesType: "show"
            onOpenStory: id => stack.openStory(id)
        }

        Fragment.StoryList {
            storiesType: "ask"
            onOpenStory: id => stack.openStory(id)
        }

        Fragment.StoryList {
            storiesType: "jobs"
            onOpenStory: id => stack.openStory(id)
        }
    }
}