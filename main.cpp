#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QDebug>
#include <QQmlContext>
#include "registercontroller.h"
#include "databasecontroller.h"
#include "logincontroller.h"
#include "sessioncontroller.h"
#include "service.h"
#include "maintenanceservice.h"
#include "repairservice.h"
#include "vehicletypecontainer.h"
#include "vehicletype.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    //TESTING
    //
    RegisterController registerController;


    DatabaseController dbController("localhost","root","root", "db_autoservice");
    dbController.open();
    bool isConnected = QObject::connect(&registerController,&RegisterController::registrationSuccess,
                                        &dbController,&DatabaseController::registrationSuccess);

    Customer customer;
    LoginController logController(&customer,&dbController);
    SessionController session;
    bool isConnected2 = QObject::connect(&logController, &LoginController::successfullyLogged,
                                         &session, &SessionController::successfullyLogged);
    VehicleTypeContainer vehicleTypeContainer;

    QObject::connect(&dbController, &::DatabaseController::vehicleTypesFetched,
                    &vehicleTypeContainer, &VehicleTypeContainer::onVehicleTypesFetched);
    dbController.fetchVehicleTypes();
    VehicleType typeTest;
    typeTest.setProperties(vehicleTypeContainer.get(0));
    typeTest.print();
    //
    //END OF TESTING
    //


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("loginController", &logController);
    engine.rootContext()->setContextProperty("registerController", &registerController);
    engine.rootContext()->setContextProperty("sessionController", &session);
    engine.rootContext()->setContextProperty("vehicleTypeModel", &vehicleTypeContainer);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("AutoServiceQML", "Main");


    return app.exec();
}
