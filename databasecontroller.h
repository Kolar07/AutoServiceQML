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
    //Q_INVOKABLE bool fetchVehicles(int customer_id);

    //SERVICE
    bool addService(int vehicle_id, int mileage, QString type, int interval_km, QString service_date,QString interval_time, QString service, QString oil,QString oilFilter, QString airFilter, QString cabinFilter, QString timing);

 signals:
    void vehicleTypesFetched(QVector<QPair<int, QString>> vehicleTypes);

     void vehiclesFetched(VehicleModel *_vehicles); //fetched vehicles for customer

    public slots:
    void registrationSuccess(const QString &name, const QString &surname, const QString &email, const QString &password);
    //void customerPasswordChanged(const int &id, const QString &newPassword);

    void onFetchVehicles(int customerId); //from customer's signal fetchVehicles

private:
    QSqlDatabase db;

signals:
};

#endif // DATABASECONTROLLER_H
