#ifndef DBUS_H
#define DBUS_H

#include <QObject>

class Dbus : public QObject
{
    Q_OBJECT
    Q_PROPERTY(uint state READ getState WRITE setState NOTIFY stateChanged)

public:
    explicit Dbus(QObject *parent = nullptr);
    uint getCurrentNmState();

public slots:
    uint getState() const;
    void setState(const uint state);
    void getNetworkConfiguration();
    QString getIp() const;
    QString getHostname() const;

signals:
    void stateChanged();

private:
    uint m_state;
};


#endif // DBUS_H
