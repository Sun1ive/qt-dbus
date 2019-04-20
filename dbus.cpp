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



Dbus::Dbus(QObject *parent) : QObject(parent)
{
    m_state = this->getCurrentNmState();
}

QString Dbus::getHostname() const {
    return QHostInfo::localHostName();
}

uint Dbus::getCurrentNmState() {
    QDBusConnection bus = QDBusConnection::systemBus();
    QDBusInterface dbus_interface("org.freedesktop.NetworkManager", "/org/freedesktop/NetworkManager",
                                  "org.freedesktop.NetworkManager", bus);
    QDBusMessage reply = dbus_interface.call("state");

    if (reply.type() == QDBusMessage::ReplyMessage)
    {
        qDebug() << reply.arguments().at(0).toString();
        return reply.arguments().at(0).toString().split(" ")[0].toUInt();
    }

    return 0;
}

QString Dbus::getIp() const {
    const QHostAddress &localhost = QHostAddress(QHostAddress::LocalHost);
    QList<QString> list;

    for (const QHostAddress &address: QNetworkInterface::allAddresses()) {
        if (address.protocol() == QAbstractSocket::IPv4Protocol && address != localhost) {
            list.append(address.toString());
        }
    }

    return list.at(0);
}

uint Dbus::getState() const {
  return m_state;
}

void Dbus::setState(const uint state) {
    qDebug() << "state changed:\t" << state;

    this->m_state = state;

    qDebug() << "class state:\t" << this->m_state;
    emit stateChanged();
}
