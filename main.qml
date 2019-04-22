import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.2
import "getColor.js" as ColorFunc

Window {
    id: window
    width: Screen.desktopAvailableWidth
    height: 50
    visible: true
    minimumHeight: height;
    maximumHeight: height;
    maximumWidth: width;
    minimumWidth: width;
    flags: Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint | Qt.Window
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
            color: ColorFunc.getNmColor(dbus.state);
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
            //            dbus.rebootDevice();
            rebootDialog.open();
        }
    }

    Popup {
        parent: ApplicationWindow.overlay
        x: 200
        y: -500
        width: 100
        height: 100
        modal: true
        focus: true
        id: rebootDialog

    }
    /*
    MessageDialog {
        id: rebootDialog
        text: "Are you sure?"
        standardButtons: StandardButton.Yes | StandardButton.No
        icon: StandardIcon.Question


//        x: (window.width - width) / 2
//        y: (window.height - height) / 2
        Component.onCompleted:  {
            console.log(Screen.desktopAvailableWidth)
            console.log(Screen.desktopAvailableHeight)
        }
        onYes: {
            //			dbus.rebootDevice()
            console.log("Accepted")
        }
        onNo: {
            console.log("No button pressed")
            //            this.close();
        }
    }
*/
    Button {
        id: shutdownBtn
        x: 595
        y: 5
        text: qsTr("Shutdown")
        onClicked: {
            //            dbus.shutdownDevice();
        }
    }
}
