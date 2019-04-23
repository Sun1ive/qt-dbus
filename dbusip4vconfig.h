#ifndef DBUSIP4VCONFIG_H
#define DBUSIP4VCONFIG_H
#include <QList>
#include <QDBusAbstractInterface>

typedef QList<QList<uint>> UIntListList;
Q_DECLARE_METATYPE(UIntListList);


class DBusIP4ConfigInterface : public QDBusAbstractInterface
{
    Q_OBJECT

public:
    DBusIP4ConfigInterface(const QString &service, const QString &path, const QDBusConnection &connection,
                           QObject *parent = nullptr);
    virtual ~DBusIP4ConfigInterface();

    Q_PROPERTY(UIntListList Addresses READ addresses)
    UIntListList addresses() const;

    Q_PROPERTY(QString Gateway READ gateway)
    QString gateway() const;


Q_SIGNALS:
    void PropertiesChanged(const QVariantMap &properties);
};



#endif // DBUSIP4VCONFIG_H

