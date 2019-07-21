import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import BackEnd 1.0 as BackEnd
import Qamel 1.0 as Qamel
import "../frameworks/hn" as HN

HN.Background {
    id: root

    property int storyId
    property string storyURL
    readonly property alias loading: spinner.loading

    function openInBrowser() {
        if (storyURL === '') return;
        backEnd.openURL(storyURL);
    }

    function loadData() {
        spinner.start();
        backEnd.loadData(storyId);
    }

    Component.onCompleted: loadData()

    BackEnd.StoryDetail {
        id: backEnd

        function _onError(error) {
            console.error(error);
            spinner.stop();
        }

        function _onLoaded(jsonValue) {
            spinner.stop();


            let data = JSON.parse(jsonValue),
                story = data.story,
                comments = data.comments;

            list.story = story;
            list.model.contents = comments;
            root.storyURL = story.url;

            list.positionViewAtBeginning();
            list.forceActiveFocus();
        }

        onError: (err) => _onError(err)
        onLoaded: (jsonValue) => _onLoaded(jsonValue)
    }

    HN.LoadingSpinner {
        id: spinner
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: loading
    }

    HN.CommentListView {
        id: list

        property var story: {}
        property var collapsed: []

        visible: !loading
        anchors.fill: parent
        model: Qamel.ListModel {}

        header: HN.CommentListViewHeader {
            story: list.story
            onLinkActivated: (url) => backEnd.openURL(url)
        }

        delegate: HN.CommentListViewRow {
            function _visible() {
                if (index < 0) return true;

                let parents = list.model.get(index).parents,
                    isCollapsed = parents.some(parentId => {
                    return list.collapsed.indexOf(parentId) !== -1;
                });

                return !isCollapsed;
            }

            function _isLastRow() {
                if (index < 0) return false;
                return index === list.model.count() - 1;
            }

            function _repliesCollapsed() {
                if (index < 0) return false;
                let id = list.model.get(index).id;
                return list.collapsed.indexOf(id) !== -1;
            }

            function _onToggleReplies(row) {
                let id = list.model.get(row).id,
                    idx = list.collapsed.indexOf(id),
                    collapsed = list.collapsed;

                if (idx === -1) collapsed.push(id);
                else collapsed.splice(idx, 1);

                list.collapsed = collapsed;
            }

            comment: display
            visible: _visible()
            isLastRow: _isLastRow()
            repliesCollapsed: _repliesCollapsed()
            onToggleReplies: (row) => _onToggleReplies(row)
            onLinkActivated: (url) => backEnd.openURL(url)
            height: visible ? defaultHeight : 0
        }
    }
}