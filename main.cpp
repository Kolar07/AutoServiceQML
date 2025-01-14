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
#include "validationcontroller.h"
#include "notificationmodel.h"
#include "notification.h"
#include "reportsgenerator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    RegisterController registerController;


    DatabaseController dbController("localhost","autoservice_user","autoservice_psw", "db_autoservice");
    dbController.open();
    dbController.init();
    QObject::connect(&registerController,&RegisterController::registrationSuccess,
                                        &dbController,&DatabaseController::registrationSuccess);

    Customer customer;
    LoginController logController(&customer,&dbController);
    SessionController session;

    NotificationModel notifModel;
    QObject::connect(&logController, &LoginController::successfullyLogged,
                                         &session, &SessionController::successfullyLogged);
    VehicleTypeContainer vehicleTypeContainer;

    QObject::connect(&dbController, &DatabaseController::vehicleTypesFetched,
                    &vehicleTypeContainer, &VehicleTypeContainer::onVehicleTypesFetched);

    QObject::connect(&customer, &Customer::fetchVehicles,
                     &dbController, &DatabaseController::onFetchVehicles);

    QObject::connect(&dbController, &DatabaseController::vehiclesFetched,
                     &customer, &Customer::onVehiclesFetched);

    QObject::connect(&customer, &Customer::fetchServicesVersionSpecifiedVehicle,
                     &dbController, &DatabaseController::onServicesFetchVersionSpecifiedVehicle);

    QObject::connect(&dbController, &DatabaseController::servicesFetchedVersionSpecifiedVehicle,
                     &customer, &Customer::onServicesFetchedVersionSpecifiedVehicle);

    QObject::connect(&notifModel, &NotificationModel::fetchNotifications,
                     &dbController, &DatabaseController::onFetchNotifications);

    QObject::connect(&dbController, &DatabaseController::notificationsFetched,
                     &notifModel, &NotificationModel::onNotificationsFetched);


    ValidationController valid;

     ReportsGenerator reportsGenerator;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("loginController", &logController);
    engine.rootContext()->setContextProperty("registerController", &registerController);
    engine.rootContext()->setContextProperty("sessionController", &session);
    engine.rootContext()->setContextProperty("vehicleTypeModel", &vehicleTypeContainer);
    engine.rootContext()->setContextProperty("customer", &customer);
    engine.rootContext()->setContextProperty("valid", &valid);
    engine.rootContext()->setContextProperty("dbController", &dbController);
    engine.rootContext()->setContextProperty("notifModel", &notifModel);
    engine.rootContext()->setContextProperty("reportsGenerator", &reportsGenerator);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("AutoServiceQML", "Main");


    return app.exec();
}
