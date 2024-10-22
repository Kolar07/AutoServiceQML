#ifndef DATABASECONTROLLER_H
#define DATABASECONTROLLER_H

#include <QObject>
#include <QtSql/QSqlDatabase>
#include <QDebug>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlRecord>
#include <QDate>

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


    //VEHICLE TYPE
    bool fetchVehicleTypes();


    //VEHICLE
    bool addVehicle(int customerId, QString mark, QString model, int year, QString version, QString engine, QString vin, QString registrationNumber, int typeId);

    //SERVICE
    bool addService(int vehicle_id, int mileage, QString type, int interval_km, QDate interval_time, QString service, QString oil,QString oilFilter, QString airFilter, QString cabinFilter, QString timing);

 signals:
    void vehicleTypesFetched(QVector<QPair<int, QString>> vehicleTypes);

    public slots:
    void registrationSuccess(const QString &name, const QString &surname, const QString &email, const QString &password);
    //void customerPasswordChanged(const int &id, const QString &newPassword);

private:
    QSqlDatabase db;

signals:
};

#endif // DATABASECONTROLLER_H
