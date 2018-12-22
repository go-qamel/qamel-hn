import QtQuick 2.11
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "../style"
import "../framework" as Framework

Rectangle {
    z: 1
    color: "#3F51B5"
    Layout.fillWidth: true
    Layout.preferredHeight: 55

    property alias contents: row.data

    RowLayout {
        id: row
        spacing: 30
        width: Math.min(800, parent.width - 60)
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}