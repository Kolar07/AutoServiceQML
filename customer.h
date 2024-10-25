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

    QString getName() const;
    void setName(const QString &newName);

    QString getSurname() const;
    void setSurname(const QString &newSurname);

    QString getEmail() const;
    void setEmail(const QString &newEmail);

    QString getPassword() const;
    void setPassword(const QString &newPassword);

    int getId() const;
    void setId(int newId);
    void print() const;

    Q_INVOKABLE VehicleModel *getVehicles();

    void setVehicles(VehicleModel *newVehicles);

private:
    int id;
    QString name;
    QString surname;
    QString email;
    QString password;
    VehicleModel *vehicles;
};

#endif // CUSTOMER_H
