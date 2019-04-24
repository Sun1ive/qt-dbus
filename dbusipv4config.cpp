#include <dbusip4vconfig.h>
#include <QDBusAbstractInterface>
#include <QDBusMetaType>
#include <QDebug>
#include <QHostInfo>

DBusIP4ConfigInterface::DBusIP4ConfigInterface(const QString &service, const QString &path, const QDBusConnection &connection,QObject *parent)
    : QDBusAbstractInterface(service, path, "org.freedesktop.NetworkManager.IP4Config", connection, parent)
{
    qDBusRegisterMetaType<UIntListList>();
}

DBusIP4ConfigInterface::~DBusIP4ConfigInterface() {};


UIntListList DBusIP4ConfigInterface::addresses() const
{
    return qvariant_cast<UIntListList>(property("Addresses"));
}

QString DBusIP4ConfigInterface::gateway() const
{
    return qvariant_cast<QString>(property("Gateway"));
}

QString DBusIP4ConfigInterface::domains() const {
   return QHostInfo::localDomainName();
}
