#include "notification.h"

Notification::Notification(QObject *parent)
    : QObject{parent}
{}

Notification::Notification(QDate _serviceDate,int _mileage, int _intervalMonths, int _intervalKm, QString _service, QString _serviceType, QString _vehicleRegistration):serviceDate(_serviceDate),
    service(_service), serviceType(_serviceType),vehicleRegistration(_vehicleRegistration)
{
    nextServiceDate = _serviceDate.addMonths(_intervalMonths);
    nextServiceKm = _mileage + _intervalKm;
    qDebug()<<"Next service date: "<<nextServiceDate.toString();
}

Notification::Notification(int _id,QDate _serviceDate,QDate _nextServiceDate, int _nextServiceKm, QString _service,QString _serviceType, QString _vehicleRegistration):id(_id),serviceDate(_serviceDate),
    nextServiceDate(_nextServiceDate), nextServiceKm(_nextServiceKm),service(_service), serviceType(_serviceType),vehicleRegistration(_vehicleRegistration)
{

    qDebug()<<"Next service date: "<<nextServiceDate;
}

int Notification::getId() const
{
    return id;
}

void Notification::setId(int newId)
{
    id = newId;
}

QDate Notification::getServiceDate() const
{
    return serviceDate;
}

void Notification::setServiceDate(const QDate &newServiceDate)
{
    serviceDate = newServiceDate;
}

QString Notification::getServiceDateString() const
{
    return serviceDate.toString("dd-MM-yyyy");
}

QString Notification::getService() const
{
    return service;
}

void Notification::setService(const QString &newService)
{
    service = newService;
}

QString Notification::getServiceType() const
{

    if(serviceType == "MaintenanceService")
        return "MAINTENANCE SERVICE";
    else if (serviceType == "RepairService")
        return "REPAIR SERVICE";
    else if (serviceType == "ServiceOil")
        return "OIL SERVICE";
    else if (serviceType == "ServiceTiming")
        return "TIMING SERVICE";
    else return serviceType.toUpper();
}

void Notification::setServiceType(const QString &newServiceType)
{
    serviceType = newServiceType;
}

QString Notification::getVehicleRegistration() const
{
    return vehicleRegistration;
}

void Notification::setVehicleRegistration(const QString &newVehicleRegistration)
{
    vehicleRegistration = newVehicleRegistration;
}

QString Notification::getDaysLeft() const
{
    QDate today = QDate::currentDate();
    return QString::number(today.daysTo(nextServiceDate));
}

QString Notification::getColor() const
{
    if(nextServiceDate.isValid()) {
    int temp = getDaysLeft().toInt();
    if(temp <=1)
        return "#FF6347";
    else if(temp <=14)
        return "#FFA500";
    else return "#90EE90";
    } else return "#8fccf7";
}

QDate Notification::getNextServiceDate() const
{
    return nextServiceDate;
}

void Notification::setNextServiceDate(const QDate &newNextServiceDate)
{
    nextServiceDate = newNextServiceDate;
}

QString Notification::getNextServiceDateString() const
{
    return nextServiceDate.toString("dd-MM-yyyy");
}

int Notification::getNextServiceKm() const
{
    return nextServiceKm;
}

void Notification::setNextServiceKm(int newNextServiceKm)
{
    nextServiceKm = newNextServiceKm;
}
