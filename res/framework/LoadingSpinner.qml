import QtQuick 2.12
import "../style"

Text {
    color: "#555"
    text: Icons.faSpinner
    font.pixelSize: 60
    font.weight: Font.Bold
    font.family: Fonts.fontAwesomeIcons
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter

    readonly property alias loading: rotator.running

    function start() {
        rotator.start();
    }

    function stop() {
        rotator.stop();
    }

    RotationAnimator on rotation {
        id: rotator
        from: 0;
        to: 360;
        duration: 1500
        loops: Animation.Infinite
    }
}