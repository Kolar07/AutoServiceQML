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

    //TESTING
    //
    RegisterController registerController;


    DatabaseController dbController("localhost","autoservice_user","autoservice_psw", "db_autoservice");
    //dbController.init();
    dbController.open();
    dbController.init();
    QObject::connect(&registerController,&RegisterController::registrationSuccess,
                                        &dbController,&DatabaseController::registrationSuccess);

    Customer customer;
    LoginController logController(&customer,&dbController);
    SessionController session;

    //logController.login("blablabla@gmail.com","testtest123");
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

    // QDate date(2023, 12, 5);
    // Notification notif1(date,150050,12,15000,"Oil and filters change", "MaintenanceService", "SMI5JU9");
    // QVector<Notification*> vector;
    // vector.append(&notif1);

    //notifModel.setData(vector);
    //dbController.addNotification(date,150050,12,15000,40,"Oil and filters change", "MaintenanceService", "WW1354");


     // dbController.fetchVehicleTypes();
     // emit customer.fetchVehicles(customer.getId());
     // emit notifModel.fetchNotifications();


    //dbController.addVehicle(customer.getId(),"Mercedes","xyzxyz",2020,"xyzxyz","xyzxyz",1,"Truck","sad464asd56sad","SMIK8I1");
    //VehicleType typeTest;
    //typeTest.setProperties(vehicleTypeContainer.get(0));
    //VehicleType typeTest2;
    //typeTest2.setProperties(vehicleTypeContainer.get(0));
    // typeTest.print();
    //Vehicle *vehicle = new Vehicle(typeTest,"Mercedes","xyzxyz",2020,"xyzxyz","xyzxyz","sad464asd56sad","SMIK8I1");
    //Vehicle *vehicle2 = new Vehicle(typeTest2,"Peugeot","sdcdscdc",2020,"sdfsdf","sdfsdf","sdgdfhgfdhfghfdg","SMI45I1");

    // std::shared_ptr<Service> service = std::make_shared<RepairService>(100500,15000,"2024-10-10",36,"Xyz change", "RepairService", "some parts");
    // service->setId(8);
    // qDebug()<<service->getId();
    //QVector<std::shared_ptr<Service>> vectorServices;
    //vectorServices.push_back(service);
    //if (vehicle->getServices()) {
    //   vehicle->getServices()->setData(vectorServices);
    //} else {
    //   qDebug() << "services is nullptr";
    //}
    //QVector<Vehicle*> vector;
    //vector.push_back(vehicle);
    //qDebug()<<vector.size();
    //vector.push_back(vehicle2);
    //qDebug()<<vector.size();

     //customer.getVehicles()->setData(vector);

    ValidationController valid;



    // QDate date;
    // date.setDate(2024,10,22);
    // std::shared_ptr<Service> service = std::make_shared<RepairService>(100500,15000,"2024-10-10","36","Xyz change", "RepairService");
    //qDebug()<<service->getServiceDate().toString();
    //vehicle.addService(service);
    //dbController.addVehicle(customer.getId(),"Mercedes","xyzxyz",2020,"xyzxyz","xyzxyz","sad464asd56sad","SMIK8I1",typeTest.getId());
    //qDebug()<<"Getting interval: "<<service->getInterval_time().toString();
    //dbController.addService(6,100500,"RepairService",15000,service->getServiceDate().toString("yyyy-MM-dd"),service->getInterval_time().toString("yyyy-MM-dd"),"Xyz change","","","","","");
    //
    //END OF TESTING
    //

     ReportsGenerator reportsGenerator;
     //reportsGenerator.generateServicesCSV(customer,"C:\\Users\\jakub\\OneDrive\\Pulpit\\testtest", "xyz");
     //reportsGenerator.generateVehiclesCSV(customer,"C:\\Users\\jakub\\OneDrive\\Pulpit\\testtest", "xyz");
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
