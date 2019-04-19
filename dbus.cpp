#include "dbus.h"
#include <QDebug>

Dbus::Dbus()
{

}

void Dbus::setState(const uint &state) {
    this->m_state = state;
}

uint Dbus::getNmState() {
    qDebug() << "Get nm state";
    return 70;
}
