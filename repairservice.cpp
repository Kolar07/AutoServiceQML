#include "repairservice.h"

RepairService::RepairService() {}

RepairService::RepairService(int _id, int _mileage, int _interval_km,QString date,  QString _interval_time, const QString &_service, const QString &_type): MaintenanceService(_id,_mileage,_interval_km, date,_interval_time,_service,_type)
{}

RepairService::RepairService(int _mileage, int _interval_km,QString date,  QString _interval_time, const QString &_service, const QString &_type)
:MaintenanceService(_mileage,_interval_km,date, _interval_time,_service,_type){}

QString RepairService::getCustomParts() const
{
    return customParts;
}

void RepairService::setCustomParts(const QString &newParts)
{
    customParts = newParts;
}


