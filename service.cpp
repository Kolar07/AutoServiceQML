#include "service.h"

Service::Service(QObject *parent)
    : QObject{parent}
{}

Service::Service(int _id, int _milleage, QString _type) : id(_id),
    milleage(_milleage), type(_type)
{}

int Service::getId() const
{
    return id;
}

void Service::setId(int newId)
{
    id = newId;
}

int Service::getMilleage() const
{
    return milleage;
}

void Service::setMilleage(int newMilleage)
{
    milleage = newMilleage;
}

QString Service::getType() const
{
    return type;
}

void Service::setType(const QString &newType)
{
    type = newType;
}
