#include <iostream>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDBusInterface>
#include <QDBusConnection>
#include <QDBusArgument>
#include <QDebug>
#include <QDBusReply>
#include <QObject>
#include "listen.h"

using namespace std;


int main(int argc, char *argv[])
{

     if(!QDBusConnection::systemBus().isConnected()) {
        qCritical() << "Cannot connect to the D-Bus session bus!";
        return EXIT_FAILURE;
    }

    Listen l;

    QDBusConnection::systemBus().connect("org.freedesktop.NetworkManager", "/org/freedesktop/NetworkManager", "org.freedesktop.NetworkManager", "StateChanged",
                                          &l, SLOT(stateChanged(uint)));

// if (!QDBusConnection::systemBus().isConnected()) {
//    qCritical() << "Cannot connect to the D-Bus session bus.\n";
//    return EXIT_FAILURE;
//  }

// cout << "Hello" << endl;

// QDBusInterface iface("org.freedesktop.NetworkManager", "/org/freedesktop/NetworkManager", "org.freedesktop.NetworkManager",  QDBusConnection::systemBus());

// if (iface.isValid()) {
//     QDBusMessage reply = iface.call("state");
//     if (reply.type() == QDBusMessage::ReplyMessage) {
//         qDebug() << "Current network state\t" << reply.arguments().at(0).toString();
//         return EXIT_SUCCESS;
//     }
// }


//    QDBusConnection::systemBus().connect("org.freedesktop.NetworkManager", "/org/freedesktop/NetworkManager", "org.freedesktop.NetworkManager" ,"StateChanged", rec, SLOT(MySlot(uint)));


//    QDBusConnection bus = QDBusConnection::systemBus();
//    QDBusInterface dbus_interface("org.freedesktop.NetworkManager", "/org/freedesktop/NetworkManager",
//                                  "org.freedesktop.NetworkManager", bus);
//    QDBusMessage reply = dbus_interface.call("state");

//    cout << reply.type() << endl;

//    if (reply.type() == QDBusMessage::ReplyMessage)
//    {
//        qDebug() << reply.arguments().at(0).toString();
//    }




        qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

        QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

        QGuiApplication app(argc, argv);

        QQmlApplicationEngine engine;
        engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
        if (engine.rootObjects().isEmpty()) {
            return -1;
        }

        return app.exec();
//    return 0;
}
