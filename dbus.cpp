#include "dbus.h"
#include <QDebug>
#include <QObject>

Dbus::Dbus(QObject *parent) : QObject(parent)
{
    m_state = 0;
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
