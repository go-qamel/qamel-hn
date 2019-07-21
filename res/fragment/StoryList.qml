import QtQuick 2.12
import QtQuick.Layouts 1.12
import BackEnd 1.0 as BackEnd
import "../frameworks/hn" as HN

HN.Background {
    id: root
    property string storiesType
    readonly property alias loading: spinner.loading

    signal openStory(int id)

    function openInBrowser() {
        backEnd.openURL();
    }

    function refreshData() {
        backEnd.clearCache();
        loadData(1);
    }

    function loadData(page) {
        spinner.start();
        backEnd.loadData(page);
        pagination.currentPage = page;
    }

    BackEnd.StoryList {
        id: backEnd
        storiesType: root.storiesType
        onLoaded: function(jsonData, maxPage) {
            spinner.stop();
            pagination.maxPage = maxPage;

            let data = JSON.parse(jsonData),
                nData = data.length;

            list.model.clear();
            data.forEach(item => list.model.append(item));
            list.positionViewAtBeginning();
            list.forceActiveFocus();
        }
        onError: function(error) {
            console.error(error);
            spinner.stop();
        }
    }

    HN.LoadingSpinner {
        id: spinner
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: loading
    }

    ColumnLayout {
        spacing: 0
        anchors.fill: parent
    
        HN.Pagination {
            id: pagination
            Layout.fillWidth: true
            Layout.preferredHeight: 47
            Layout.alignment: Qt.AlignTop
            maxPage: 1
            visible: maxPage >= 1
            enabled: !root.loading
            onCurrentPageChanged: root.loadData(currentPage)
        }

        HN.StoryListView {
            id: list
            focus: true
            model: ListModel {}
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop
            visible: !spinner.loading

            delegate: HN.StoryListViewRow {
                width: Math.min(800, parent.width - 60)
                anchors.horizontalCenter: parent.horizontalCenter
                onDoubleClicked: (row) => root.openStory(list.model.get(row).id)
            }
        }
    }
}