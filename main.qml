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
    y: Screen.desktopAvailableHeight
    Material.theme: Material.Dark

    Button {
        x: 908
        y: 5
        text: qsTr("Test")

        onClicked: {
            dbus.getNetworkConfiguration();
        }
    }

    Text {
        id: iptext
        x: 13
        y: 17
        text: qsTr("IP: " + dbus.ip)
    }

    Text {
        id: hostname
        x: 185
        y: 17
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
        x: 1163
        y: 17
        width: 50
        height: 17
        text: dbus.state
        color: "#000"
    }

    Image {
        id: icon
        x: Screen.desktopAvailableWidth - (width + 10);
        y: 5
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

    Button {
        id: rebootBtn
        x: 473
        y: 5
        text: qsTr("Reboot")
        onClicked: {
            dbus.rebootDevice();
        }
    }

    Button {
        id: shutdownBtn
        x: 595
        y: 5
        text: qsTr("Shutdown")
        onClicked: {
            dbus.shutdownDevice();
        }
    }
}
