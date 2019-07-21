import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ListView {
    id: root

    function _pageUp() {
        let newY = contentY - height;
        if (newY < 0) positionViewAtBeginning();
        else contentY = newY;
    }

    function _pageDown() {
        let newY = contentY + height;
        if (newY > contentHeight - height) positionViewAtEnd();
        else contentY = newY;
    }

    boundsBehavior: Flickable.StopAtBounds

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
                root._pageUp();
                break;
            }
            case Qt.Key_PageDown: {
                root._pageDown();
                break;
            }
        }
    }

    footer: Rectangle {
        height: 32
        width: parent.width
        color: "transparent"
    }
}