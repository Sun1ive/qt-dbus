import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.5

Window {
    id: window
    visible: true
    width: 500
    height: 200
    title: qsTr("Network Manager status bar")

    Button {
        id: dbusstate
        text: dbus.state
        onClicked: {
            console.log(dbus.getIp());
        }
    }

//    Rectangle {
//        width: parent.width
//        height: parent.height

//        Image {
//            id: icon
//            source: "images/wifi.svg"
//            height: 50
//            width: 50
//        }
//    }
}
