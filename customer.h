#ifndef CUSTOMER_H
#define CUSTOMER_H

#include <QObject>
#include "vehicle.h"
#include <QDebug>
#include <vehiclemodel.h>

class Customer : public QObject
{
    Q_OBJECT
public:
    explicit Customer(QObject *parent = nullptr);
    ~Customer();

    QString getName() const;
    void setName(const QString &newName);

    QString getSurname() const;
    void setSurname(const QString &newSurname);

    QString getEmail() const;
    void setEmail(const QString &newEmail);

    QString getPassword() const;
    void setPassword(const QString &newPassword);

    Q_INVOKABLE int getId() const;
    void setId(int newId);
    void print() const;

    Q_INVOKABLE VehicleModel *getVehicles();
    void setVehicles(VehicleModel *_vehicles);

public: signals:
    void fetchVehicles(int customerId);

    void fetchServicesVersionSpecifiedVehicle(int vehicleId);

public slots:
    void onVehiclesFetched(QVector<Vehicle*> vehiclesVector);
    void onServicesFetchedVersionSpecifiedVehicle(int vehicleId,QVector<std::shared_ptr<Service>> services);

private:
    int id;
    QString name;
    QString surname;
    QString email;
    QString password;
    VehicleModel *vehicles;
};

#endif // CUSTOMER_H
