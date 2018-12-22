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