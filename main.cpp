#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QDebug>
#include "registercontroller.h"
#include "databasecontroller.h"
#include "logincontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    //TESTING
    RegisterController test;
    QString name = "kuba";
    QString surname = "kolarczyk";
    QString email = "kubakolarczyk@gmail.com";
    QString psw = "123456789";



    DatabaseController dbController("localhost","root","root", "db_autoservice");
    dbController.open();
    bool isConnected = QObject::connect(&test,&RegisterController::registrationSuccess,
                     &dbController,&DatabaseController::registrationSuccess);
    if (!isConnected) {
        qDebug() << "Failed to connect signal and slot";
    } else {
        qDebug() << "Signal and slot connected successfully";
    }
    Customer customer;
    LoginController logController(&customer,&dbController);
    logController.login(email,psw);
    customer.print();
    //test.registerCustomer(name,surname,email,psw);
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
