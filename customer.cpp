#include "customer.h"

Customer::Customer(QObject *parent)
    : QObject{parent}, vehicles(new VehicleModel(this))
{    }

Customer::~Customer()
{
    vehicles->deleteLater();
}
QString Customer::getName() const
{
    return name;
}

void Customer::setName(const QString &newName)
{
    name = newName;
}

QString Customer::getSurname() const
{
    return surname;
}

void Customer::setSurname(const QString &newSurname)
{
    surname = newSurname;
}

QString Customer::getEmail() const
{
    return email;
}

void Customer::setEmail(const QString &newEmail)
{
    email = newEmail;
}

QString Customer::getPassword() const
{
    return password;
}

void Customer::setPassword(const QString &newPassword)
{
    password = newPassword;
}

int Customer::getId() const
{
    return id;
}

void Customer::setId(int newId)
{
    id = newId;
}

void Customer::print() const
{
    qDebug()<<"Customer name: "<<name<< ", surname: "<<surname<<", email: "<<email;
}

VehicleModel* Customer::getVehicles()
{
    qDebug()<<"Returning vehicles";
    return vehicles;
}

void Customer::onVehiclesFetched(QVector<Vehicle *> vehiclesVector)
{
    if(!vehiclesVector.empty())
        qDebug()<<"From customer - setting vehicles, size: "<<vehiclesVector.size();
    vehicles->setData(vehiclesVector);
    qDebug()<<"From customer - after setting vehicles: "<<vehicles->getVehicles().size();
}

void Customer::setVehicles(VehicleModel *newVehicles)
{
    if (vehicles) {
        delete vehicles;
    }
    vehicles = newVehicles;
}
