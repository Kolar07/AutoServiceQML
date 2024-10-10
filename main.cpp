#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QDebug>
#include "registercontroller.h"
#include "databasecontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    //TESTING
    RegisterController test;
    QString name = "Jakub43";
    QString surname = "Kolarczyk43";
    QString email = "jakubkolarczyk@gmail.com43";
    QString psw = "kochamKasdfrodsflinke1df23123123";



    DatabaseController dbController("localhost","root","root", "db_autoservice");
    dbController.open();
    bool isConnected = QObject::connect(&test,&RegisterController::registrationSuccess,
                     &dbController,&DatabaseController::registrationSuccess);
    if (!isConnected) {
        qDebug() << "Failed to connect signal and slot";
    } else {
        qDebug() << "Signal and slot connected successfully";
    }
    test.registerCustomer(name,surname,email,psw);
    dbController.close();
    //dbController.addCustomer(name,surname,email,test.hashPassword(psw,salt));
    //dbController.close();
    //END OF TESTING



    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("AutoServiceQML", "Main");


    return app.exec();
}
