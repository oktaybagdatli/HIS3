#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <slidemanager.h>

int main(int argc, char *argv[])
{
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
