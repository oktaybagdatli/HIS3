#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <slidemanager.h>
#include <QtLogging>

int main(int argc, char *argv[])
{
    qSetMessagePattern("[%{time hh:mm:ss.zzz}][%{type}] %{if-category}%{category}: %{endif}file://%{file}:%{line} - %{message}");


    QGuiApplication app(argc, argv);
    SlideManager slideManager;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("slideManager",&slideManager);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("HIS3", "Main");

    return app.exec();
}
