#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDBusConnection>
#include <QDebug>
#include <QQmlContext>
#include "dbus.h"

using namespace std;


int main(int argc, char **argv)
{

    if(!QDBusConnection::systemBus().isConnected()) {
        qCritical() << "Cannot connect to the D-Bus session bus!";
        return EXIT_FAILURE;
    }

    Dbus dbus;

    QDBusConnection::systemBus().connect("org.freedesktop.NetworkManager", "/org/freedesktop/NetworkManager", "org.freedesktop.NetworkManager", "StateChanged", &dbus, SLOT(setState(uint)));


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setApplicationDisplayName("Hello world");

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();

    context->setContextProperty("dbus", &dbus);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
