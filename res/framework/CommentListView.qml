import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../style"
import "../script/utils.js" as Utils

ListView {
    id: root
    model: ListModel{}
    boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: ScrollBar {}

    property var story
    property var collapsed: []
    signal linkActivated(string url)

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

    footer: Rectangle {
        height: 32
        width: parent.width
        color: "transparent"
    }

    header: CommentListViewHeader {
        story: root.story
        onLinkActivated: url => root.linkActivated(url)
    }

    delegate: CommentListViewRow {
        isLastRow: index === root.model.count - 1
        height: visible ? defaultHeight : 0
        repliesCollapsed: root.collapsed.indexOf(id) !== -1
        visible: {
            let isCollapsed = parents.split('|')
                .map(str => parseInt(str, 10))
                .some(parentId => {
                    return root.collapsed.indexOf(parentId) !== -1;
                });

            return !isCollapsed;
        }
        onToggleReplies: (row) => {
            let id = root.model.get(row).id,
                idx = root.collapsed.indexOf(id)
                collapsed = root.collapsed;

            if (idx === -1) collapsed.push(id);
            else collapsed.splice(idx, 1);

            root.collapsed = collapsed;
        }
        onLinkActivated: url => root.linkActivated(url)
    }
}