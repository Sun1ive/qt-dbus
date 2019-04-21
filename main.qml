import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.3

Window {
    id: window
    width: Screen.desktopAvailableWidth
    height: 50
    visible: true
    minimumHeight: height;
    maximumHeight: height;
    maximumWidth: width;
    minimumWidth: width;
    flags: Qt.FramelessWindowHint | Qt.Window
    y: Screen.desktopAvailableHeight - height
    title: qsTr("Network Manager status bar")

    Button {
        x: 617
        y: 5
        text: qsTr("Test")
        Material.theme: Material.Dark
        Material.accent: Material.Purple

        onClicked: {
            dbus.getNetworkConfiguration();
        }
    }

    Text {
        id: iptext
        x: 0
        y: 17
//        text: qsTr("IP: " + dbus.getIp())
        text: qsTr("IP: " + dbus.ip)
    }

    Text {
        id: hostname
        x: 197
        y: 17
//        text: qsTr("Hostname: " + dbus.getHostname())
        text: qsTr("Hostname: " + dbus.hostname);
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
        x: 789
        y: 10
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
