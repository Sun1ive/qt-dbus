#ifndef DBUS_H
#define DBUS_H

#include <QObject>

class Dbus : public QObject
{
    Q_OBJECT
    Q_PROPERTY(uint state READ getState WRITE setState NOTIFY stateChanged)
    Q_PROPERTY(QString ip READ getIp NOTIFY ipChanged)
    Q_PROPERTY(QString hostname READ getHostname NOTIFY hostnameChanged)

public:
    explicit Dbus(QObject *parent = nullptr);

public slots:
    uint getState() const;
    void setState(const uint state);
    QString getIp() const;
    QString getHostname() const;
    void rebootDevice();
    void shutdownDevice();

signals:
    void stateChanged();
    void ipChanged();
    void hostnameChanged();

private:
    uint m_state;
    QString m_ip;
    QString m_hostname;
};


#endif // DBUS_H
