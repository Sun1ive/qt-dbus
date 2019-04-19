#include "dbus.h"
#include <QDebug>
#include <QObject>
#include <QDBusConnection>
#include <QDBusMessage>
#include <QDBusInterface>

Dbus::Dbus(QObject *parent) : QObject(parent)
{
    m_state = this->getCurrentNmState();
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

uint Dbus::getState() const {
  return m_state;
}

void Dbus::setState(const uint state) {
    qDebug() << "state changed:\t" << state;

    this->m_state = state;

    qDebug() << "class state:\t" << this->m_state;
    emit stateChanged();
}
