#include "vehicle.h"

Vehicle::Vehicle(QObject *parent)
    : QObject{parent}, services(new ServiceModel(this))
{}


Vehicle::Vehicle(int id, const VehicleType &type, const QString &brand, const QString &model, int year, const QString &version, const QString &engine, const QString &vin, const QString &registrationNumber) : id(id),
    type(type),
    brand(brand),
    model(model),
    year(year),
    version(version),
    engine(engine),
    vin(vin),
    registrationNumber(registrationNumber), services(new ServiceModel(this))
{}

Vehicle::Vehicle(const VehicleType &type, const QString &brand, const QString &model, int year, const QString &version, const QString &engine, const QString &vin, const QString &registrationNumber)
    :type(type),
    brand(brand),
    model(model),
    year(year),
    version(version),
    engine(engine),
    vin(vin),
    registrationNumber(registrationNumber), services(new ServiceModel(this)){}

Vehicle::~Vehicle()
{
    services->deleteLater();
}



int Vehicle::getId() const
{
    return id;
}

void Vehicle::setId(int newId)
{
    id = newId;
}

QString Vehicle::getBrand() const
{
    return brand;
}

void Vehicle::setBrand(const QString &newMark)
{
    brand = newMark;
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

// void Vehicle::addService(std::shared_ptr<Service> &service)
// {
//     if(service != nullptr)
//         services->push_back(std::move(service));
//     else qDebug()<<"Service is a nullptr";
// }

void Vehicle::removeService(int serviceId)
{

}

// QVector<std::shared_ptr<Service> > Vehicle::getServices() const
// {
//     return services;
// }

// std::shared_ptr<Service> Vehicle::getServiceByNumber(int nb) const
// {
//     if(nb>=0 && nb < services.size()) {
//         return services[nb];
//     } else return nullptr;
// }

// void Vehicle::setServices(const QVector<std::shared_ptr<Service> > &newServices)
// {
//     services = newServices;
// }

VehicleType Vehicle::getType() const
{
    return type;
}

QString Vehicle::getTypeString() const
{
    return getType().getTypeName();
}

int Vehicle::getTypeInt() const
{
    return getType().getId();
}

ServiceModel *Vehicle::getServices()
{

    if (!services) {
        qDebug() << "DEBUG - Services not initialized for vehicle!";
    }
    return services;
}

void Vehicle::setServices(ServiceModel *newServices)
{
    if (services) {
        delete services;
    }
    services = newServices;
}

void Vehicle::onFetchedServices(int vehicleId, QVector<std::shared_ptr<Service> > &servicesVector)
{
    if(!servicesVector.empty() && vehicleId == id) {
        qDebug()<<"From vehicle "<< id <<" - setting services, size: "<<servicesVector.size();
    services->setData(servicesVector);
    qDebug()<<"From vehicle "<< id <<" - after setting services: "<<services->getServices().size();
    } else return;
}



// void Vehicle::setType(const VehicleType &newType)
// {
//     type = newType;
// }

// QVector<Service *> Vehicle::getServices() const
// {
//     return services;
// }

// void Vehicle::setServices(const QVector<Service *> &newServices)
// {
//     services = newServices;
// }


