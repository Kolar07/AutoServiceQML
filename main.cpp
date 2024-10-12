#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QDebug>
#include <QQmlContext>
#include "registercontroller.h"
#include "databasecontroller.h"
#include "logincontroller.h"
#include "sessioncontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    //TESTING
    //

    RegisterController test;
    QString name = "kuba";
    QString surname = "kolarczyk";
    QString email = "kubakolarczyk@gmail.com";
    QString psw = "123456789";



    DatabaseController dbController("localhost","root","root", "db_autoservice");
    dbController.open();
    bool isConnected = QObject::connect(&test,&RegisterController::registrationSuccess,
                                        &dbController,&DatabaseController::registrationSuccess);

    Customer customer;
    LoginController logController(&customer,&dbController);
    SessionController session;
    bool isConnected2 = QObject::connect(&logController, &LoginController::successfullyLogged,
                                         &session, &SessionController::successfullyLogged);

    //logController.login(email,psw);
    //test.registerCustomer(name,surname,email,psw);

    //dbController.close();
    //dbController.addCustomer(name,surname,email,test.hashPassword(psw,salt));
    //dbController.close();

    //
    //END OF TESTING
    //


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("loginController", &logController);
    engine.rootContext()->setContextProperty("sessionController", &session);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("AutoServiceQML", "Main");


    return app.exec();
}
