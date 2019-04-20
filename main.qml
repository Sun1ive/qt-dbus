import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Window {
    id: window
    visible: true
    width: 900
    height: 50
    title: qsTr("Network Manager status bar")

    Text {
        id: iptext
        x: 0
        y: 17
        text: qsTr("IP: " + dbus.getIp())
    }

    Text {
        id: hostname
        x: 197
        y: 17
        text: qsTr("Hostname: " + dbus.getHostname())
    }

    function getNmColor(value) {
        var color = "";

        switch (+value) {
        case 20:
            color = "red"
            break;
        case 40:
            color = "yellow"
            break;
        case 60:
            color = "yellow"
            break;
        case 70:
            color = "green"
            break;
        default:
            color = "#000";
            break;
        }

        return color;
    }

    Text {
        id: nmstatetext
        x: 859
        y: 75
        width: 50
        height: 20
        text: dbus.state
        color: "#000"
    }

    Image {
        id: icon
        x: 845
        y: 0
        source: "images/wifi.svg"
        width: window.height - 10
        height: window.height - 10
        smooth: true

        ColorOverlay {
            anchors.fill: icon
            source: icon
            color: getNmColor(dbus.state);
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
        }


    }
}
