#include "repairservice.h"

RepairService::RepairService() {}

RepairService::RepairService(int _id, int _mileage, int _interval_km,QString date, int _interval_time, const QString &_service, const QString &_type, const QString _customParts, const QString &_note): MaintenanceService(_id,_mileage,_interval_km, date,_interval_time,_service,_type, _note), customParts(_customParts)
{}

RepairService::RepairService(int _mileage, int _interval_km,QString date,  int _interval_time, const QString &_service, const QString &_type, const QString _customParts, const QString &_note)
    :MaintenanceService(_mileage,_interval_km,date, _interval_time,_service,_type,_note), customParts(_customParts){}

QString RepairService::getCustomParts() const
{
    qDebug()<<"Returning custom parts";
    return customParts;
}

void RepairService::setCustomParts(const QString &newParts)
{
    customParts = newParts;
}


