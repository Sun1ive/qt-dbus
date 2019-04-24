import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.2
import "getColor.js" as ColorFunc

ApplicationWindow {
    id: window
    width: Screen.desktopAvailableWidth
    height: 50
    minimumHeight: 50
    maximumHeight: Screen.desktopAvailableHeight
    visible: true
    flags: Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint | Qt.Window | Qt.Tool
    y: maximumHeight - minimumHeight;

//    Behavior on height {
//        PropertyAnimation {
//            easing: Easing.Linear
//            duration: 1500
//        }
//    }

//    Behavior on y {
//        PropertyAnimation {
//            easing: Easing.Linear
//            duration: 1500
//        }
//    }



    Text {
        id: hostnameText
        x: 22
        y: 13
        text: qsTr("Hostname: " + dbus.hostname);
    }

    Text {
        id: ipText
        x: 442
        y: 13
        text: qsTr("IP: " + dbus.ip)
    }

    Text {
        id: gatewayText
        x: 738
        y: 13
        text: qsTr("Gateway: " + dbus.gateway)
    }


    Text {
        id: macText
        x: 1090
        y: 13
        text: qsTr("Mac: " + dbus.mac)
    }


    Image {
        id: icon
        x: Screen.desktopAvailableWidth - (width + 10);
        y: 5
        source: "images/wifi.svg"
        width: 40
        height: 40
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

    Image {
        id: settingsIcon
        x: 1805
        y: 5
        width: 40
        height: 40
        smooth: true
        source: "images/settings.svg"

        MouseArea {
            anchors.fill: settingsIcon

            onClicked: {
                /*
                if (window.height === window.minimumHeight) {
//                if (window.maximumHeight === 50 && window.minimumHeight === 50) {
                    window.height = window.maximumHeight
                    window.y = 0;
//                    window.minimumHeight = Screen.desktopAvailableHeight
//                    window.minimumHeight = Screen.desktopAvailableHeight
                } else {
//                    window.maximumHeight = 50;
//                    window.minimumHeight = 50;
                    window.height = window.minimumHeight;
                    window.y = window.maximumHeight - window.minimumHeight;
                }
                */

                 var component = Qt.createComponent("menu.qml")
                 var newWindow = component.createObject(window);
                newWindow.show();
            }
        }
    }
/*
    Button {
        id: rebootBtn
        x: 1005
        y: 5
        text: qsTr("Reboot")
        onClicked: {
            //dbus.rebootDevice();
            rebootDialog.open();
        }
    }

    Popup {
        parent: ApplicationWindow.overlay
        x: 200
        y: 50
        width: 100
        height: 100
        modal: true
        focus: true
        id: rebootDialog

    }
    */
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

    Button {
        id: shutdownBtn
        x: 1176
        y: 5
        text: qsTr("Shutdown")
        onClicked: {
            //            dbus.shutdownDevice();
        }
    }
    */
}
