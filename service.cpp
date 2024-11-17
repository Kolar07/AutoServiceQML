#include "service.h"

Service::Service(QObject *parent)
    : QObject{parent}
{}



Service::Service(int _id, int _milleage, QString _type, QString date) : id(_id),
    mileage(_milleage), type(_type)
{
    QDate temp = QDate::fromString(date,"yyyy-MM-dd");
    qDebug()<<"Date input: "<<date;
    if(!temp.isValid()){
        qDebug()<<"Wrong date format!";
    } else serviceDate = temp;

}

Service::Service(int _mileage, QString _type, QString date): mileage(_mileage), type(_type)
{
    QDate temp = QDate::fromString(date,"yyyy-MM-dd");
    qDebug()<<"Date input: "<<date;
    if(!temp.isValid()){
        qDebug()<<"Wrong date format!";
    } else serviceDate = temp;

}

int Service::getId() const
{
    return id;
}

void Service::setId(int newId)
{
    id = newId;
}

int Service::getMileage() const
{
    return mileage;
}

void Service::setMilleage(int newMilleage)
{
    mileage = newMilleage;
}

QString Service::getType() const
{
    return type;
}

void Service::setType(const QString &newType)
{
    type = newType;
}

QDate Service::getServiceDate() const
{
    return serviceDate;
}

void Service::setServiceDate(const QDate &newServiceDate)
{
    serviceDate = newServiceDate;
}
