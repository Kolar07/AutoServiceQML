#include "repairservice.h"

RepairService::RepairService() {}

RepairService::RepairService(int _id, int _mileage, int _interval_km, const QDate &_interval_time, const QString &_service, const QString &_type): MaintenanceService(_id,_mileage,_interval_km, _interval_time,_service,_type)
{}
