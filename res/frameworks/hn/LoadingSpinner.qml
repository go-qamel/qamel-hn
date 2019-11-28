import QtQuick 2.12
import "../../fonts/FontAwesome" as FA

Text {
    readonly property alias loading: rotator.running

    function start() {
        rotator.start();
    }

    function stop() {
        rotator.stop();
    }

    color: "#555"
    text: FA.Icons.faSpinner
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    font { pixelSize: 60; weight: Font.Bold; family: FA.Fonts.solid }

    RotationAnimator on rotation {
        id: rotator

        from: 0
        to: 360
        duration: 1500
        loops: Animation.Infinite
    }
}