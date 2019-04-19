import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.5

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

     Button {
       text: "Hello"
       onClicked: {
           console.log(dbus.state);
           console.log("CLICKED");
//           console.log(l.getState());
           l.getState();
       }
   }

}
