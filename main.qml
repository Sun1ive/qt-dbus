import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.5

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Network Manager status bar")

    Button {
        text: dbus.state
    }
}
