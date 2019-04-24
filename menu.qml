import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

ApplicationWindow {
    id: menuWindow
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    flags: Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint | Qt.Window | Qt.Tool
    y: 0

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
        x: Screen.desktopAvailableWidth - 430;
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
    }

    Button {
        id: shutdownBtn
        x: 1490
        y: 251
        width: 231
        height: 40
        text: qsTr("Shutdown")
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


}
