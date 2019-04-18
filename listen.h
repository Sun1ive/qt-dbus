#ifndef LISTEN_HH
#define LISTEN_HH

#include <QtCore>

class Listen : public QObject
{
    Q_OBJECT

public:
    Listen(QObject *parent=nullptr);

public slots:
    void stateChanged(uint state);
};

#endif
