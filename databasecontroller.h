#ifndef DATABASECONTROLLER_H
#define DATABASECONTROLLER_H

#include <QObject>
#include <QtSql/QSqlDatabase>
#include <QDebug>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlRecord>

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


    //VEHICLE TYPES
    bool fetchVehicleTypes();


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
