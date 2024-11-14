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

    //CUSTOMER
    bool addCustomer(QString name, QString surname, QString email, QString password);
    bool changeCustomerPassword(int &customerId, QString &newPassword);
    QMap<QString, QVariant> getCustomerByEmail(QString &email);
    bool fetchVehiclesForCustomer(Customer &currentCustomer);


    //VEHICLE TYPE
    Q_INVOKABLE bool addVehicleType(QString type);
    Q_INVOKABLE bool fetchVehicleTypes();


    //VEHICLE
    Q_INVOKABLE bool addVehicle(int customerId, QString mark, QString model, QString year, QString version, QString engine, int typeId, QString type, QString vin, QString registrationNumber);
    bool addVehicle(int customerId, Vehicle vehicle);
    Q_INVOKABLE bool checkVin(QString vin);
    Q_INVOKABLE bool checkRegistration(QString registration);
    Q_INVOKABLE bool removeVehicle(int id);
    Q_INVOKABLE bool updateVehicle(int vehicleId, QString mark, QString model, QString year, QString version, QString engine, int typeId, QString type, QString vin, QString registrationNumber);
    //Q_INVOKABLE bool fetchVehicles(int customer_id);

    //SERVICE
    Q_INVOKABLE bool addService(int vehicle_id, QString mileage, QString type, QString interval_km, QString service_date,QString interval_time, QString service, QString oil,QString oilFilter, QString airFilter, QString cabinFilter, QString timing, QString customParts);

 signals:
    void vehicleTypesFetched(QVector<QPair<int, QString>> vehicleTypes);
    void vehiclesFetched(QVector<Vehicle*> vehiclesVector); //fetched vehicles for customer
    void servicesFetched(int vehicleId, QVector<std::shared_ptr<Service>> services); //fetches services for vehicle



    public slots:
    void registrationSuccess(const QString &name, const QString &surname, const QString &email, const QString &password);
    //void customerPasswordChanged(const int &id, const QString &newPassword);

    void onFetchVehicles(int customerId); //from customer's signal fetchVehicles
    void onFetchServices(int vehicleId); //from vehicle's signal fetchServices

private:
    QSqlDatabase db;

signals:
};

#endif // DATABASECONTROLLER_H
