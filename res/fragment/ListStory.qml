import QtQuick 2.12
import QtQuick.Layouts 1.12
import BackEnd 1.0
import "../framework" as Framework

Framework.FlatBase {
    id: root
    Component.onCompleted: {
        list.forceActiveFocus();
        loadData(1);
    }

    function loadData(page) {
        spinner.start();
        backEnd.loadData(page);
    }

    BackEndListStory {
        id: backEnd
        storiesType: "top"
        onLoaded: function(jsonData, maxPage) {
            spinner.stop();
            pagination.maxPage = maxPage;

            var data = JSON.parse(jsonData),
                nData = data.length;

            list.model.clear();
            data.forEach(item => list.model.append(item));
            list.positionViewAtBeginning();
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

    ColumnLayout {
        spacing: 0
        anchors.fill: parent
    
        Framework.Pagination {
            id: pagination
            Layout.fillWidth: true
            Layout.preferredHeight: 47
            Layout.alignment: Qt.AlignTop
            maxPage: 0
            visible: maxPage >= 1
            onCurrentPageChanged: root.loadData(currentPage)
        }

        Framework.StoryListView {
            id: list
            focus: true
            model: ListModel {}
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop
            visible: !spinner.loading
        }
    }
}