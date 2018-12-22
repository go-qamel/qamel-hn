import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import BackEnd 1.0
import "../framework" as Framework

Framework.FlatBase {
    id: root

    property int storyId
    property string storyURL
    readonly property alias loading: spinner.loading

    Component.onCompleted: backEnd.loadData(storyId)

    function loadData() {}

    function refreshData() {
        spinner.start();
        backEnd.loadData(storyId);
    }

    function openInBrowser() {
        if (storyURL === '') return;
        backEnd.openURL(storyURL);
    }

    BackEndStoryDetail {
        id: backEnd
        onLoaded: function(jsonData) {
            spinner.stop();

            let data = JSON.parse(jsonData),
                nComment = data.comments.length;

            root.storyURL = data.url;
            list.story = {
                by: data.by,
                title: data.title,
                url: data.url,
                time: data.time,
                score: data.score,
                text: data.text,
                descendants: data.descendants,
            }

            list.model.clear();
            for (let i = 0; i < nComment; i++) {
                let comment = data.comments[i],
                    kids = comment.kids || [],
                    parents = comment.parents || [];
                
                comment.content = comment.text;
                comment.nKids = kids.length;
                comment.parents = parents.join('|');
                comment.nParents = parents.length;
                delete comment.text;

                list.model.append(comment);
            }
        }
        onError: function(error) {
            console.error(error);
            spinner.stop();
        }
    }

    Framework.LoadingSpinner {
        id: spinner
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: loading
    }

    Framework.CommentListView {
        id: list
        model: ListModel {}
        anchors.fill: parent
        visible: !loading
        onLinkActivated: url => backEnd.openURL(url)
    }
}