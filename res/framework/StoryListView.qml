import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5

ListView {
    id: root
    boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: ScrollBar {}

    Keys.onPressed: function(event) {
        switch (event.key) {
            case Qt.Key_Home: {
                root.positionViewAtBeginning();
                break;
            }
            case Qt.Key_End: {
                root.positionViewAtEnd();
                break;
            }
            case Qt.Key_PageUp: {
                let newY = root.contentY - root.height;
                if (newY < 0) root.positionViewAtBeginning();
                else root.contentY = newY;
                break;
            }
            case Qt.Key_PageDown: {
                let newY = root.contentY + root.height;
                if (newY > root.contentHeight - root.height) root.positionViewAtEnd();
                else root.contentY = newY;
                break;
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        anchors.topMargin: root.headerItem == null ? 0 : root.headerItem.height
        propagateComposedEvents: true
        onClicked: function(event) {
            root.forceActiveFocus();
            event.accepted = false;
        }
    }

    header: Rectangle {
        height: 32
        width: parent.width
        color: "transparent"
    }

    footer: Rectangle {
        height: 32
        width: parent.width
        color: "transparent"
    }

    delegate: StoryListViewRow {
        width: Math.min(800, parent.width - 60)
        anchors.horizontalCenter: parent.horizontalCenter
    }
}