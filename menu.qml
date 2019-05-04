import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: menuWindow
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    flags: Qt.FramelessWindowHint | Qt.Tool | Qt.WA_TranslucentBackground
    color: "#00000000"

    readonly property int maxHeight: Screen.desktopAvailableHeight

    Component.onCompleted: {
        content.height = maxHeight
        content.opacity = 1
    }

    header: Rectangle {
        id: content
        height: 0
        opacity: 0
        y: maxHeight / 2
        color: "#fff"

        Behavior on height {
            PropertyAnimation {
                duration: 500
            }
        }

        Behavior on opacity {
            PropertyAnimation {
                duration: 500
            }
        }

        onHeightChanged: {
            if (height === 0) {
                menuWindow.close()
                f.height = 50
            }
        }

        onOpacityChanged: {
            if (content.opacity === 1) {
                inside.opacity = 1
                return
            }
        }

        Rectangle {
            id: inside
            anchors.fill: parent
            opacity: 0
            height: maxHeight

            Behavior on opacity {
                PropertyAnimation {
                    duration: 1000
                }
            }

            onOpacityChanged: {
                if (opacity === 0) {
                    content.height = 0
                }
            }

            Text {
                id: systemDetails
                x: 130
                y: 66
                width: 231
                height: 40
                text: qsTr("System details")
                font.pixelSize: 30
            }

            Text {
                id: systemActions
                x: Screen.desktopAvailableWidth - 430
                y: 66
                width: 231
                height: 40
                text: qsTr("System actions")
                font.pixelSize: 30
            }

            Button {
                id: rebootBtn
                x: 1490
                y: 177
                width: 231
                height: 40
                text: qsTr("Reboot")
                onClicked: {
                    rebootDialog.visible = true
                }
            }

            Button {
                id: shutdownBtn
                x: 1490
                y: 251
                width: 231
                height: 40
                text: qsTr("Shutdown")
                onClicked: {
                    shutdownDialog.visible = true
                }
            }

            MessageDialog {
                id: rebootDialog
                title: "Are you sure?"
                text: "Do you want to reboot device?"
                visible: false
                icon: StandardIcon.Question
                standardButtons: StandardButton.Yes | StandardButton.No
                width: 500
                height: 200
                onYes: {
                    console.log("ON YES")
                }
                onNo: {
                    console.log("ON NO")
                }
            }

            MessageDialog {
                id: shutdownDialog
                title: "Are you sure?"
                text: "Do you want to shutdown device?"
                visible: false
                icon: StandardIcon.Question
                standardButtons: StandardButton.Yes | StandardButton.No
                width: 500
                height: 200
                onYes: {
                    console.log("ON YES")
                }
                onNo: {
                    console.log("ON NO")
                }
            }

            Text {
                id: hostname
                x: 58
                y: 180
                text: qsTr("Hostname:\t" + dbus.hostname)
                font.pixelSize: 24
            }

            Text {
                id: ipAddress
                x: 58
                y: hostname.y + 50
                text: qsTr("IP:\t\t" + dbus.ip)
                font.pixelSize: 24
            }

            Text {
                id: gateway
                x: 58
                y: ipAddress.y + 50
                text: qsTr("Gateway:\t" + dbus.gateway)
                font.pixelSize: 24
            }

            Text {
                id: macAddress
                x: 58
                y: gateway.y + 50
                text: qsTr("MAC:\t\t" + dbus.mac)
                font.pixelSize: 24
            }

            Text {
                id: domainsText
                x: 58
                y: macAddress.y + 50
                text: qsTr("Domains:\t" + dbus.domains)
                font.pixelSize: 24
            }

            Image {
                id: image
                x: Screen.desktopAvailableWidth - 80
                y: 14
                width: 60
                height: 60
                smooth: true
                source: "images/close.svg"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    width: parent.width
                    height: parent.height
                    onClicked: {
                        inside.opacity = 0
                        //                        menuWindow.close()
                        //                        f.height = 50
                    }
                }
            }
        }
    }
}
