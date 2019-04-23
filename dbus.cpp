#include "dbus.h"
#include "dbusip4vconfig.h"
#include <iostream>
#include <QDebug>
#include <QObject>
#include <QDBusConnection>
#include <QDBusMessage>
#include <QDBusInterface>
#include <QDBusReply>
#include <QHostAddress>
#include <QNetworkInterface>
#include <QHostInfo>
#include <QVariant>
#include <QException>
#include <QDBusMetaType>
#include <QNetworkConfigurationManager>
#include <QtEndian>

typedef struct ConnectionList {
    QString type;
    QString name;
} LConnections;

Dbus::Dbus(QObject *parent) : QObject(parent)
{
    qDBusRegisterMetaType<UIntListList>();
    this->m_state = this->getState();
    this->m_hostname = this->getHostname();
    this->m_ip = this->getIp();
}

void Dbus::rebootDevice() {
    QDBusConnection bus = QDBusConnection::systemBus();
    QDBusInterface dbus_interface("org.freedesktop.login1", "/org/freedesktop/login1",
                                  "org.freedesktop.login1.Manager", bus);
    QDBusMessage reply = dbus_interface.call("Reboot", true);

    if (reply.type() == QDBusMessage::ErrorMessage) {
        qCritical() << "W: " << reply.errorName() << ":" << reply.errorMessage();
    }
}

void Dbus::shutdownDevice() {
    QDBusConnection bus = QDBusConnection::systemBus();
    QDBusInterface dbus_interface("org.freedesktop.login1", "/org/freedesktop/login1",
                                  "org.freedesktop.login1.Manager", bus);

    QDBusMessage reply = dbus_interface.call("PowerOff", true);

    if (reply.type() == QDBusMessage::ErrorMessage) {
        qCritical() << "W: " << reply.errorName() << ":" << reply.errorMessage();
    }
}

QString Dbus::getHostname() const {
    return QHostInfo::localHostName();
}

QString Dbus::getIp() const {
    const QHostAddress &localhost = QHostAddress(QHostAddress::LocalHost);
    QList<QString> list;

    for (const QHostAddress &address: QNetworkInterface::allAddresses()) {
        if (address.protocol() == QAbstractSocket::IPv4Protocol && address != localhost) {
            list.append(address.toString());
        }
    }

    return list.empty() ? "Нет подключения" : list[0];
}



//QString Dbus::getIp() const {
//    try {
//    const QDBusConnection systemBus = QDBusConnection::systemBus();
//    QString service = "org.freedesktop.NetworkManager";
//    QString servicePath = "/org/freedesktop/NetworkManager";
//    QString activeConnectionIface = "org.freedesktop.NetworkManager.Connection.Active";
//    QString ipv4Iface = "org.freedesktop.NetworkManager.IP4Config";

//    //    QDBusInterface *iface = new QDBusInterface("org.freedesktop.NetworkManager", "/org/freedesktop/NetworkManager",
//    //                                               "org.freedesktop.NetworkManager", systemBus);



//    QDBusInterface *iface = new QDBusInterface(service, servicePath, service, systemBus);
//    QVariant reply = iface->property( "ActiveConnections" );
//    QDBusObjectPath DBusPath = reply.value<QList<QDBusObjectPath>>()[0];
//    QString connectionPath = DBusPath.path();

//    qDebug() << connectionPath;

//    QDBusInterface *ifaceActiveConnection = new QDBusInterface(service, connectionPath, activeConnectionIface, systemBus);
//    QVariant replyActiveConnection = ifaceActiveConnection->property("Ip4Config");
//    QDBusObjectPath DBusSettingsPath = replyActiveConnection.value<QDBusObjectPath>();
//    QString ipv4Path = DBusSettingsPath.path();

//    qDebug() << ipv4Path;

//    //    QDBusInterface *ifaceIpv4 = new QDBusInterface(service, ipv4Path, ipv4Iface, systemBus);

////    DBusIP4ConfigInterface *abstractConfig = new DBusIP4ConfigInterface(service, ipv4Path, systemBus);

////    QList<QList<uint>> addresses = abstractConfig->addresses();
//    /*
//    qDebug() << addresses[0][0];
//    qDebug() << addresses[0][1];
//    qDebug() << addresses[0][2];
//*/
//    //    qDebug() << addresses[0];




////    QHostAddress ip = QHostAddress(qFromBigEndian(addresses[0][0]));

////    qDebug() << ip;

//    /*
//    QVariant replyConnectionUuid = ifaceActiveConnection->property("Uuid");
//    QVariant replyConnectionType = ifaceActiveConnection->property("Type");

//    QString connectionType = replyConnectionType.toString();
//    QString connectionUuid = replyConnectionUuid.toString();

//    qDebug () << "TYPE: " << connectionType << " Uuid: " << connectionUuid;
//*/

////    return ip.toString();
////    return !addresses.empty() ? QHostAddress(qFromBigEndian(addresses[0][0])).toString() : "No connection";


//      } catch (QException error) {
//        qCritical() << "Error occured: " << error.what();
//    }

//    return "";

//}


uint Dbus::getState() const {
    QDBusConnection bus = QDBusConnection::systemBus();
    QDBusInterface dbus_interface("org.freedesktop.NetworkManager", "/org/freedesktop/NetworkManager",
                                  "org.freedesktop.NetworkManager", bus);

    QDBusMessage reply = dbus_interface.call("state");

    if (reply.type() == QDBusMessage::ReplyMessage)
    {
        return reply.arguments().at(0).toString().split(" ")[0].toUInt();
    }
    return 0;
}



void Dbus::setState(const uint state) {
    qDebug() << "state changed:\t" << state;

    this->m_state = state;
//    this->m_ip = this->getIp();
    this->m_hostname = this->getHostname();

    emit stateChanged();
    emit hostnameChanged();
    emit ipChanged();
}
