import QtQuick 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.2
import "getColor.js" as ColorFunc

ApplicationWindow {
    id: window
    width: Screen.desktopAvailableWidth
    minimumHeight: window.panelHeight
    maximumHeight: window.windowAvailableHeight
    visible: true
    flags: Qt.FramelessWindowHint | Qt.Tool | Qt.WA_TranslucentBackground
    color: "#00000000"
    y: maximumHeight - minimumHeight
    height: minimumHeight

    property alias f: footer

    readonly property bool isContentOpened: content.height === window.maximumHeight
                                            - window.minimumHeight
    readonly property bool isContentClosed: content.height === 0

    property bool nextOpen: true

    readonly property int panelHeight: 50
    readonly property int windowAvailableHeight: Screen.desktopAvailableHeight

    onIsContentOpenedChanged: {
        console.log('Content opened', isContentOpened)
        if (isContentOpened) {

        }
    }

    onIsContentClosedChanged: {
        console.log('Content closed', isContentClosed)
        if (isContentClosed) {
            window.y = window.maximumHeight - window.minimumHeight
            window.height = maximumHeight - y
        }
    }

    onHeightChanged: {
        console.log('height', height)
    }

    Rectangle {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right
        height: 0
        y: parent.height - height
        color: 'red'

        Behavior on height {
            PropertyAnimation {
                duration: 500
            }
        }
    }

    footer: Rectangle {
        id: footer
        height: window.panelHeight
        color: "#c0c0c0"

        Behavior on height {
            PropertyAnimation {
                duration: 500
            }
        }

        onHeightChanged: {
            if (height === 0) {
                console.log(height)
                var component = Qt.createComponent("menu.qml")
                if (component.status === Component.Ready) {
                    var newWindow = component.createObject(parent)
                    newWindow.show()
                }
            } else {
                console.log(height)
            }
        }

        Text {
            id: hostnameText
            x: 22
            y: 13
            text: qsTr("Hostname: " + dbus.hostname)
            font.pointSize: 13
        }

        Text {
            id: ipText
            x: 442
            y: 13
            text: qsTr("IP: " + dbus.ip)
            font.pointSize: 13
        }

        Text {
            id: gatewayText
            x: 738
            y: 13
            text: qsTr("Gateway: " + dbus.gateway)
            font.pointSize: 13
        }

        Text {
            id: domainsText
            x: 1356
            y: 13
            text: qsTr("Domains: " + dbus.domains)
            font.pointSize: 13
        }

        Text {
            id: macText
            x: 1090
            y: 13
            text: qsTr("Mac: " + dbus.mac)
            font.pointSize: 13
        }

        Image {
            id: icon
            x: Screen.desktopAvailableWidth - (width + 10)
            y: 5
            source: "images/wifi.svg"
            width: 40
            height: 40
            smooth: true

            ColorOverlay {
                anchors.fill: icon
                source: icon
                color: ColorFunc.getNmColor(dbus.state)
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
                //                onClicked: {
                //                    if (!window.nextOpen) {
                //                        content.height = 0
                //                        window.nextOpen = true
                //                    } else {
                //                        window.y = 0
                //                        window.height = maximumHeight - y
                //                        content.height = window.maximumHeight - window.minimumHeight
                //                        window.nextOpen = false
                //                    }
                //                }
                onClicked: {
                    footer.height = 0
                }
            }
        }
    }
}
