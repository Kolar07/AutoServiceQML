#ifndef DATABASECONTROLLER_H
#define DATABASECONTROLLER_H

#include <QObject>
#include <QtSql/QSqlDatabase>
#include <QDebug>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlRecord>
#include <QDate>
#include "vehicle.h"
#include "customer.h"
#include "service.h"
#include "maintenanceservice.h"
#include "repairservice.h"
#include "serviceoil.h"
#include "servicetiming.h"

class DatabaseController : public QObject
{
    Q_OBJECT
public:
    DatabaseController(const QString &hostname, const QString &username, const QString &password, const QString &dbName);
    ~DatabaseController();

    bool open();
    void close();
    void init();
    bool executeQuery(const QString &query);

    //CUSTOMER
    bool addCustomer(QString name, QString surname, QString email, QString password);
    bool changeCustomerPassword(int &customerId, QString &newPassword);
    QMap<QString, QVariant> getCustomerByEmail(QString &email);
    bool fetchVehiclesForCustomer(Customer &currentCustomer);


    //VEHICLE TYPE
    Q_INVOKABLE bool addVehicleType(QString type);
    Q_INVOKABLE bool fetchVehicleTypes();


    //VEHICLE
    Q_INVOKABLE bool addVehicle(int customerId, QString brand, QString model, QString year, QString version, QString engine, int typeId, QString type, QString vin, QString registrationNumber);
    bool addVehicle(int customerId, Vehicle vehicle);
    Q_INVOKABLE bool checkVin(QString vin);
    Q_INVOKABLE bool checkRegistration(QString registration);
    Q_INVOKABLE bool removeVehicle(int id);
    Q_INVOKABLE bool removeMultipleVehicles(QVector<int> vehiclesIds);
    Q_INVOKABLE bool updateVehicle(int vehicleId, QString brand, QString model, QString year, QString version, QString engine, int typeId, QString type, QString vin, QString registrationNumber);
    //Q_INVOKABLE bool fetchVehicles(int customer_id);

    //SERVICE
    Q_INVOKABLE bool addService(int vehicle_id, QString mileage, QString type, QString interval_km, QString service_date, QString interval_time, QString service, QString oil, QString oilFilter, QString airFilter, QString cabinFilter, QString timing, QString customParts, QString note, QString _vehicleRegistration);
    Q_INVOKABLE bool updateService(int serviceId, QString mileage, QString interval_km,QString interval_time, QString service, QString oil,QString oilFilter, QString airFilter, QString cabinFilter, QString timing, QString customParts,QString note);
    Q_INVOKABLE bool removeService(int serviceId);
    Q_INVOKABLE bool removeMultipleServices(QVector<int> serviceIds);

    //NOTIFICATIONS
    Q_INVOKABLE bool addNotification(QDate _serviceDate,QString _mileage, QString _intervalMonths,QString _intervalKm, int _serviceId, QString _service,QString _serviceType, QString _vehicleRegistration);
    //Q_INVOKABLE bool addNotificationWithInts(QDate _serviceDate,int _mileage, int _intervalMonths,int _intervalKm, int _serviceId, QString _service,QString _serviceType, QString _vehicleRegistration);

    Q_INVOKABLE bool removeNotification(int notificationId);
    Q_INVOKABLE bool updateNotificationWithService(int serviceId);


 signals:
    void vehicleTypesFetched(QVector<QPair<int, QString>> vehicleTypes);
    void vehiclesFetched(QVector<Vehicle*> &vehiclesVector); //fetched vehicles for customer
    void servicesFetched(int vehicleId, QVector<std::shared_ptr<Service>> &services); //fetches services for vehicle

    void servicesFetchedVersionSpecifiedVehicle(int vehicleId, QVector<std::shared_ptr<Service>> &services); //fetches services for specified vehicle

    void notificationsFetched(QVector<Notification*> &_notifications);


    public slots:
    void registrationSuccess(const QString &name, const QString &surname, const QString &email, const QString &password);
    //void customerPasswordChanged(const int &id, const QString &newPassword);
    void onFetchVehicles(int customerId); //from customer's signal fetchVehicles
    void onFetchServices(int vehicleId); //from vehicle's signal fetchServices

    void onServicesFetchVersionSpecifiedVehicle(int vehicleId);

    void onFetchNotifications();

private:
    QSqlDatabase db;

signals:
};

#endif // DATABASECONTROLLER_H
