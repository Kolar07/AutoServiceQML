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
    //qDebug()<<"Returning vehicles";
    return vehicles;
}

void Customer::onVehiclesFetched(QVector<Vehicle *> &vehiclesVector)
{
    //if(!vehiclesVector.empty()) {
        qDebug()<<"From customer - setting vehicles, size: "<<vehiclesVector.size();
    vehicles->setData(vehiclesVector);
    qDebug()<<"From customer - after setting vehicles: "<<vehicles->getVehicles().size();
    qDebug()<<"Vehicles services size: ";
    // for(int i = 0; i<vehicles->getVehicles().size(); i++) {
    //     qDebug()<<vehicles->getVehicleByRow(i)->getServices()->getServices().size();
    // }
    //}
}

void Customer::onServicesFetchedVersionSpecifiedVehicle(int vehicleId, QVector<std::shared_ptr<Service> > &services)
{
    qDebug()<<"DEBUG - FROM CUSTOMER NOW SETTING DATA";
    vehicles->getVehicleById(vehicleId)->getServices()->setData(services);
}

void Customer::setVehicles(VehicleModel *newVehicles)
{
    if (vehicles) {
        qDebug() << "DEBUG - Deleting old vehicles model.";
        delete vehicles;
    }
    vehicles = newVehicles;
    qDebug() << "DEBUG - New vehicles model set.";
}
