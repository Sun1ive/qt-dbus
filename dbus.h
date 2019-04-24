#ifndef DBUS_H
#define DBUS_H

#include <QObject>
#include "dbusip4vconfig.h"

class Dbus : public QObject
{
    Q_OBJECT
    Q_PROPERTY(uint state READ getState WRITE setState NOTIFY stateChanged)
    Q_PROPERTY(QString ip READ getIp NOTIFY ipChanged)
    Q_PROPERTY(QString hostname READ getHostname NOTIFY hostnameChanged)
    Q_PROPERTY(QString gateway READ getGateway NOTIFY gatewayChanged)
    Q_PROPERTY(QString mac READ getMac NOTIFY macChanged)
    Q_PROPERTY(QString domains READ getDomains NOTIFY domainsChanged)

public:
    explicit Dbus(QObject *parent = nullptr);
    DBusIP4ConfigInterface* getConfigInterface() const;
    bool checkActiveConnections() const;

public slots:
    uint getState() const;
    void setState(const uint state);
    QString getIp() const;
    QString getHostname() const;
    QString getMac() const;
    QString getGateway() const;
    QString getDomains() const;
    void rebootDevice();
    void shutdownDevice();

signals:
    void stateChanged();
    void ipChanged();
    void hostnameChanged();
    void macChanged();
    void gatewayChanged();
    void domainsChanged();

private:
    uint m_state;
    QString m_ip;
    QString m_hostname;
    QString m_mac;
    QString m_gateway;
    QString m_domains;
};


#endif // DBUS_H
