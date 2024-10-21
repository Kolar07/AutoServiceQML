#include "vehicletype.h"

VehicleType::VehicleType(QObject *parent)
    : QObject{parent}
{}

VehicleType::VehicleType(const VehicleType &other)
    : QObject(other.parent()), id(other.id),typeName(other.typeName){}

bool VehicleType::operator==(const VehicleType &other) {
    return this->id==other.id;
}

int VehicleType::getId() const
{
    return id;
}

void VehicleType::setId(int newId)
{
    id = newId;
}

QString VehicleType::getTypeName() const
{
    return typeName;
}

void VehicleType::setTypeName(const QString &newTypeName)
{
    typeName = newTypeName;
}

void VehicleType::setProperties(QVariantMap vehicleTypeData)
{
    if (vehicleTypeData.contains("id") && vehicleTypeData["id"].canConvert<int>()) {
        setId(vehicleTypeData["id"].toInt());
    }

    if (vehicleTypeData.contains("typeName") && vehicleTypeData["typeName"].canConvert<QString>()) {
        setTypeName(vehicleTypeData["typeName"].toString());
    }
}

void VehicleType::print() const
{
    qDebug()<<"id: "<<id<<" type; "<<typeName;
}
