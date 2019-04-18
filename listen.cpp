#include "listen.h"

Listen::Listen(QObject *parent)
    : QObject(parent)
{
    qDebug() << __PRETTY_FUNCTION__;
}

void Listen::stateChanged(uint state) {
    qDebug() << "NM State changed " << state;
}
