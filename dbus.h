#ifndef DBUS_H
#define DBUS_H

#include <QObject>

class Dbus : public QObject
{
    Q_OBJECT
    Q_PROPERTY(uint state READ getState WRITE setState NOTIFY stateChanged)

public:
    Dbus();
    uint getState() const {return m_state;}
    void setState(const uint &state);

public slots:
    uint getNmState();

signals:
    void stateChanged(uint state);

private:
    uint m_state;
};



#endif // DBUS_H
