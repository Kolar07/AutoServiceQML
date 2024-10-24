#include "vehicle.h"

Vehicle::Vehicle(QObject *parent)
    : QObject{parent}
{}

//Vehicle::Vehicle(){}


int Vehicle::getId() const
{
    return id;
}

void Vehicle::setId(int newId)
{
    id = newId;
}

QString Vehicle::getMark() const
{
    return mark;
}

void Vehicle::setMark(const QString &newMark)
{
    mark = newMark;
}

QString Vehicle::getModel() const
{
    return model;
}

void Vehicle::setModel(const QString &newModel)
{
    model = newModel;
}

int Vehicle::getYear() const
{
    return year;
}

void Vehicle::setYear(int newYear)
{
    year = newYear;
}

QString Vehicle::getVersion() const
{
    return version;
}

void Vehicle::setVersion(const QString &newVersion)
{
    version = newVersion;
}

QString Vehicle::getEngine() const
{
    return engine;
}

void Vehicle::setEngine(const QString &newEngine)
{
    engine = newEngine;
}

QString Vehicle::getVin() const
{
    return vin;
}

void Vehicle::setVin(const QString &newVin)
{
    vin = newVin;
}

QString Vehicle::getRegistrationNumber() const
{
    return registrationNumber;
}

void Vehicle::setRegistrationNumber(const QString &newRegistrationNumber)
{
    registrationNumber = newRegistrationNumber;
}

void Vehicle::addService(std::shared_ptr<Service> &service)
{
    if(service != nullptr)
        services.push_back(std::move(service));
    else qDebug()<<"Service is a nullptr";
}

void Vehicle::removeService(int serviceId)
{

}

QVector<std::shared_ptr<Service> > Vehicle::getServices() const
{
    return services;
}

std::shared_ptr<Service> Vehicle::getServiceByNumber(int nb) const
{
    if(nb>=0 && nb < services.size()) {
        return services[nb];
    } else return nullptr;
}

void Vehicle::setServices(const QVector<std::shared_ptr<Service> > &newServices)
{
    services = newServices;
}

// QVector<Service *> Vehicle::getServices() const
// {
//     return services;
// }

// void Vehicle::setServices(const QVector<Service *> &newServices)
// {
//     services = newServices;
// }

Vehicle::Vehicle(int id, const VehicleType &type, const QString &mark, const QString &model, int year, const QString &version, const QString &engine, const QString &vin, const QString &registrationNumber) : id(id),
    type(type),
    mark(mark),
    model(model),
    year(year),
    version(version),
    engine(engine),
    vin(vin),
    registrationNumber(registrationNumber)
{}

Vehicle::Vehicle(const VehicleType &type, const QString &mark, const QString &model, int year, const QString &version, const QString &engine, const QString &vin, const QString &registrationNumber)
    :type(type),
    mark(mark),
    model(model),
    year(year),
    version(version),
    engine(engine),
    vin(vin),
    registrationNumber(registrationNumber){}
