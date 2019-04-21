#include "dbus.h"
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
#include <QNetworkConfigurationManager>
#include <QList>

typedef struct ConnectionList {
    QString type;
    QString name;
} LConnections;

Dbus::Dbus(QObject *parent) : QObject(parent)
{
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

void Dbus::getNetworkConfiguration() {
    QNetworkConfigurationManager qm;
    QList<QNetworkConfiguration> netcfgList = qm.allConfigurations();

    QList<LConnections> connections;

    for (auto &x : netcfgList) {
        if (x.bearerType() == QNetworkConfiguration::BearerWLAN) {
            qDebug () << "WLAN FOUND";
            LConnections item;
            item.name = x.name();
            item.type = "WIFI";

            connections.append(item);
        } else if (x.bearerType() == QNetworkConfiguration::BearerEthernet) {
            qDebug() << "Ethernet found";
            LConnections item;
            item.name = x.name();
            item.type = "eth0";

            connections.append(item);
        }

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

    return list[0];
}

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
    this->m_ip = this->getIp();
    this->m_hostname = this->getHostname();

    qDebug() << "class state:\t" << this->m_state;
    emit stateChanged();
    emit hostnameChanged();
    emit ipChanged();
}
