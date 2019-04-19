#include "listen.h"

Listen::Listen(QObject *parent)
    : QObject(parent)
{
    qDebug() << __PRETTY_FUNCTION__;
}

uint Listen::getState() {
    qDebug() << "current state\t" << this->state;
    return this->state;
}

void Listen::stateChanged(uint state) {
    qDebug() << "NM State changed " << state;

    this->state = state;


    qDebug() << "NM State changed " << this->state;
}
